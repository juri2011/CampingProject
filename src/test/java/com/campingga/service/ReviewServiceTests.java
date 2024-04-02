package com.campingga.service;


import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.campingga.domain.ReviewDTO;
import com.campingga.domain.ReviewVO;

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
		ReviewDTO reviewDTO = new ReviewDTO();
		reviewDTO.setItem_no(1);
		
		List<ReviewVO> reviewList = reviewService.getReviewListWithPaging(reviewDTO);
		reviewList.forEach(item -> log.info(item));
	};
}
