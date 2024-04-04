package com.campingga.mapper;

import java.util.List;

import com.campingga.domain.CartVO;

public interface CartMapper {

	//모든 장바구니 아이템 가져오기
	public List<CartVO> selectAllCartItem();
	
	//사용자의 장바구니 받아오기
	public List<CartVO> selectCartItemList(String userId);

	//장바구니 아이템 하나 삭제
	public int deleteCartItem(int cart_no);

	//사용자 장바구니에서 총 갯수 가져오기
	public int selectCountByMemberId(String member_id);

	//장바구니 전체 삭제
	public int deleteAllCart(String member_id);

	//장바구니 수량 변경
	public int updateCart(CartVO vo);

	//장바구니 추가
  public int insertCart(CartVO vo);

}
