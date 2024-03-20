package com.campingga.mapper;

import java.util.List;

import com.campingga.menu.MenuVO;

public interface MenuMapper {

	
	public List<MenuVO> selectMenuList(String menuCd);
}
