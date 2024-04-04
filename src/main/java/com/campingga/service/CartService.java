package com.campingga.service;

import java.util.List;

import com.campingga.domain.CartDTO;
import com.campingga.domain.CartVO;

public interface CartService {

	public List<CartVO> getCartItemList(String userId);

	//장바구니 아이템 하나 삭제
	public int removeCart(int cart_no);
	
	//사용자 아이디로 장바구니 리스트와 갯수 가져오기
	public CartDTO getCartItemListWithCnt(String member_id);

	//장바구니 전부 삭제
	public int removeAllCart(String member_id);

	//장바구니 수정(수량)
	public int modify(CartVO vo);

	//장바구니 추가
  public int add(CartVO vo);

}
