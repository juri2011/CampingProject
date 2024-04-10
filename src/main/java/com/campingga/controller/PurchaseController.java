package com.campingga.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.campingga.domain.OrderListVO;
import com.campingga.domain.PurchaseDTO;
import com.campingga.service.CartService;
import com.campingga.service.OrderService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/purchase")
public class PurchaseController {
	
	@Autowired
	private OrderService orderService;
	
	
	@Autowired
	private CartService cartService;
	
	@GetMapping("success")
	public String paymentSuccess(HttpSession session){
		
		if(session.getAttribute("paymentData") == null){
			return "redirect:/cart/list";
		}
		
		PurchaseDTO dto = (PurchaseDTO) session.getAttribute("paymentData");
		List<OrderListVO> orderList = dto.getOrderList();
		
		log.info(orderList);
		int insertCount = 0;
		
		for(OrderListVO order : orderList) {
			if(orderService.addOrder(order) == 1) {
				insertCount++;
				cartService.removeCart(order.getCart_no());
			}
		}
		
		log.info("결제 요청 및 인증 성공");
		
		if(insertCount == orderList.size()) {
			session.removeAttribute("paymentData");
			return "redirect:/order/orderList";
		}else {
			return "redirect:/cart/list";
		}
	}
	
	@GetMapping("fail")
	public String paymentFail(HttpSession session){
		log.info("결제 실패");
		
		return "redirect:/cart/list";
		
	}
}
