package com.campingga.service;

import java.util.List;

import com.campingga.domain.OrderListVO;

public interface OrderService {

	public int addOrder(OrderListVO vo);
	
	public List<OrderListVO> getOrderList(String mem_id);
	/*
	 * //구매 테이블에 저장 public int addBill(BillVO bill);
	 * 
	 * //구매 테이블 전체 삭제 public int removeAllBill(String mem_id);
	 */
	public List<OrderListVO> getAllOrders();
	
	public void updateOrderStatus(String ord_no, String cart_no, String status);
}
