package com.campingga.mapper;

import java.util.Date;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
<<<<<<< Updated upstream

import com.campingga.domain.MemberVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
=======
import org.springframework.test.web.servlet.result.MockMvcResultHandlers;

import com.campingga.domain.MemberVO;

import lombok.extern.log4j.Log4j;
import lombok.extern.log4j.Log4j2;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
>>>>>>> Stashed changes
public class MemberMapperTests {

	@Autowired
	private MemberMapper membermapper;			//MemberMapper.java 인터페이스 의존성 주입
	
	//회원가입 쿼리 테스트 메서드
	@Test
	public void memberJoin() throws Exception{
		MemberVO member = new MemberVO();
		
<<<<<<< Updated upstream
		  member.setMem_id("test00");          // 회원ID Primary key설정
	        member.setPwd("password123");         // 비밀번호
	        member.setName("John Doe");            // 이름
	        member.setBirth(new Date());           // 생일 (현재 날짜)
	        member.setPhone("123-456-0000");      // 휴대폰번호 unique설정
	        member.setGender("Male");              // 성별
	        member.setEmail("john.doe@example.com"); // 이메일
=======
		  member.setMem_id("test04");          // 회원ID Primary key설정
	        member.setPwd("password123");         // 비밀번호
	        member.setName("John Doe");            // 이름
	        member.setBirth(new Date());           // 생일 (현재 날짜)
	        member.setPhone("123-456-0400");      // 휴대폰번호 unique설정
	        member.setGender("Male");              // 성별
	        member.setEmail("john.doe@example.com"); // 이메일
	        member.setUserStnum("17046");				//지번
>>>>>>> Stashed changes
	        member.setUserAddr("123 Street, City"); // 주소
	        member.setUserDaddr("Apt 101");        // 상세주소
		
		membermapper.memberJoin(member);			//쿼리 메서드 실행
		
<<<<<<< Updated upstream
=======
		
		
	}
	
	// 아이디 중복검사
	@Test
	public void mem_idChk() throws Exception{
		String id = "dw";	// 존재하는 아이디
		String id2 = "test123";	// 존재하지 않는 아이디
		membermapper.idCheck(id);
		membermapper.idCheck(id2);
>>>>>>> Stashed changes
	}


	
	
}