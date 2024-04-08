package com.campingga.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.campingga.domain.Criteria;
import com.campingga.domain.ItemVO;
import com.campingga.domain.PagingVO;
import com.campingga.mapper.ItemMapper;

@Service
public class ItemServiceImpl implements ItemService{
	
	@Autowired
	private ItemMapper itemMapper;
	
	@Override
	public List<ItemVO> getNewItems(){
		return itemMapper.selectNewItems();
	}
	
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

	@Override
	public ItemVO get(int item_no) {
		return itemMapper.selectOneItem(item_no);
	}

	@Override
	public int countItem() {
		return itemMapper.countItem();
	}

	@Override
	public List<ItemVO> selectItem(PagingVO vo) {
		return itemMapper.selectItem(vo);
	}

	@Override
	public int itemUpdate(ItemVO vo) {
		return itemMapper.itemUpdate(vo);
	}

	@Override
	public int deleteItem(int item_no) {
		
		return itemMapper.deleteItem(item_no);
	}


	
	
	

}
