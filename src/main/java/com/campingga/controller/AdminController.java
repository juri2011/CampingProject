package com.campingga.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.campingga.domain.Adminclaim;
import com.campingga.domain.AnswerClaim;
import com.campingga.domain.Common;
import com.campingga.domain.Gclaim;
import com.campingga.domain.Goods;
import com.campingga.service.ClaimService;
import com.campingga.service.GoodsService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/")
public class AdminController {
	
	@Autowired
	private ClaimService claimService;
	
	@Autowired
	private GoodsService goodsService;
	
	@RequestMapping("/mod")
	public String modPage() {
		
		return null;
	}
	
	@RequestMapping("/answer")
	public String answer() {
		return null;
	}

	@GetMapping("/claims")
	public String claimlist(Model model, Common common) {
		log.info("claimlist() called");
		List<Adminclaim> claimlist = claimService.showlistAll(common);
		model.addAttribute("claimlist", claimlist);
		model.addAttribute("section", common.getSection());
		model.addAttribute("pagenum", common.getPageNum());
		
		if(claimlist.size() > 0)
			model.addAttribute("tot", claimlist.get(0).getTotal());
		return "/claim/manageClaim";
	}
	
	@GetMapping("/claims/claim")
	public String viewClaim(Model model, int gclaim_no) {
		log.info("viewClaim() called");
		
		Gclaim claim = claimService.showOneClaim(gclaim_no);
		Goods goods = goodsService.showOneItem(claim.getGno());
		model.addAttribute("claim", claim);
		model.addAttribute("goods", goods);
		
		return "/claim/view";
	}
	
	@GetMapping("/claims/answer")
	public String viewAnswer(Model model, int answer_no) {
		log.info("viewAnswer() called");
		
		AnswerClaim answer = claimService.showOneAnswer(answer_no);
		Gclaim gclaim = claimService.showOneClaim(answer.getGlno());
		Goods goods = goodsService.showOneItem(gclaim.getGno());
		
		model.addAttribute("answer", answer);
		model.addAttribute("gclaim", gclaim);
		model.addAttribute("goods", goods);
		
		return "/claim/view";
	}
	
	@GetMapping("/answerToClaim/write")
	public String answerToClaim(Model model, @RequestParam("glno")int glno) {
		log.info("answerToClaim() called");
		
		log.info("glno: " + glno);
		
		model.addAttribute("type", "write");
		model.addAttribute("glno", glno);
		
		return "/claim/answerClaim";
	}
	
	@GetMapping("/answerToClaim/modify")
	public String updateAnswer(Model model, @RequestParam("answer_no")int anscno) {
		log.info("updateAnswer() called");
		
		log.info("anscno: " + anscno);
		
		AnswerClaim answer = claimService.showOneAnswer(anscno);
				
		model.addAttribute("type", "modify");
		model.addAttribute("anscno", anscno);
		model.addAttribute("answer", answer);
		model.addAttribute("glno", answer.getGlno());
		
		return "/claim/answerClaim";
	}
	
	@PostMapping("/reganswer.do")
	public String processAnswer(AnswerClaim answer) {
		claimService.answerToClaim(answer);
		
		String gclaim_no = String.valueOf(answer.getGlno());
			
		return "redirect:/admin/claims/claim?gclaim_no="+gclaim_no;
	}
	
	@PostMapping("/updatepro.do")
	public String updateAnswer(AnswerClaim answer) {
		log.info("updateAnswer() called");
		
		claimService.updateprocess(answer);
		
		String answer_no = String.valueOf(answer.getAnscno());
		
		return "redirect:/admin/claims/answer?answer_no="+answer_no;
	}
	
	@PostMapping("/deleteAnswer")
	public String deleteAnswer(int anscno) {
		
		claimService.deleteClaimAnswer(anscno);
		
		return "redirect:/admin/claims";
	}
	
	@PostMapping("/clearcase")
	public String deletecase(int glno) {
		
		claimService.clearClaim(glno);
		
		return "redirect:/admin/claims";
	}

}
