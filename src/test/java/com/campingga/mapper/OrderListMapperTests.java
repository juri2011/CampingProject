package com.campingga.mapper;

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
public class OrderListMapperTests {
	
	@Autowired
	private OrderMapper orderMapper;
	
	@Test
	public void insertOrderTests() {
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
		int result = orderMapper.insertOrder(vo);
		log.info("------------------------------------------------"+result);
		
		OrderListVO vo2 = new OrderListVO();
		vo2.setCart_no(2);
		vo2.setItem_no(2);
		vo2.setMem_id("user003");
		vo2.setName("이민호");
		vo2.setPhone("010-0000-0000");
		vo2.setStnum("12345");
		vo2.setD_memo("파손되지 않게 잘 배달해주세요");
		vo2.setAmount(3);
		vo2.setUserAddr("용인시 기흥구 고매동 무슨 아파트");
		vo2.setUserDaddr("101동 101호");
		int result2 = orderMapper.insertOrder(vo2);
		
		log.info("------------------------------------------------"+result2);
	}
	
	@Test
	public void getOrderListTest() {
		List<OrderListVO> orderList = orderMapper.getOrderList("user003");
		orderList.forEach(order -> log.info(order));
	}
}
