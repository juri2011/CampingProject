package com.campingga.domain;
import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

//주문내역 VO
@Getter
@Setter
@ToString
public class OrderListVO {
	private int ord_no; //주문번호
	private String iname; //상품이름
	private int price; //상품가격
	private String id; //멤버 아이디
	private Date regdate; //주문날짜
	private String status; //상태(1: 결제완료, 2: 배송준비, 3: 배송중, 4: 배송완료)
}
