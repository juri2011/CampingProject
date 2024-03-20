package com.campingga.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.campingga.mapper.PaymentMapper;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class PaymentService {
	
	@Autowired
	private PaymentMapper paymentMapper;


	

}
