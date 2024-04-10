package com.campingga.domain;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PurchaseDTO {
	private String ord_no;
	private String name;
	private int totalPrice;
	private String orderName; //결제창에 띄울 주문 이름
	private List<OrderListVO> orderList;
}
