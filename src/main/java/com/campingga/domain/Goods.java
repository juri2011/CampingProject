package com.campingga.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data 
@AllArgsConstructor
@NoArgsConstructor
public class Goods {
	private Integer gno;

	private String category;
	private String pname;
	private String content;
	private Integer sellPrice;
	private String skintype;
	private Date regidate;
	private Date updatedate;
	private Integer stock;
	private String status;
	private String imagepath;
	private String simagepath;
	private String option_list;
	
	private Integer originalPrice;
	private Integer discountPrice;
	private String uuid;
	private String[] option_list_split;
	
	private String parcelDate;
	private String dstatus;
	private String dstatusStr;
	
	private String payDate;

	private int orderNo;

	private int totalCount;
	
	
	private String waybillNum;
	private String parcelCd;

	
}
