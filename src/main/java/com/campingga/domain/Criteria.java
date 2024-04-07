package com.campingga.domain;

import org.springframework.web.util.UriComponentsBuilder;

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
	private String keyword; //검색 키워드
	
	public Criteria() {
		this(1, 12);
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	//modify 혹은 delete 후 redirect할 때 필요한 쿼리스트링 반환
	public String getListLink() {
		  UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				  .queryParam("pageNum", this.pageNum)
				  .queryParam("amount", this.amount)
				  .queryParam("category", this.category);
		  return builder.toUriString();
	  }
}
