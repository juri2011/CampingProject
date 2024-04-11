package com.campingga.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.campingga.domain.OrderListVO;

public interface OrderMapper {
	//public int insertBill(BillVO vo);
	
	//public int deleteAllBill(String mem_id);
	
	public int insertOrder(OrderListVO vo);
	
	public List<OrderListVO> getOrderList(String mem_id);
	
	public List<OrderListVO> getAllOrders();
	
	OrderListVO findByOrdNo(@Param("ord_no") String ord_no);
	
    void updateOrder(OrderListVO vo);
}
