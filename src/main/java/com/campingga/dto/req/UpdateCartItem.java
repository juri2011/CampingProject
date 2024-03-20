package com.campingga.dto.req;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class UpdateCartItem {
	private int cartNo;
	private int quantity;
}
