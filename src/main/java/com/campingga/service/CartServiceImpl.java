package com.campingga.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.campingga.domain.CartVO;
import com.campingga.mapper.CartMapper;

@Service
public class CartServiceImpl implements CartService{

	@Autowired
	private CartMapper cartMapper;
	
	//사용자 아이디로 리스트 가져오기
	@Override
	public List<CartVO> getCartItemList(String userId) {
		return cartMapper.selectCartItemList(userId);
	}

}
