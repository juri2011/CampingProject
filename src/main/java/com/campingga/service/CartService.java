package com.campingga.service;

import java.util.List;

import com.campingga.domain.CartVO;

public interface CartService {

	public List<CartVO> getCartItemList(String userId);

}
