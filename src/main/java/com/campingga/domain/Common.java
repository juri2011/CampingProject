package com.campingga.domain;

import lombok.Data;

@Data
public class Common {

	private int section = 1;
	
	private int pageNum = 1;
	
	private String searchId;

	private String searchText;

	private int no;

	private int price1;

	private int price2;

	private String category;

	private String memId;
	
	
	private int goods_no;
	
}
