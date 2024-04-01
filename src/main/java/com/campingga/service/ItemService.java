package com.campingga.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.campingga.domain.Criteria;
import com.campingga.domain.ItemVO;

public interface ItemService {
	//상품 전체 리스트
	List<ItemVO> getList();
	
	//페이징이 적용된 상품 리스트
	List<ItemVO> getListWithPaging(Criteria cri);
	
	//상품 전체 개수
	int getTotalCount(Criteria cri);

	//상품 가져오기
	ItemVO get(int item_no);
}
