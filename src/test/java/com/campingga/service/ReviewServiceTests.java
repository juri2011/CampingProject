package com.campingga.service;


import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.campingga.domain.Criteria;
import com.campingga.domain.ReviewPageDTO;
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
		ReviewPageDTO dto =
				//파라미터 - 1: 1페이지, 5개출력 / 2: 상품번호 2번
				reviewService.getReviewListWithPaging(new Criteria(1,5), 1);
		log.info(dto);
	};
	
	@Test
	public void registerTest() {
	  ReviewVO vo = new ReviewVO();
	  vo.setItem_no(1);
	  vo.setContent("좋아요~~!!!!");
	  vo.setWriter("user004");
	  vo.setScore(5);
	  int result = reviewService.register(vo);
	  log.info("---------------------결과 : "+result);
	  testGetReviewListWithPaging();
	}
	
	@Test
	public void removeTest() {
	  int result = reviewService.remove(13);
	  log.info("======================"+result);
	}
}
