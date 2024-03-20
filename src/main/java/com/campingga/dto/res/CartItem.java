package com.campingga.dto.res;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CartItem {
	// 장바구니 기본정보
	private int cartNo;
	private int quantity = 1;

	// 상품 정보
	private int goodsNo;
	private int goodsPrice;
	private String goodsName;
	private String goodsImage; // 상품 이미지 주소
}
