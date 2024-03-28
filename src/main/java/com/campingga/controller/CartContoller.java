package com.campingga.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.campingga.domain.Cart;
import com.campingga.dto.res.CartItem;
import com.campingga.dto.res.CartPutitem;
import com.campingga.service.CartService;

import lombok.extern.log4j.Log4j;

@Log4j // Logj 로길 사용을 위한 어노테이션
@Controller // Spring MVC 컨트롤러임을 나타내는 어노데이션
@RequestMapping("/cart") // 컨트롤러의 기본 URL 경로 설정
public class CartContoller {
	
	@Autowired // 의존성 주입을 위한 어노테이션
	CartService cartService; // CartService 의존성 주입
	
	// 장바구니 페이지를 불러오는 핸들러
	@GetMapping("/view")
	public String viewCart(Model model) {
		//로그인 유저 체크- 현재인증된 사용자 정보 가져오기
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();		
		
		String userId = auth.getName(); //현재인증된 사용자의 아이디
		List<CartItem> cartList = cartService.getCartItemList(userId); // 해당사용자의 장바구니 목록 가져오기
	
		// 뷰에 전달할 데이터 설정
		model.addAttribute("cartItemList", cartList); // 장바구니 목록
		model.addAttribute("cartype", 1); // 카트 타입
		
		return "cart"; // 뷰 이름 반환 
	}
	
	// 선택한 상품을 바로 장바구니로 추가하는 핸들러
	@GetMapping("/direct")
	public String viewDirectCart(@RequestParam("cart_no") List<Integer> cartNoList, Model model) {
		
	  // 선택한 상품들의 장바구니 정보 가져오기
		List<CartItem> cartList = cartService.getDirectCartItem(cartNoList);  
	
		// 뷰에 전달할 데이터 설정
		model.addAttribute("cartItemList", cartList); // 장바구니 목록
		model.addAttribute("cartype", 2); // 카트 타입
		
		return "cart"; // View 이름 반환 
	}
	
	// 장바구니에 상품 추가하는 핸들러
	@PostMapping(path="/putCart", consumes = MediaType.APPLICATION_JSON_VALUE) //JSON 요청을 처리하는 POST 핸들러
	@ResponseBody // 응답을 HTTP응답 본문에 직접 작성하도록 지정
	public CartPutitem putCart(@RequestBody List<Cart> jsonData, HttpServletResponse response) throws IOException {
		log.info("putcart 실행"); // 로그 기록
		Authentication auth = SecurityContextHolder.getContext().getAuthentication(); // 현재 사용자의 인증정보 가져오기
		List<Integer> list = new ArrayList<Integer>(); // 장바구니 번호 리스트 생성
		
	    for(int i = 0; i < jsonData.size(); i++) {
	    	Cart cart = jsonData.get(i); // JSON 데이터에서 Cart 객체 추출
	    	cart.setMemid(auth.getName()); // 인증된 사용자의 아이디로 장바구니 아이템 설정
	    	log.info(cart); // 로그로 장바구니 아이템 정보 기록
	    	cartService.putCart(cart); // 장바구니에 아이템 추가
	    	list.add(cart.getCart_no()); // 장바구니 번호 리스트에 추가
	    }
	    
	    CartPutitem item = new CartPutitem(); // 응답 데이터 객체 생성
	    item.setList(list); // 응답 데이터에 장바구니 번호 리스트 설정
	    item.setTotalCount(cartService.showCartCount(auth.getName())); // 응답 데이터에 장바구니 총 개수 설정
	    
	    
		return item;	// 응답 데이터 반환
	    
	}
}
