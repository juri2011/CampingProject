package com.campingga.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.campingga.domain.Goods;
import com.campingga.mapper.GoodsMapper;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class GoodsMapperTests {

	@Autowired
	private GoodsMapper mapper;
	
	@Test
	public void testselectOneItem() {		
		Goods goods = mapper.selectOneItem(1);
		log.info(goods);
	}
	
	@Test
	public void testselectListByCategory() {
		List<Goods>goods = mapper.selectListByCategory(1);
		log.info(goods);
	}
	
	@Test
	public void testselectListByCateAndSkin() {
		Goods goods = new Goods();
		goods.setCategory("1");
		goods.setSkintype("1");
		List<Goods>goodslist = mapper.selectListByCateAndSkin(goods);
		log.info(goodslist);
	}
	
	@Test
	public void testinsertItem() {
		Goods goods = new Goods();
		goods.setCategory("1");
		goods.setPname("ezen");
		//goods.setPrice(10000);
		goods.setSkintype("1");
		goods.setStock(5);
		goods.setStatus("1");
		mapper.insertItem(goods);
	}
	
	@Test
	public void testupdateItem() {
		Goods goods = new Goods();
		goods.setCategory("1");
		goods.setPname("ezen");
		//goods.setPrice(20000);
		goods.setSkintype("1");
		goods.setStock(20);
		goods.setStatus("1");
		goods.setGno(1);
		mapper.updateItem(goods);
	}
	
	@Test
	public void testdeleteItem() {
		Goods goods=new Goods();
		
		mapper.deleteItem(2);
	}
	
	
	public void testselectImageList() {
		mapper.selectImageList(1);
	}
}
