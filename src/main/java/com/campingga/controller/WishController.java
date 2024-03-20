package com.campingga.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.campingga.service.WishService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/wish/*")
public class WishController {
	
	@Autowired
	WishService service;
	
	@PostMapping("addwish")
	@ResponseBody
	public String addWish(@RequestParam Integer gno) {

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		
		String memid = auth.getName();
	
		log.info("logged-in ID: " + memid);
		
		int  i= service.getWishCount2(memid, gno);
		
		if(i == 0) {
			service.addWish(memid, gno);
			return "insert";
		}
		else if(i == 1) {
			service.removeWish(memid, gno);
			return "remove";
		}
		
		return null;
	}
}
