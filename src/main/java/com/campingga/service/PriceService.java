package com.campingga.service;

import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;

@Service 
@Log4j
public class PriceService {
	
	public int calcPrice(int quantity, int price) {
		return quantity * price;
	}

}
