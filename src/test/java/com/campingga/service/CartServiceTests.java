package com.campingga.service;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

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
}
