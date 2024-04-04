package com.campingga.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.campingga.domain.CartVO;
import com.campingga.service.CartService;
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
	
	@GetMapping("/purchase")
	public String orderListForm(Model model) {
		String userId = "user003";//임시
		List<CartVO> cartList = cartService.getCartItemList(userId);
		int totalPrice = cartService.getTotalPrice(cartList);
		model.addAttribute("totalPrice",totalPrice);
		model.addAttribute("cartList",cartList);
		return "order/purchase";
	}
	
	@GetMapping("/purchase/direct")
	public String orderListFormDirect(CartVO cartVO, Model model) {
		//String userId = "user003"; 임시
		
		List<CartVO> cartList = new ArrayList<CartVO>();
		cartList.add(cartVO);
		model.addAttribute("totalPrice",cartVO.getPrice() * cartVO.getQuantity());
		model.addAttribute("cartList",cartList);
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
}
