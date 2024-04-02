package com.campingga.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.campingga.domain.Criteria;
import com.campingga.domain.ReviewPageDTO;
import com.campingga.domain.ReviewVO;
import com.campingga.mapper.ReviewMapper;

@Service
public class ReviewServiceImpl implements ReviewService{

  @Autowired
  private ReviewMapper reviewMapper;
  
  //리뷰 목록 가져오기
  @Override
  public List<ReviewVO> getReviewList() {
    return reviewMapper.selectReviewList();
  }

  	@Override
	public ReviewPageDTO getReviewListWithPaging(Criteria cri, int item_no) {
  		int total = reviewMapper.selectCountByItemNo(item_no);
  		return new ReviewPageDTO(
  				reviewMapper.selectReviewListWithPaging(cri, item_no, total),total);
}

}
