package com.campingga.service;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.campingga.domain.OrderListVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class OrderServiceTests {
	@Autowired
	private OrderService orderService;
	
	@Test
	public void addOrderTest() {
		OrderListVO vo = new OrderListVO();
		vo.setCart_no(1);
		vo.setItem_no(1);
		vo.setMem_id("user003");
		vo.setName("이민호");
		vo.setPhone("010-0000-0000");
		vo.setStnum("12345");
		vo.setD_memo("파손되지 않게 잘 배달해주세요");
		vo.setAmount(2);
		vo.setUserAddr("용인시 기흥구 고매동 무슨 아파트");
		vo.setUserDaddr("101동 101호");
		
		int result = orderService.addOrder(vo);
		log.info("------------------------------------------------"+result);
	}
	
	@Test
	public void getOrderList() {
		List<OrderListVO> list = orderService.getOrderList("user003");
		list.forEach(order -> log.info(list));
	}
}
