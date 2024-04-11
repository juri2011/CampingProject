package com.campingga.domain;

import lombok.*;
@Getter
@Setter
@ToString
public class CartVO {
	private int cart_no;
	private String member_id;
	private String item_img; //상품 이미지 경로
	private int item_no;//상품번호
	private String item_name; //상품이름
	private int price; //상품가격
	private String status;//상품 상태- 1: 판매중 2: 품절
	private int quantity; //상품 수
	
	// 이미지 정보 
	private String fileName;
}
