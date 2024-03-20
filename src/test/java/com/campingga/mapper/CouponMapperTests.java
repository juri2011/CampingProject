package com.campingga.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.campingga.domain.Coupon;
import com.campingga.mapper.CouponMapper;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class CouponMapperTests {

	@Autowired
	CouponMapper mapper;
	
	@Test
	public void testselectCouponList() {
		List<Coupon> coupons = mapper.selectCouponList();
		log.info(coupons);
	};
	
	@Test
	public void testselectOneCoupon() {
		Coupon coupon = mapper.selectOneCoupon(1);
		log.info(coupon);
	};
	
	@Test
	public void testinsertCoupon() {
		Coupon coupon = new Coupon();
		coupon.setCode("123");
		coupon.setCtype(1);
		coupon.setValue(10000);
		coupon.setCond("아아A");
		mapper.insertCoupon(coupon);
	};
	
	@Test
	public void testupdateCouponStatus() {
		Coupon coupon = new Coupon();
		coupon.setCtype(1);
		coupon.setCond("라떼B");
		coupon.setStatus(2);
		coupon.setId(1);
		mapper.updateCouponStatus(coupon);
	};
	
	@Test
	public void testdeleteCoupon() {
		mapper.deleteCoupon(1);
	};
	
}
