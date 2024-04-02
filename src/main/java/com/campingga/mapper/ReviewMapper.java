package com.campingga.mapper;

import java.util.List;

import com.campingga.domain.ReviewVO;

public interface ReviewMapper {
  
  //리뷰 목록 가져오기
  public List<ReviewVO> selectReviewList();
}
