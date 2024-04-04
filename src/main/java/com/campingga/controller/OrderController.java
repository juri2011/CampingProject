package com.campingga.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

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
		model.addAttribute("cartList",cartService.getCartItemList(userId));
		return "order/purchase";
	}
	
}
