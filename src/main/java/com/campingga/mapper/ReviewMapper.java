package com.campingga.mapper;

import java.util.List;

import com.campingga.domain.Common;
import com.campingga.domain.Review;

public interface ReviewMapper {

	public List<Review> selectReviewList(Common common);

	
	public Review selectReviewById(int reviewNo);

	
	public int insertReview(Review review);

	
	public int deleteReview(int reviewNo);
	
	public int updateReview(Review review);

	

}
