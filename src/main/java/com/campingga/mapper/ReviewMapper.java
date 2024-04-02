package com.campingga.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.campingga.domain.Criteria;
import com.campingga.domain.ReviewVO;

public interface ReviewMapper {
  
  //리뷰 목록 가져오기
  public List<ReviewVO> selectReviewList();
  
  //페이징 적용된 리뷰 목록 가져오기
  public List<ReviewVO> selectReviewListWithPaging(
		  @Param("cri") Criteria cri, @Param("item_no")int item_no, @Param("total") int total);

  //리뷰 전체 갯수
  public int selectCountByItemNo(int item_no);
  
}