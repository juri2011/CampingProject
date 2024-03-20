package com.campingga.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Gclaim {
	private int glno;
	private int gno;
	private String id;
	private String content;
	private Date regidate;
	private Date updatedate;
	private int status;
	
	private int rownum;
	private int total;
}
