package com.campingga.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.campingga.domain.CartVO;
import com.campingga.service.CartService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/cart")
@Log4j
public class CartController {

	@Autowired
	public CartService cartService;
	
	@GetMapping("/list")
	public String cartList(Model model){
		//로그인 유저 체크
		//Authentication auth = SecurityContextHolder.getContext().getAuthentication();		
		
		//String userId = auth.getName();
		String userId = "user003";
		List<CartVO> cartList = cartService.getCartItemList(userId);
		
		model.addAttribute("cartItemList", cartList);
		model.addAttribute("cartype", 1);
		
		return "cart/cart"; 
	}
}
