package com.campingga.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class Review {

	private int reviewNo;
	
	private String memId;

	private int goodsNo;
	
	private String title;
	
	private String content;
	
	private int score;
	
	private Date regiDate;
	
	private String regiDateStr;
	
	private Date updateDate;
	
	private String updateDateStr;
	
	private String imagepath;
	
}
