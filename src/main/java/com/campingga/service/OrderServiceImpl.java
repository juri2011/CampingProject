package com.campingga.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.campingga.domain.BillVO;
import com.campingga.domain.CartVO;
import com.campingga.domain.OrderListVO;
import com.campingga.mapper.OrderMapper;

@Service
public class OrderServiceImpl implements OrderService{

	@Autowired
	private OrderMapper orderMapper;
	/*
	 * @Override public int addBill(BillVO bill) { return
	 * orderMapper.insertBill(bill); }
	 * 
	 * @Override public int removeAllBill(String mem_id) { return
	 * orderMapper.deleteAllBill(mem_id); }
	 */

	@Override
	public int addOrder(OrderListVO vo) {
		return orderMapper.insertOrder(vo);
	}

	@Override
	public List<OrderListVO> getOrderList(String mem_id) {
		return orderMapper.getOrderList(mem_id);
	}
}
