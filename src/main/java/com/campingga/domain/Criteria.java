package com.campingga.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {
	private int pageNum; //현재 페이지 번호
	private int amount; //한 페이지 출력될 양
	private String category; //카테고리
	
	public Criteria() {
		this(1, 12);
	}
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
}
