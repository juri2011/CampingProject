package com.campingga.mapper;

import java.util.List;

import com.campingga.domain.OrderListVO;

public interface OrderMapper {
	//public int insertBill(BillVO vo);
	
	//public int deleteAllBill(String mem_id);
	
	public int insertOrder(OrderListVO vo);
	
	public List<OrderListVO> getOrderList(String mem_id);
}
