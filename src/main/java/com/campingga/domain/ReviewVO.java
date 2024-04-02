 package com.campingga.domain;
 import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

 @Getter
 @Setter
 @ToString
public class ReviewVO {
	private int rev_no; //리뷰번호
	private int item_no; //아이템번호
	private String writer; //작성자
	private String content; //내용
	private int score; //별점(1~5)
	private Date regdate; //작성일
}
