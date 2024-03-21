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
//하나가 힘들지만.........
@Log4j 
@Controller
@RequestMapping("/cart")
public class CartContoller {
	
	@Autowired
	CartService cartService;
	

	
	@GetMapping("/view")
	public String viewCart(Model model) {
		//로그인 유저 체크
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();		
		
		String userId = auth.getName();
		List<CartItem> cartList = cartService.getCartItemList(userId);
	
		model.addAttribute("cartItemList", cartList);
		model.addAttribute("cartype", 1);
		
		return "cart"; 
	}
	
	
	@GetMapping("/direct")
	public String viewDirectCart(@RequestParam("cart_no") List<Integer> cartNoList, Model model) {
		
		List<CartItem> cartList = cartService.getDirectCartItem(cartNoList);
	
		model.addAttribute("cartItemList", cartList);
		model.addAttribute("cartype", 2);
		
		return "cart"; 
	}
	
	
	@PostMapping(path="/putCart", consumes = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public CartPutitem putCart(@RequestBody List<Cart> jsonData, HttpServletResponse response) throws IOException {
		log.info("putcart 실행");
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		List<Integer> list = new ArrayList<Integer>();
		
	    for(int i = 0; i < jsonData.size(); i++) {
	    	Cart cart = jsonData.get(i);
	    	cart.setMemid(auth.getName());
	    	log.info(cart);
	    	cartService.putCart(cart);
	    	list.add(cart.getCart_no());
	    }
	    
	    CartPutitem item = new CartPutitem();
	    item.setList(list);
	    item.setTotalCount(cartService.showCartCount(auth.getName()));
	    
	    
		return item;	
	    
	}
}
