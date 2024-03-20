package com.campingga.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.campingga.domain.Authority;
import com.campingga.domain.Member;
import com.campingga.mapper.MemberMapper;

import lombok.extern.log4j.Log4j;

@Log4j
@Service 
public class MemberService {
	
	@Autowired
	private MemberMapper memberMapper;
	
	
	public void join(Member member) {
		memberMapper.insertMember(member);
		
		Authority auth = new Authority();
		auth.setMem_id(member.getMem_id());
		auth.setAuth("ROLE_MEMBER");
		memberMapper.insertAuth(auth);
	}
	
	public Member login(String id) {
		log.info("ID: "+id);
		return memberMapper.selectMemberaslogin(id);
	}
	
	public Member memberInfo(String id) {
		return memberMapper.selectMember(id);
	}
	
	public int idCheck(String id) {
		return memberMapper.selectbyidCheck(id);
	}

	public void editInfo(Member member) {
		memberMapper.updateMember(member);
	}
	
	public void withdrawal(String id) {
		memberMapper.deleteMember(id);
	}
}
