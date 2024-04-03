package com.campingga.mapper;

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
public class CartMapperTests {
	@Autowired
	private CartMapper cartMapper;
	
	//장바구니 전부 가져오기
	@Test
	public void testSelectAllCartItem() {
		List<CartVO> list = cartMapper.selectAllCartItem();
		list.forEach(cart -> log.info(cart));
	}
	
	//특정 사용자 장바구니 가져오기
	@Test
	public void testSelectCartItemList() {
		List<CartVO> list = cartMapper.selectCartItemList("user004");
		list.forEach(cart -> log.info(cart));
	}
}
