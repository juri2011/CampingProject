package com.campingga.service;

import java.util.List;

import com.campingga.domain.CartVO;

public interface CartService {

	public List<CartVO> getCartItemList(String userId);

	//장바구니 아이템 하나 삭제
	public int removeCart(int cart_no);

}
