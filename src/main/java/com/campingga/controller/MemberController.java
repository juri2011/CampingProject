package com.campingga.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.campingga.domain.MemberVO;
import com.campingga.service.MemberService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member")
public class MemberController {

	@Autowired // 하나 일 경우 생략가능.
	private MemberService memberservice;

	// 회원가입 페이지 이동
	@GetMapping("/join")
	public void loginGET() {

		log.info("회원가입 페이지 진입");

	}

	// 회원가입
	@PostMapping("/join")
	public String joinPOST(MemberVO member) throws Exception {

		log.info("join 진입");

		// 회원가입 서비스 실행
		memberservice.memberJoin(member);

		log.info("join Service 성공");

		return "redirect:/main";

	}

	// 아이디 중복 검사
	@PostMapping("/memberIdChk")
	@ResponseBody
	public String memberIdChkPOST(String mem_id) throws Exception {

		log.info("memberIdChk() 진입");

		int result = memberservice.idCheck(mem_id);

		log.info("결과값 = " + result);

		if (result != 0) {

			return "fail"; // 중복 아이디가 존재

		} else {

			return "success"; // 중복 아이디 x

		}
	} // memberIdChkPOST() 종료

	// 로그인 페이지 이동(시큐리티)
	@GetMapping("/customLogin")
	public void joinGET(String error, String logout, Model model) {
		
		log.info("로그인 페이지 진입");
		log.info("error: "+error);
		log.info("logout: "+logout);
		
		if(error != null) {
			model.addAttribute("error","사용자 ID 또는 비밀번호를 잘못 입력하셨습니다.");
		}
		if(logout != null) {
			model.addAttribute("logout","로그아웃 되었습니다.");
		}

	}
	// 로그인 페이지 이동
	@GetMapping("/login")
	public void joinGET() {
		
		log.info("로그인 페이지 진입");
		
	}
	/* 로그인 */
	@PostMapping("/login")
	public String loginPOST(HttpServletRequest request, MemberVO member, RedirectAttributes rttr) throws Exception {

		// System.out.println("login 메서드 진입");
		// System.out.println("전달된 데이터 : " + member);

		HttpSession session = request.getSession();
		MemberVO lvo = memberservice.memberLogin(member);

		// 일치하지 않는 아이디, 비밀번호 입력 경우
		if (lvo == null) {

			int result = 0;
			rttr.addFlashAttribute("result", result);
			return "redirect:/member/login";

		}

		// 일치하는 아이디, 비밀번호 경우 (로그인 성공)
		//session.setAttribute("member", lvo);

		return "redirect:/main";
	}
	/*
	 * 메인페이지 로그아웃
	 * 
	 * @GetMapping("/logout.do") public String logoutMainGET(HttpServletRequest
	 * request) throws Exception{
	 * 
	 * log.info("logoutMainGET메서드 진입");
	 * 
	 * HttpSession session = request.getSession();
	 * 
	 * session.invalidate();
	 * 
	 * return "redirect:/main";
	 * 
	 * }
	 */

	/* 비동기방식 로그아웃 메서드 */
	@PostMapping("/logout.do")
	@ResponseBody
	public void logoutPOST(HttpServletRequest request) throws Exception {

		log.info("비동기 로그아웃 메서드 진입");

		HttpSession session = request.getSession();

		session.invalidate();

	}
	
	

}
