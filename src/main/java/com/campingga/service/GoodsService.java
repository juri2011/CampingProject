package com.campingga.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.campingga.domain.Common;
import com.campingga.domain.Goods;
import com.campingga.mapper.GoodsMapper;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class GoodsService {
	
	@Autowired
	private GoodsMapper mapper;
	
	public Goods showOneItem(int gno) {
		log.info("-- show one item --");
		return mapper.selectOneItem(gno);
	}
	
	public List<Goods> showListByCategory(int category){
		log.info("-- show item list by category --");
		return mapper.selectListByCategory(category);
	}
	
	public List<Goods> showListByCateAndSkin(Goods goods){
		log.info("-- show item list by category and skin-type --");
		return mapper.selectListByCateAndSkin(goods);
	}
	
	public void registerItem(Goods goods) {
		log.info("-- insert goods --");
		mapper.insertItem(goods);
	}
	
	public void modifyItem(Goods goods) {
		log.info("-- update goods --");
		mapper.updateItem(goods);
	}
	
	public void deleteItem(int gno) {
		log.info("-- delete goods --");
		mapper.deleteItem(gno);
	}
	
	public void callImageList(int gno) {
		log.info("-- call image list -- ");
		mapper.selectImageList(gno);
	}
	
	public int getGno() {
		log.info("-- get gno --");
		return mapper.getGoodsNo();
	}
	
	public List<Goods> goodsList(Common common){
		return mapper.goodsList(common);
	}
	
	public List<Goods> getSearchGoodsList(Common common){
		return mapper.selectSearchList(common);
	}

	
	public List<Goods> getGoodsOrderList(Common common){
		return mapper.selectGoodsOrderList(common);
	}

	
	public void updateFilePath(Goods goods) {
		mapper.updateFilePath(goods);
	}
}
