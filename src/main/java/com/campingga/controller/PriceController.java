package com.campingga.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.campingga.service.PriceService;

@RestController
public class PriceController {
	
	@Autowired
	PriceService service;
	
	@GetMapping("/price")
	public int price(@RequestParam("price") int price, @RequestParam("quantity") int quantity ) {
		return service.calcPrice(price, quantity);
	}
}
