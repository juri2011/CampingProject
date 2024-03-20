package com.campingga.mapper;

import java.util.List;

import com.campingga.domain.Common;
import com.campingga.domain.Goods;

public interface GoodsMapper {
	
	public Goods selectOneItem(int gno);
	
	public List<Goods> selectListByCategory(int category);
	
	public List<Goods> selectListByCateAndSkin(Goods goods);
	
	public void insertItem(Goods goods);
	
	public void updateItem(Goods goods);
	
	public void deleteItem(int gno);
	
	public void selectImageList(int gno); //�긽�뭹紐⑸줉�쓣 遺덈윭�삱 �븣 遺덈윭�삱 �씠誘몄�由ъ뒪�듃
	
	public int getGoodsNo();
	
	public List<Goods> goodsList(Common common);
	
	public List<Goods> selectSearchList(Common common);

	public List<Goods> selectGoodsOrderList(Common common);

	public void updateFilePath(Goods goods);
}
