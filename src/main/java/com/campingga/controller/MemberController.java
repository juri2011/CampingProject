package com.campingga.controller;

import static com.campingga.security.SHA2.sha256;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.campingga.domain.Member;
import com.campingga.service.CartService;
import com.campingga.service.MemberService;

import lombok.extern.log4j.Log4j;

@RequestMapping("/member/")
@Controller
@Log4j
public class MemberController {
	
	@Autowired
	private MemberService service;
	
	@Autowired
	CartService cartService;


	
	@GetMapping("/login")
	public String loginInput(String error, String logout, Model model) {

		log.info("error: " + error);
		log.info("logout: " + logout);
	
		return "customlogin";
	}
	
	@GetMapping("/join")
	public String joinform() {
		log.info("=========join========");
		return "join";
	}
	
	@PostMapping("/join.do")
	public String join(Member member) {
		log.info("-------dojoin--------");
		String password=member.getPwd();
		member.setPwd(sha256(password));
		System.out.println(member.getMem_id());
		System.out.println(member.getName());
		System.out.println(member.getPwd());
		System.out.println(member.getPnum());
		System.out.println(member.getEmail());
		service.join(member);
		return "redirect:/member/login";
	}
	
	@GetMapping("/profile")
	public String profile(Model model, String id) {
		Member member = new Member();
		service.memberInfo(id);
		model.addAttribute("member", member);
		return null;
	}
	
	@RequestMapping("/edit")
	public String edit(Member member) {
		service.editInfo(member);
		return null;
	}
	
	@RequestMapping("/farewell")
	public String farewell(String id) {
		service.withdrawal(id);
		return "redirect:/";
	}
	
	@RequestMapping("/checkId.do")
	@ResponseBody
	public String idCheck(ModelMap model, HttpServletRequest request, String mem_id){
		String result = "";
		if(service.idCheck(mem_id) == 1) {
			result = "fail";
		}else {
			result = "success";
		}
		
		return result;
	}
}
