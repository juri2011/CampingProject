package com.campingga.service;

import java.util.List;

import com.campingga.domain.ReviewVO;

public interface ReviewService {
  
  //리뷰 목록 가져오기
  public List<ReviewVO> getReviewList();
}
