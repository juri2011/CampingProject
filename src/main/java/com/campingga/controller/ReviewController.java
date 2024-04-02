package com.campingga.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.campingga.domain.Criteria;
import com.campingga.domain.ReviewPageDTO;
import com.campingga.service.ReviewService;

import lombok.extern.log4j.Log4j;

@RestController
@Log4j
@RequestMapping("/review")
public class ReviewController {
	
	@Autowired
	private ReviewService reviewService;
	
	@GetMapping("/reviewList/{item_no}/{page}")
	public ResponseEntity<ReviewPageDTO> getReviewListWithPaging(
			@PathVariable("page") int page,
			@PathVariable("page") int item_no){
		log.info("getList with paging");
		Criteria cri = new Criteria(page,5); //한 페이지에 5개씩 출력
		return new ResponseEntity<>(reviewService.getReviewListWithPaging(cri, item_no),
									HttpStatus.OK);
	}
	
}
