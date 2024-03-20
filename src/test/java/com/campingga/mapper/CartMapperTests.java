package com.campingga.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.campingga.domain.Cart;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class CartMapperTests {
	
	@Autowired
	CartMapper mapper;
	
	@Test
	public void testselectCart() {
		List<Cart> cart = mapper.selectCart("test");
		//log.info(cart);
	};
	
	@Test
	public void testinsertCart() {
		Cart cart = new Cart();
		mapper.insertCart(cart);
		log.info("insert 완료");
	};
	
	@Test
	public void testdeleteCart() {
		Cart cart = new Cart();
		mapper.deleteCart(cart);
		log.info("delete 완료");
	};
}
