package com.campingga.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class QnA {
	private int qno; // pk
	private String id; // 유저아이디
	private String title;
	private String content;
	private Date regiDate;
	private Date updateDate;
	private String status;
}
