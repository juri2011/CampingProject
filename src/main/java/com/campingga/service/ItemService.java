package com.campingga.service;

import java.util.List;

import com.campingga.domain.Criteria;
import com.campingga.domain.ItemVO;
import com.campingga.domain.PagingVO;

public interface ItemService {
	//신상품 세 개만
	public List<ItemVO> getNewItems();
	
	//상품 전체 리스트
	public List<ItemVO> getList();
	
	//페이징이 적용된 상품 리스트
	public List<ItemVO> getListWithPaging(Criteria cri);
	
	//상품 전체 개수
	public int getTotalCount(Criteria cri);

	//상품 가져오기
	public ItemVO get(int item_no);
	
	//상품 총 개수 - 상품관리
    public int countItem();

    // 페이징 처리된상품 목록 - 상품 관리
    public List<ItemVO> selectItem(PagingVO vo);
    
    //상품 정보 수정
    public int itemUpdate(ItemVO vo);
    
    //상품 삭제
    public int deleteItem(int item_no);
}
