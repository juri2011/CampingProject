package com.campingga.service;


import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.campingga.domain.ItemVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ItemServiceTests {
	
	@Autowired
	private ItemService itemService;
	
	//상품 리스트 출력 테스트
	@Test
	public void getList() {
		List<ItemVO> itemList = itemService.getList();
		itemList.forEach(item -> log.info(item));
	};
}
