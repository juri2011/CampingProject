package com.campingga.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Cart {
	private Integer cart_no;
	private String memid;
	private Integer goods_no;
	private Integer ordernum;
	private Date regidate;
	private Integer quantity = 1;
	private String optionName;  //추가(옵션 이름)
	private Integer totalPrice;  //추가(총가격)
	private String pname;  //추가(상품 이름)
}
