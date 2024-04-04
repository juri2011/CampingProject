package com.campingga.service;


import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.campingga.domain.Criteria;
import com.campingga.domain.ReviewPageDTO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReviewServiceTests {
	
	@Autowired
	private ReviewService reviewService;
	
	//상품 리스트 출력 테스트
	@Test
	public void testGetReviewListWithPaging() {
		ReviewPageDTO dto =
				//파라미터 - 1: 1페이지, 5개출력 / 2: 상품번호 2번
				reviewService.getReviewListWithPaging(new Criteria(1,5), 2);
		log.info(dto);
	};
}
