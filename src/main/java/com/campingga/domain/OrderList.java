package com.campingga.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString 
public class OrderList {

	private int orderlist_no;
	private String mem_id;
	private int totprice;
	private Date regidate;
	private String dsstatus;
	private String waybill_num;
	private String parcel_cd;
	
/*	to ji 수정버전
	int orderlistNo;
	
	String memId;
	
	int topprice;
	
	Date regidate;
	
	String regiDateStr;

	String dstatus;
	
	String waybillNum; // 송장번호
	
	String parcelCd; // 택배 코드
*/ 
	
}
