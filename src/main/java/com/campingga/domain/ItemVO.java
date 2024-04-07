package com.campingga.domain;

import java.util.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ItemVO {
	private int item_no;//상품 번호
	private String item_name;//상품 이름
	private int amount; //상품 수량
	private String content;//상품 소개
	private int price;//가격
	private Date regdate;//등록일
	private String category;//카테고리
	private String status;// 상태 (판매중, 품절)
	
		/* 이미지 정보 */
		private List<AttachImageVO> imageList;
	
}
