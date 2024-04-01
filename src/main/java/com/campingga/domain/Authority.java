package com.campingga.domain;

import lombok.*;

@Getter
@Setter
@ToString 
public class Authority {
	private String mem_id; //아이디
	private String auth; //권한(1: 멤버, 2: 운영자, 3: 관리자)
}
