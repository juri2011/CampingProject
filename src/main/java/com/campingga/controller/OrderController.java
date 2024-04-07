package com.campingga.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.TreeMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.campingga.common.CommonUtils;
import com.campingga.domain.CartVO;
import com.campingga.domain.ItemVO;
import com.campingga.domain.MemberVO;
import com.campingga.domain.OrderListVO;
import com.campingga.service.CartService;
import com.campingga.service.ItemService;
import com.campingga.service.OrderService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/order")
@Log4j
public class OrderController {

	@Autowired
	public OrderService orderService;
	
	@Autowired
	public CartService cartService;
	
	@Autowired
	public ItemService itemService;
	
	//구매 화면으로 이동
	@GetMapping("/purchase")
	public String orderListForm(HttpSession session, Model model) {
		//session으로부터 user 정보 가져옴
		
		MemberVO user = (MemberVO) session.getAttribute("member");//임시
		String userId = user.getMem_id();	
		List<CartVO> cartList = cartService.getCartItemList(userId);
		log.info(cartList);
		int totalPrice = cartService.getTotalPrice(cartList);
		log.info(totalPrice);
		model.addAttribute("totalPrice",totalPrice);
		model.addAttribute("cartList",cartList);
		return "order/purchase";
	}
	
	@PostMapping("/purchase/direct")
	public String orderListFormDirect(HttpSession session, CartVO cartVO, Model model) {
		//String userId = "user003"; 임시
		
		List<CartVO> cartList = new ArrayList<CartVO>();
		cartList.add(cartVO);
		
		
		model.addAttribute("totalPrice",cartVO.getPrice() * cartVO.getQuantity());
		model.addAttribute("cartList",cartList);
		if(session.getAttribute("member") != null) {
			MemberVO member = (MemberVO) session.getAttribute("member");
			model.addAttribute("member", member);
		}
		
		return "order/purchase";
	}
	/*
	시큐리티를 사용하는 코드이므로 보류
	@PostMapping("/purchase")
	@ResponseBody
	public AjaxRes newOrder(@RequestBody List<NewOrder> cartList) {
		String id = null;
		
		// 로그인 유저 체크
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth.getName() == null || auth.getName().equals("") || auth.getName().equals("anonymousUser")) {
			// 미로그인 상태
			return AjaxRes.builder().status("FAIL").message("Not logged in").build();
		}
		
		id = auth.getName();
		PaymentItem paymentItem = orderService.newOrder(id,cartList);
		if(paymentItem == null) {
		}
		
		return AjaxRes.builder().status("SUCCESS").data(paymentItem).build();
	}
	*/
	
	@GetMapping("/orderList")
	public String orderList(HttpSession session, Model model) {
		//세션에 멤버 값이 있을 경우만 처리
		if(session.getAttribute("member") == null) {	
			return "/main";
		}
		String mem_id = ((MemberVO)session.getAttribute("member")).getMem_id();
		List<OrderListVO> orderList = orderService.getOrderList(mem_id);
		
		//TreeMap은 기본적으로 오름차순이기 때문에 내림차순으로 정렬하도록 지정
		Map<String, List<OrderListVO>> orderMap = new TreeMap<>(Collections.reverseOrder());
		Map<String, Integer> totalPriceMap = new HashMap<>();
		
		
		//주문번호별로 그룹화
		for(OrderListVO order : orderList) {
			
			//order의 item_no를 이용해서 아이템정보(이름, 가격)등을 받아온다.
			ItemVO item = itemService.get(order.getItem_no());
			order.setItem_name(item.getItem_name());
			order.setPrice(item.getPrice());
			
			//주문번호로 key 생성
			String orderKey = order.getOrd_no();
			
			//아직 주문번호로 key값이 만들어지지 않았으면 생성 (초기화)
			if (!orderMap.containsKey(orderKey)) {
                orderMap.put(orderKey, new ArrayList<>());
                totalPriceMap.put(orderKey, 0);
            }
			log.info("================================"+order.getAmount());
			//주문번호 key로 ArrayList value에 현재 order를 추가
			orderMap.get(orderKey).add(order);
			
			int totalPrice = totalPriceMap.get(orderKey) + (order.getPrice() * order.getAmount());
			totalPriceMap.put(orderKey, totalPrice);
			
		}
		
		
		//orderList.forEach(order -> log.info(order));
		model.addAttribute("orderMap",orderMap);
		model.addAttribute("totalPriceMap", totalPriceMap);
		//model.addAttribute("orderList",orderList);
		return "order/orderList";
	}
	

	
	@PostMapping("/addOrder")
	public @ResponseBody ResponseEntity<String> addOrder(HttpSession session, @RequestBody List<OrderListVO> orderList){
		
		MemberVO member = (MemberVO) session.getAttribute("member");
		String userId = member.getMem_id();
		int insertCount = 0;
		//name, phone, addr1, addr2, memo, item_no, amount
		
		for(OrderListVO order : orderList) {
			log.info(order);
			order.setMem_id(userId);
			
			Date now = new Date();
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
			order.setOrd_no(userId + "_" + dateFormat.format(now));
			
			if(orderService.addOrder(order) == 1) insertCount++;
			
			//이 경로로 왔다는 것은 결제 처리가 정상적으로 되었다는 뜻이므로 removeCart로 삭제
			cartService.removeCart(order.getCart_no());
		}
			
		return insertCount == orderList.size()
		        ? new ResponseEntity<>("success", HttpStatus.OK)
		        : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	/*
	//장바구니, 바로구매페이지에서 Bill테이블에 데이터 추가(비동기로)
	@PostMapping("/addBill")
	public @ResponseBody String addBill(@RequestBody List<CartVO> cartList) {
		log.info(cartList);
		cartList.forEach(cart -> {
			BillVO bill = new BillVO();
			bill.setAmount(cart.getQuantity());
			bill.setItem_no(cart.getItem_no());
			if(cart.getCart_no()>1) bill.setCart_no(cart.getCart_no());
			bill.setMem_id(cart.getMember_id());
			
			orderService.addBill(bill);
		});
		return "success";
	}
*/
	

}