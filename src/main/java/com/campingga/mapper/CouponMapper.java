package com.campingga.mapper;

import java.util.List;

import com.campingga.domain.Coupon;

public interface CouponMapper {

	public List<Coupon> selectCouponList();
	
	public Coupon selectOneCoupon(int id);
	
	public void insertCoupon(Coupon coupon);
	
	public void updateCouponStatus(Coupon coupon);
	
	public void deleteCoupon(int id);
}
