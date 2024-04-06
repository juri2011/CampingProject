package com.campingga.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.campingga.domain.CartDTO;
import com.campingga.domain.CartVO;
import com.campingga.domain.MemberVO;
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
	public String cartList(HttpServletRequest request, Model model){
		//로그인 유저 체크
		//Authentication auth = SecurityContextHolder.getContext().getAuthentication();		
		HttpSession session = request.getSession();
		//String userId = auth.getName();
		if(session.getAttribute("member") != null) {
			MemberVO user = (MemberVO) session.getAttribute("member"); //임시(원래는 세션에서 id를 가져와야 함)
			String userId = user.getMem_id();
			model.addAttribute("userId", userId);
		}
		
		return "cart/cart"; 
	}
	 //댓글 등록하기
  @PostMapping("/add")
  public @ResponseBody ResponseEntity<String> create(@RequestBody CartVO vo){
    
    log.info("CartVO: "+vo);
    int insertCount = cartService.add(vo);
    
    log.info("Cart INSERT COUNT : "+insertCount);
    
    return insertCount == 1
        ? new ResponseEntity<>("success", HttpStatus.OK)
        : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    //삼항연산자
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
	
	@DeleteMapping("/deleteAll/{member_id}")
	public @ResponseBody String removeAllCart(@PathVariable String member_id){
		log.info("remove all cart............. ");
		
		return cartService.removeAllCart(member_id) > 0
				? "success" : "error";
	}
	
	@RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH}, value="/{cart_no}")
	public @ResponseBody String updateCart(@PathVariable int cart_no, @RequestBody CartVO vo) {
		vo.setCart_no(cart_no);
		log.info("cart_no: " + cart_no);
		log.info("modify: " + vo);
		
		return cartService.modify(vo) == 1
				? "success" : "error";
	}
}
