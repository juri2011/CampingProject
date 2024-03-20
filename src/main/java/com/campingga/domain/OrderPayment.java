package com.campingga.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString 
public class OrderPayment {
	private int payment_no;
	private int order_no;
	private int pay_type;
	private String imp_uid;
	private int status;
	private Date reg_date;
}
