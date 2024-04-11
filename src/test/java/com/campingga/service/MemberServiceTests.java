package com.campingga.service;


import java.util.Date;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.campingga.domain.MemberVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MemberServiceTests {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private PasswordEncoder pwencoder;
	//회원가입 + 권한 테스트
	@Test
	public void memberJoinTest() throws Exception{
		MemberVO member = new MemberVO();
		member.setMem_id("juri");
		member.setBirth(new Date());
		member.setEmail("juri@test.com");
		member.setGender("여성");
		member.setPhone("010-0000-0000");
		member.setPwd(pwencoder.encode("12345"));
		member.setName("오주리");
		member.setUserStnum("12345");
		member.setUserAddr("경기도 용인시 기흥구");
		member.setUserDaddr("상세주소");
		
		memberService.memberJoin(member);
		
	};
}
