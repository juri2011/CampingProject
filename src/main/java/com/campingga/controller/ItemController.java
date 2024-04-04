package com.campingga.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.campingga.domain.AttachImageVO;
import com.campingga.domain.Criteria;
import com.campingga.domain.ItemVO;
import com.campingga.domain.PageDTO;
import com.campingga.mapper.AttachMapper;
import com.campingga.service.ItemService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/item")
@Log4j
public class ItemController {

	@Autowired
	private ItemService itemService;
	
	@Autowired
	private AttachMapper attachMapper;
	
	//페이징으로 아이템 출력(기본값 1페이지)
	@GetMapping("/list")
	public String showList(@ModelAttribute("cri") Criteria cri, Model model){
		//검색기준으로 상품 리스트 받아옴
		List<ItemVO> itemList = itemService.getListWithPaging(cri);
		//리스트 전달
		model.addAttribute("itemList", itemList);
		//페이지네이션 정보 전달
		model.addAttribute("pageMaker", new PageDTO(cri,itemService.getTotalCount(cri)));
		//listTest.jsp로 이동(기존 list.jsp로 합치면 수정할 예정)
		return "/item/list";
	}
	
	/* 이미지 정보 반환 */
	@GetMapping(value="/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<AttachImageVO>> getAttachList(int item_no){
		
		log.info("getAttachList.........." + item_no);
		
		return new ResponseEntity<List<AttachImageVO>>(attachMapper.getAttachList(item_no), HttpStatus.OK);
		
	}
	
	//int -> Integer/long형
	@GetMapping("/detail")
	public void get(@RequestParam("item_no") int item_no, @ModelAttribute("cri") Criteria cri, Model model) {
	    
	    log.info("/get or /modify");
	    model.addAttribute("item",itemService.get(item_no));
	    model.addAttribute("cri",cri);
	  }
}
