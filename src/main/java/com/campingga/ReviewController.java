package com.campingga;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.campingga.domain.Common;
import com.campingga.domain.Review;
import com.campingga.service.ReviewService;

import lombok.extern.log4j.Log4j;


@RequestMapping("/review/")
@Controller
@Log4j
public class ReviewController {
	
	@Autowired
	private ReviewService reviewService;
	
	@PostMapping("/save.do")
	public String review(Model model,Review review) {

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		
		System.out.println(review);
		review.setMemId(auth.getName());
		
		log.info("ID: " + review.getMemId());
		
		reviewService.insertReview(review);
		
		return "redirect:/goodsDetail/" + review.getGoodsNo();

	}
	
	
	@RequestMapping("/form.do")
	public String form(Model model,@RequestParam("gno") int gno) {
		System.out.println("test");
		
		model.addAttribute("gno",gno);
		
		return "/review/form";
	}

	@RequestMapping("/remove.do")
	public String remove(Model model,@RequestParam("reviewNo") int reviewNo) {
		
		return "redirect://";
	}
	
	@RequestMapping("/list")
	public String list(Model model,Common common,@RequestParam("gno") int gno) {
		
		List<Review> reviewList = reviewService.getReviewList(common,gno);
		
		model.addAttribute("reviewList", reviewList);		
		model.addAttribute("gno", gno);

		return "/review/list";
	}

}
