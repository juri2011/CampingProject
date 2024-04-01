package com.campingga.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.campingga.domain.MemberVO;
import com.campingga.mapper.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService{

	@Autowired
	MemberMapper membermapper;

	@Override
	public void memberJoin(MemberVO member) throws Exception {
		
		membermapper.memberJoin(member);
		
	}
<<<<<<< Updated upstream
=======

	@Override
	public int idCheck(String mem_id) {
		
		return membermapper.idCheck(mem_id);
	}
	
	
>>>>>>> Stashed changes
	
	
	
}
