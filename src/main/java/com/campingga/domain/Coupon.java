package com.campingga.domain;

import java.util.Date;

import lombok.Data;

@Data
public class Coupon {
	private int id;
	private String cname;
	private String code;
	private int ctype;
	private int value;
	private String cond;
	private Date regidate;
	private Date enddate;
	private int status;
}
