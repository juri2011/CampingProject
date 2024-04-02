package com.campingga.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.campingga.domain.ReviewVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j 
public class ReviewMapperTests {
	@Autowired
	private ReviewMapper reviewMapper;
	
	@Test
	public void getReviewListTest() {
	  List<ReviewVO> reviewList = reviewMapper.selectReviewList(); 
	  reviewList.forEach(review -> log.info(review));
	}
}
