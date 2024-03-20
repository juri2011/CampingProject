package com.campingga.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.campingga.service.PaymentService;

import lombok.extern.log4j.Log4j;

@RequestMapping("/payment/*")
@Controller
@Log4j
public class PaymentController {

	@Autowired
	private PaymentService paymentService;

	@RequestMapping("/payment.do")
	public String form(Model model) {

		return "home";
	}

}
