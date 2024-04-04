package com.campingga.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.campingga.domain.CartDTO;
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

	@Override
	public int removeCart(int cart_no) {
		return cartMapper.deleteCartItem(cart_no);
	}
	
	@Override
	public CartDTO getCartItemListWithCnt(String member_id) {
		int total = cartMapper.selectCountByMemberId(member_id);
		return new CartDTO(cartMapper.selectCartItemList(member_id), total);
	}

	//장바구니 전부 삭제
	@Override
	public int removeAllCart(String member_id) {
		return cartMapper.deleteAllCart(member_id);
	}

	@Override
	public int modify(CartVO vo) {
		return cartMapper.updateCart(vo);
	}

}
