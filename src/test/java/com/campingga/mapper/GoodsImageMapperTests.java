package com.campingga.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;


import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class GoodsImageMapperTests {
	/*
	@Autowired
	GoodsImageMapper mapper;
	
	@Test
	public void testselectImgs(){
		List<GoodsImage> images= mapper.findByGno(1);
		log.info(images);
	};
	
	@Test
	public void testinsertImg() {
		GoodsImage image = new GoodsImage();
		image.setGno(1);
		image.setIno(1);
		image.setImagepath("a");
		mapper.insert(image);
	};
	
//	@Test
//	public void testupdateImg() {
//		mapper.updateImg();
//	};
	
	@Test
	public void testdeleteImg() {
		mapper.delete("");
	};*/
}
