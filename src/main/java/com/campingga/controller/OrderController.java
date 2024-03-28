package com.campingga.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.campingga.domain.Common;
import com.campingga.domain.Goods;
import com.campingga.dto.req.NewOrder;
import com.campingga.dto.req.UpdateCartItem;
import com.campingga.dto.res.AjaxRes;
import com.campingga.dto.res.PaymentItem;
import com.campingga.service.CartService;
import com.campingga.service.GoodsService;
import com.campingga.service.OrderService;

import lombok.extern.slf4j.Slf4j;

@Slf4j // Lombok을 사용하여 로그를 위한 Logger를 생성
@Controller // Spring MVC 컨트롤러임을 나나태는 어노테이션
@RequestMapping("/order/*") // 이 컨트롤러의 기본 URL 경로 설정
public class OrderController {
	@Autowired
	CartService cartService;

	@Autowired // 의존성 주입을 위한 어노테이션
	OrderService orderService; // CartService 의존성 주입

	@Autowired // 의존성 주입을 위한 어노테이션
	GoodsService goodsService; // OrderService  의존성 주입

	// 새 주문을 생서하는 핸들러
	@PostMapping("new1")// "/order/new2" 경로로 POST 요청을 보내면 이 핸들러가 실행되어 주문을 생성하고 응답을 반환
	@ResponseBody // 응답을 http 응답 본문에 직접 작성하도록 지정
	public AjaxRes newOrder(@RequestBody List<NewOrder> cartList) {
		String id = null;
		
		// 로그인 유저 체크 - 현재인증된 사용자 정보 가져오기
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth.getName() == null || auth.getName().equals("") || auth.getName().equals("anonymousUser")) {
			// 미로그인 상태일 경우
			return AjaxRes.builder().status("FAIL").message("Not logged in").build();
		}
		
		id = auth.getName(); //인증된 사용자의 아이디
		PaymentItem paymentItem = orderService.newOrder(id,cartList); // 주문 생성
		if(paymentItem == null) {
		  // 주문 생성 실패 시 처리
		}
		
		return AjaxRes.builder().status("SUCCESS").data(paymentItem).build(); // 성공적으로 주문 생성한 경우 응답 반환
	}
	
	// 새주문을 생성하는 핸들러 ( 위 핸들러와 동일한 기능)
	@PostMapping("new2")
	@ResponseBody // 응답을 HTTP 응답 본문에 직접 작성하도록 지정 
	public AjaxRes newOrder2(@RequestBody List<NewOrder> cartList) {
		String id = null;
		
		// 로그인 유저 체크 - 인증된 사용자 정보 가져오기
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth.getName() == null || auth.getName().equals("") || auth.getName().equals("anonymousUser")) {
			// 미로그인 상태일 경우
			return AjaxRes.builder().status("FAIL").message("Not logged in").build();
		}
		
		id = auth.getName(); // 인증된 사용자의 아이디
		PaymentItem paymentItem = orderService.newOrder(id,cartList); // 주문 생성
		if(paymentItem == null) {
		  // 주문 생성 실패 시 처리
		}
		
		return AjaxRes.builder().status("SUCCESS").data(paymentItem).build(); // 성공적으로 주문 생성한 경우 응답 반환
	}
	
	
	// 장바구니 업데이트를 처리하는 핸들러
	@PostMapping("updateCart")
	@ResponseBody // 응답을 HTTP 응답 본문에 직접 작성하도록 지정
	public AjaxRes updateCart(@RequestBody UpdateCartItem cartItem) {
		String id = null;
		
		// 로그인 유저 체크
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth.getName() == null || auth.getName().equals("") || auth.getName().equals("anonymousUser")) {
			// 미로그인 상태
			return AjaxRes.builder().status("FAIL").message("Not logged in").build();
		}
		
		id = auth.getName(); // 인증된 사용자 아이디
		if(cartService.updateCart(id, cartItem)) {
			return AjaxRes.builder().status("SUCCESS").build();	// 장바구니 업데이트 성공 시 응답 반환		
		} else {
			return AjaxRes.builder().status("FAIL").message("Cannot find user.").build(); // 사용자를 찾을 수 없는 경우 실패 응답 반환
	
		}
	}
	
	// 주문 목록을 조회하는 핸들러
	@GetMapping("/list.do")
	public String main(Model model, Common common) {
		
	  // 현재 인증된 사용자 정보 가져오기
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		
		String userId = auth.getName(); // 인증된 사용자의 아이디

		common.setMemId(userId); // common 객체에 사용자 아이디 설정
		
		List<Goods> list = goodsService.getGoodsOrderList(common); // 주문목록 조회
		
		model.addAttribute("list", list); // 뷰에 주문 목록 전달
		
		return "order/list"; // 주문목록을 order/list 뷰에 반환
	}
	
}
