package com.campingga.service;

import java.util.List;

import com.campingga.domain.Criteria;
import com.campingga.domain.ReviewPageDTO;
import com.campingga.domain.ReviewVO;

public interface ReviewService {
  
  //리뷰 목록 가져오기
  public List<ReviewVO> getReviewList();
  
  //페이징으로 리뷰 목록 가져오기
  public ReviewPageDTO getReviewListWithPaging(Criteria cri, int item_no);
}
