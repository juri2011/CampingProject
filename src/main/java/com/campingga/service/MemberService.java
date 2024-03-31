package com.campingga.service;

import com.campingga.domain.MemberVO;

public interface MemberService {

	//회원가입
	public void memberJoin(MemberVO member) throws Exception;
	
}
