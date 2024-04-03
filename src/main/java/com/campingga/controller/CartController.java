package com.campingga.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.campingga.domain.CartDTO;
import com.campingga.domain.CartVO;
import com.campingga.service.CartService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/cart")
@Log4j
public class CartController {

	@Autowired
	public CartService cartService;
	
	//단순히 이동만 하는 메소드
	@GetMapping("/list")
	public String cartList(Model model){
		//로그인 유저 체크
		//Authentication auth = SecurityContextHolder.getContext().getAuthentication();		
		
		//String userId = auth.getName();
		String userId = "user003"; //임시(원래는 세션에서 id를 가져와야 함)
		model.addAttribute("userId", userId);
		
		return "cart/cart"; 
	}
	
	//비동기로 장바구니 리스트를 가져오는 메소드
	@GetMapping("/cartList/{member_id}")
	public @ResponseBody ResponseEntity<CartDTO> cartList(@PathVariable("member_id") String member_id){
		CartDTO dto = cartService.getCartItemListWithCnt(member_id);
		return new ResponseEntity<>(dto, HttpStatus.OK);
	}
	
	@DeleteMapping("/{cart_no}")
	public @ResponseBody ResponseEntity<String> removeCart(@PathVariable int cart_no){
		log.info("remove: " + cart_no);
		
		return cartService.removeCart(cart_no) == 1
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
