package com.campingga.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.*;

@Getter
@Setter
@ToString
public class MemberVO {
	private String mem_id;//아이디.
	private String pwd;//비밀번호
	private String name;//이름
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date birth;//생일
	private String phone;//휴대폰번호
	private String gender;//성별
	private String email;//이메일
	private String userStnum;
	private String userAddr;//주소
	private String userDaddr;//상세주소
	private Date regdate;//가입일
	private String mem_status; //상태(1: 정상, 2: 탈퇴)
}	