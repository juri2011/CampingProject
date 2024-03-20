package com.campingga.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.campingga.domain.Common;
import com.campingga.domain.OrderList;
import com.campingga.service.OrderService;

import lombok.extern.log4j.Log4j;


/*
 * �����ڿ� ��ǰ����
 * �������� �ù踦 �����ȣ�� �ù� �ڵ带 ����ϱ� ���� ���
 */

@RequestMapping("/track/")
@Controller
@Log4j
public class TrackController {
	
	@Autowired
	private OrderService orderService;

	@Value("${smartapi.key}")
	private String apikey;
	
	@RequestMapping("/main.do")
	public String main(Model model,Common common) {
		
		List<OrderList> list = orderService.getOrderList(common);
		
		model.addAttribute("orderList",list);
		
		return "/tracking/tracktest";
	}
	
	@RequestMapping("/list.do")
	public String goodslist(Model model, @RequestParam("orderlistNo") int orderlistNo,@RequestParam("gno") int gno) {

		log.info("list.do.........");
		Map<String,Object> info = orderService.getOrder(orderlistNo,gno);
		
		model.addAttribute("info",info);
		
		model.addAttribute("key",apikey);

		
		return "tracking/tracklist";
	}
	
	
	@RequestMapping("/save")
	public void save() {
		
	}
	
}
