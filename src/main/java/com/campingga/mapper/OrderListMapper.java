package com.campingga.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.campingga.domain.Common;
import com.campingga.domain.OrderAddress;
import com.campingga.domain.OrderList;
import com.campingga.domain.OrderPayment;

public interface OrderListMapper {
	int insertOrder(OrderList orderList);
	
	int insertOrderPayment(OrderPayment orderPayment);
	
	int insertOrderAddress(OrderAddress orderAddress);

	public List<OrderList> selectOrderList(Common com);
	
	public Map<String,Object> selectOrderId(@Param("orderlistNo") int orderlistNo, @Param("gno") int gno );

	public int insertOrderList(OrderList orderlist);
	
	public int updateOrderList(OrderList orderlist);

	public int deleteOrderList(int orderlistNo);

	public int updateWaybillData(OrderList orderlist);

}
