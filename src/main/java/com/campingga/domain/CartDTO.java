package com.campingga.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
@Getter
@Setter
@ToString
@AllArgsConstructor
public class CartDTO {
	private List<CartVO> cartList;
	private int cartCnt;
}
