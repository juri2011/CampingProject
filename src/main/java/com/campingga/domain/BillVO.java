package com.campingga.domain;
import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

//결제
@Getter
@Setter
@ToString 
public class BillVO {
	private String item_img; //상품 이미지 경로
	private String iname; //상품 이름
	private int price; //상품 가격
	private Date regdate; //등록일
	private String status; //상태(1: 결제완료, 2: 배송준비, 3: 배송중, 4: 배송완료)
}
