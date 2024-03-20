package com.campingga.mapper;

import java.util.List;

import com.campingga.domain.GoodsImage;

public interface GoodsImageMapper {
	
	public int insert(GoodsImage vo);
	
	public void delete(String uuid);
	
	public List<GoodsImage> findByGno(int gno);
		
}
