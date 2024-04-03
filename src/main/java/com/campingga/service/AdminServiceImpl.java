package com.campingga.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.campingga.domain.ItemVO;
import com.campingga.mapper.AdminMapper;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class AdminServiceImpl implements AdminService {

	@Autowired
	private AdminMapper adminMapper;

	/* 상품 등록 */
	@Override
	public void itemEnroll(ItemVO item) {

		log.info("(service)itemEnroll........");

		adminMapper.itemEnroll(item);
		
		// 상품 등록 시 이미지 존재 여부 체크 후 없으면, 메소드 조기 종료
		if(item.getImageList() == null || item.getImageList().size() <= 0) {
			return;
		}

		// 람다식 활용한 for문
		item.getImageList().forEach(attach -> {

			attach.setItem_no(item.getItem_no());
			adminMapper.imageEnroll(attach);

		});

	}

}
