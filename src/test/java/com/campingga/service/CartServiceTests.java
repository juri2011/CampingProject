package com.campingga.service;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.campingga.domain.CartDTO;
import com.campingga.domain.CartVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class CartServiceTests {
	@Autowired
	private CartService cartService;
	
	//사용자의 장바구니 리스트 불러오기
	@Test
	public void testGetCartItemList() {
		List<CartVO> list = cartService.getCartItemList("user003");
		list.forEach(cart -> log.info(list));
	}
	
	@Test
	public void testRemoveCart() {
		int result = cartService.removeCart(4);
		log.info(result==1 ? "성공" : "실패");
	}
	
	@Test
	public void testGetCartItemListWithCnt() {
		CartDTO dto = cartService.getCartItemListWithCnt("user003");
		log.info(dto);
	}
	
	@Test
	public void testModify() {
		CartVO vo = new CartVO();
		vo.setCart_no(3);
		vo.setQuantity(5);
		int result = cartService.modify(vo);
		log.info(result);
	}
	
	@Test
  public void testAdd() {
    CartVO vo = new CartVO();
    vo.setMember_id("user003");
    vo.setItem_no(14);
    vo.setQuantity(4);
    
    int result = cartService.add(vo);
    log.info(result);
  }
}
