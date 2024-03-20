package com.campingga.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.campingga.domain.GoodsImage;
import com.campingga.mapper.GoodsImageMapper;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class GoodsImageService {
	
	@Autowired
	GoodsImageMapper mapper;

	public void insertGoodsImage(GoodsImage goodsImage) {
		log.info("goodsImage insert");
		mapper.insert(goodsImage);
	}

	public List<GoodsImage> getImageList(int gno) {
		log.info("goodsImage insert");
		return mapper.findByGno(gno);
	}

	

}


