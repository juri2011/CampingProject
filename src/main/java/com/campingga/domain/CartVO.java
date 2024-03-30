package com.campingga.domain;

import lombok.*;
@Getter
@Setter
@ToString
public class CartVO {
	private String item_img; //상품 이미지 경로
	private String iname; //상품이름
	private int price; //상품가격
	private int count; //상품 수
}
