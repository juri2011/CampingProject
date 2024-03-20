package com.campingga.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Payment {
	
	private int paymentNo;
	private int orderNo;
	private int payType;
	private String impUid;
	private int status;
	private Date regDate;

}
