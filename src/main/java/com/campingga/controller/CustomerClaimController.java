package com.campingga.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.campingga.domain.Gclaim;
import com.campingga.service.ClaimService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class CustomerClaimController {

	@Autowired
	private ClaimService service;
	
	@GetMapping("/writeclaim/{type}/{gno}")
	public String goodsClaim(Model model, @PathVariable("type") String type, @PathVariable("gno") int gno, HttpServletRequest req) {
		Gclaim claim = new Gclaim();
		
		model.addAttribute("type", type);
		model.addAttribute("gno", gno);
		
		String gclaim_no=req.getParameter("gclaim_no");
		if(gclaim_no != null) {
			int glno = Integer.parseInt(gclaim_no);
			log.info("=========>"+glno);
			claim=service.showOneClaim(glno);
			model.addAttribute("claim", claim);
		}
		return "/claim/writeClaim";
	}
	
	@PostMapping("/regclaim.do")
	public String goodsClaimReg(Gclaim claim) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String id = auth.getName();
		log.info("id:"+id);
		claim.setId(id);
		service.sendClaim(claim);
		String gno = String.valueOf(claim.getGno());
		return "redirect:/goodsDetail/"+gno;
	}
	
	@PostMapping("/editclaim.do")
	public String editClaim(Gclaim claim, @RequestParam(value="glno", required=false) int glno) {
		claim.setGlno(glno);
		service.editClaim(claim);
		String gno = String.valueOf(claim.getGno());
		return "redirect:/goodsDetail/"+gno;
	}
	
}
