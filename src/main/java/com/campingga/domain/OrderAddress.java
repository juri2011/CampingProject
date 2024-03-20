package com.campingga.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class OrderAddress {
	private int address_no;
	private int order_no;
	private String name;
	private String phone;
	private String addr1;
	private String addr2;
	private String memo;
	private String registered;
}
