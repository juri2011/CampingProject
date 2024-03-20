package com.campingga.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.campingga.domain.Common;
import com.campingga.domain.Review;
import com.campingga.mapper.ReviewMapper;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class ReviewService {
	
	@Autowired
	private ReviewMapper reviewMapper;
	
	
	public List<Review> getReviewList(Common common,int gno) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("section", common.getSection());
		map.put("pageNum", common.getPageNum());
		map.put("gno", gno);
		common.setNo(gno);
		
		
		return reviewMapper.selectReviewList(common);
	}
	
	public Review getReview(int reviewNo) {
		return reviewMapper.selectReviewById(reviewNo);
	}
	
	public int insertReview(Review review) {
		return reviewMapper.insertReview(review);
	}

	public int deleteReview(int reviewNo) {
		return reviewMapper.deleteReview(reviewNo);
	}
	
	public int updateReview(Review review) {
		return reviewMapper.updateReview(review);
	}
}
