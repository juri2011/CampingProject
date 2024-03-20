package com.campingga.domain;

import java.util.Date;

import lombok.Data;

@Data
public class Adminclaim {

	private int level;
	private int gclaim_no;
	private int goods_no;
	private String mem_id;
	private String content;
	private Date regidate;
	private Date updatedate;
	private String status;
	private int answer_no;
	
	private int rownum;
	private int total;
}
