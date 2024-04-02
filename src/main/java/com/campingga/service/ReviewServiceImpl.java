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
  		//total을 ReviewPageDTO로 넘겨줘야 하기 때문에 두 개의 쿼리를 분리해서 작성해야 한다.
  		int total = reviewMapper.selectCountByItemNo(item_no);
  		return new ReviewPageDTO(
  				reviewMapper.selectReviewListWithPaging(cri, item_no, total),total);
}

}