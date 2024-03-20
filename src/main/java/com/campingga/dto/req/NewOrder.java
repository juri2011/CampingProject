package com.campingga.dto.req;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class NewOrder {
	private String name;
	private String phone;
	private String addr1;
	private String addr2;
	private String memo;
	private int cart;
}
