package com.campingga.dto.res;

import java.util.List;

import lombok.Data;

@Data
public class CartPutitem {
  
  //장바구니에 추가된 상품들의 'cartNo'목록을 리스트로 추가
	List<Integer> list;
	
	// 장바구니에 담겨있는 총 상품 수 
	int totalCount;
}
