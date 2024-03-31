package com.campingga.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.campingga.domain.Criteria;
import com.campingga.domain.ItemVO;
import com.campingga.service.ItemService;

@Controller
@RequestMapping("/item")
public class ItemController {

	@Autowired
	private ItemService itemService;
	
	@GetMapping("/list")
	public String showList(Criteria cri, Model model){
		List<ItemVO> itemList = itemService.getListWithPaging(cri);
		model.addAttribute("itemList", itemList);
		System.out.println(itemList);
		return "listTest";
	}
}
