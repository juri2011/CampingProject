package com.campingga.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor
@Getter
//Rest방식으로 주고받을 데이터를 담을 객체입니다.
public class ReviewPageDTO {
	private List<ReviewVO> reviewList; //리뷰 리스트
	private int reviewCnt;// 총 리뷰 갯수
}
