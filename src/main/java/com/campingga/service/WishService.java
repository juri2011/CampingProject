package com.campingga.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.campingga.domain.Wish;
import com.campingga.mapper.WishMapper;

@Service
public class WishService {
	
	@Autowired
	WishMapper mapper;
	public int addWish(String memid, int gno) {
		return mapper.insertWish(memid, gno);
	};
	
	public int removeWish(String memid, int gno) {
		return mapper.deleteWish(memid, gno);
	}
	
	public List<Wish> showMyWishes(String memid){
		return mapper.selectWishList(memid);
	}
	
	public int getWishCount(String memid) {
		return mapper.selectWishCount(memid);
	}

	public int getWishCount2(String memid,int gno) {
		return mapper.selectWishCount2(memid,gno);
	}

}
