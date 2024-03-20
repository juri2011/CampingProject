package com.campingga.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class Member {
	private String mem_id;
	private String name;
	private String pwd;
	private String pnum;
	private String email;
	private String userAddr;
	private String userDaddr;
	private int grade;
	private Date regidate;
	private Date updatedate;
	private String status;
	private List<Authority> authList;
}
