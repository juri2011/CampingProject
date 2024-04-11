package com.campingga.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.campingga.domain.OrderListVO;
import com.campingga.mapper.OrderMapper;

@Service
public class OrderServiceImpl implements OrderService {

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

	@Override
	public List<OrderListVO> getAllOrders() {
		return orderMapper.getAllOrders();
	}
	
	@Override
    public void updateOrderStatus(String ord_no, String status) {
        // 주문 업데이트 로직을 여기에 구현합니다.
		OrderListVO vo = orderMapper.findByOrdNo(ord_no);
        if (vo != null) {
        	vo.setStatus(status);
            orderMapper.updateOrder(vo);
        }
    }
}
