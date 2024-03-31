package com.campingga.service;

import com.campingga.domain.MemberVO;

public interface MemberService {

	//회원가입
	public void memberJoin(MemberVO member) throws Exception;
	
<<<<<<< Updated upstream
=======
	//아이디 중복 검사
	public int idCheck(String mem_id);
	
>>>>>>> Stashed changes
}
