package com.campingga.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.campingga.domain.ItemVO;

public interface ItemService {
	List<ItemVO> getList();
}