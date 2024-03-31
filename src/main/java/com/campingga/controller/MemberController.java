package com.campingga.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.campingga.domain.MemberVO;
import com.campingga.service.MemberService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member")
public class MemberController {
	
	@Autowired// 하나 일 경우 생략가능.
	private MemberService memberservice;
	
	//회원가입 페이지 이동
	@GetMapping("/join")
	public void loginGET() {
		
		log.info("회원가입 페이지 진입");
		
	}
	
	//회원가입
		@PostMapping("/join")
		public String joinPOST(MemberVO member) throws Exception{
			
			log.info("join 진입");
			
			// 회원가입 서비스 실행
			memberservice.memberJoin(member);
			
			log.info("join Service 성공");
			
			return "redirect:/main";
			
		}
	
	//로그인 페이지 이동
	@GetMapping("/login")
	public void joinGET() {
		
		log.info("로그인 페이지 진입");
		
	}
}
