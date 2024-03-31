package com.campingga.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.campingga.domain.Criteria;
import com.campingga.domain.ItemVO;
import com.campingga.mapper.ItemMapper;

@Service
public class ItemServiceImpl implements ItemService{
	
	@Autowired
	private ItemMapper itemMapper;
	
	@Override
	public List<ItemVO> getList() {
		return itemMapper.selectList();
	}

	@Override
	public List<ItemVO> getListWithPaging(Criteria cri) {
		return itemMapper.selectListWithPaging(cri);
	}

	@Override
	public int getTotalCount(Criteria cri) {
		return itemMapper.selectTotalCount(cri);
	}

}
