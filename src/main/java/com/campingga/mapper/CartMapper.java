package com.campingga.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.campingga.domain.Cart;

public interface CartMapper {

	public List<Cart> selectCart(String id);

	public List<Cart> selectCartNo(int cartNo);

	public List<Cart> selectCartByCartNo(@Param("id") String id, @Param("numberList") List<Integer> numberList);
	
	public void insertCart(Cart cart);

	public void deleteCart(Cart cart);

	public int selectCartCount(String id);

	public int updateCart(@Param("id") String id, @Param("cartNo") int cartNo, @Param("quantity") int quantity);
	
	public int updateCartOrderNo(@Param("memberId") String memberId, @Param("orderNo") int orderNo, @Param("numberList") List<Integer> numberList);
}
