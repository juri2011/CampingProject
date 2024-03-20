package com.campingga.domain;

import java.util.Date;

import lombok.Data;

@Data
public class AnswerClaim {

	private int anscno;	//pk
	private int glno;	//fk
	private String title;
	private String content;
	private Date regidate;
	private Date updatedate;
	private String status;
	
	private int rownum;
	private int total;
}
