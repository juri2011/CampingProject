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

@Slf4j
@Controller
@RequestMapping("/order/*")
public class OrderController {
	@Autowired
	CartService cartService;

	@Autowired
	OrderService orderService;

	@Autowired
	GoodsService goodsService;

	
	@PostMapping("new1")
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
	
	
	@PostMapping("new2")
	@ResponseBody
	public AjaxRes newOrder2(@RequestBody List<NewOrder> cartList) {
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
	
	

	@PostMapping("updateCart")
	@ResponseBody
	public AjaxRes updateCart(@RequestBody UpdateCartItem cartItem) {
		String id = null;
		
		// 로그인 유저 체크
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth.getName() == null || auth.getName().equals("") || auth.getName().equals("anonymousUser")) {
			// 미로그인 상태
			return AjaxRes.builder().status("FAIL").message("Not logged in").build();
		}
		
		id = auth.getName();
		if(cartService.updateCart(id, cartItem)) {
			return AjaxRes.builder().status("SUCCESS").build();			
		} else {
			return AjaxRes.builder().status("FAIL").message("Cannot find user.").build();
	
		}
	}
	
	@GetMapping("/list.do")
	public String main(Model model, Common common) {
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		
		String userId = auth.getName();

		common.setMemId(userId);
		
		List<Goods> list = goodsService.getGoodsOrderList(common);
		
		model.addAttribute("list", list);
		
		return "order/list";
	}
	
}
