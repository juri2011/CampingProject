package com.campingga.domain;

import java.util.Date;

import lombok.*;

@Getter
@Setter
@ToString
public class ItemVO {
	private int item_no;//상품 번호
	private String item_name;//상품 이름
	private String content;//내용
	private int price;//가격
	private Date regdate;//등록일
	private String category;//카테고리
	private String status;//상태 (1: 판매중, 2: 품절)
}
