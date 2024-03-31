package com.campingga.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.campingga.domain.Criteria;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j 
public class ItemMapperTests {
	@Autowired
	private ItemMapper itemMapper;
	//상품 리스트 출력 테스트
	@Test
	public void testGetList() {
		log.info(itemMapper.selectList());
	}
	
	//페이징 상품 출력 테스트
	@Test
	public void testGetListWithPaging() {
		Criteria cri = new Criteria(1, 12);
		log.info(itemMapper.selectListWithPaging(cri));
	}
	
	//상품 총 개수 테스트
	@Test
	public void testGetTotalCount() {
		log.info(itemMapper.selectTotalCount());
	}
}
