package com.campingga.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.campingga.domain.Wish;

public interface WishMapper {
	
	public int insertWish(@Param("memid") String memid,@Param("gno") int gno);
	
	public int deleteWish(String memid, int gno);
	
	public List<Wish> selectWishList(String memid);
	
	public int selectWishCount(String memid);

	public int selectWishCount2(@Param("memid") String memid,@Param("gno") int gno);

	
}
