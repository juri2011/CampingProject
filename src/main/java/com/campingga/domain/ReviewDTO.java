package com.campingga.domain;

import lombok.*;

@Getter
@Setter
@ToString
public class ReviewDTO {
  private int reviewPageNum;
  private int reviewAmount;
  private int item_no;
  
  public ReviewDTO() {
    this(1, 5);// 1페이지에 5개씩 출력
  }
  
  public ReviewDTO(int reviewPageNum, int reviewAmount) {
    this.reviewPageNum = reviewPageNum;
    this.reviewAmount = reviewAmount;
  }
}
