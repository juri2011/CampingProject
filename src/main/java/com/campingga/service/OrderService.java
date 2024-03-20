package com.campingga.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.campingga.domain.Cart;
import com.campingga.domain.Common;
import com.campingga.domain.Goods;
import com.campingga.domain.OrderAddress;
import com.campingga.domain.OrderList;
import com.campingga.dto.req.NewOrder;
import com.campingga.dto.res.PaymentItem;
import com.campingga.mapper.CartMapper;
import com.campingga.mapper.GoodsMapper;
import com.campingga.mapper.OrderListMapper;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class OrderService {
	@Autowired
	OrderListMapper orderMapper;

	@Autowired
	CartMapper cartMapper;

	@Autowired
	GoodsMapper goodsMapper;

	@Transactional
	public PaymentItem newOrder(String id,List<NewOrder> dataList) {
		int totalAmount = 0;
		
		List<Integer> noList = new ArrayList<Integer>();

		for (int i = 0; i < dataList.size(); i++)
			noList.add(dataList.get(i).getCart());
		
		List<Cart> cartList = cartMapper.selectCartByCartNo(id, noList);
		
		
		for (int i = 0; i < cartList.size(); i++) {
			Cart cart = cartList.get(i);
			Goods goods = goodsMapper.selectOneItem(cart.getGoods_no());

			totalAmount += (goods.getSellPrice() * cart.getQuantity());
		}
		//배송비 추가
		totalAmount += 3500;
		
		log.debug("totalAmount::" + totalAmount);

		// 1. 주문 등록
		OrderList orderList = new OrderList();
		orderList.setMem_id(id);
		orderList.setTotprice(totalAmount);

		if (orderMapper.insertOrder(orderList) < 1) {
			return null;
		}

		// 2. 배송지 등록
		OrderAddress orderAddress = new OrderAddress();
		orderAddress.setOrder_no(orderList.getOrderlist_no());
		orderAddress.setName(dataList.get(0).getName());
		orderAddress.setPhone(dataList.get(0).getPhone());
		orderAddress.setAddr1(dataList.get(0).getAddr1());
		orderAddress.setAddr2(dataList.get(0).getAddr2());
		orderAddress.setMemo(dataList.get(0).getMemo());

		if (orderMapper.insertOrderAddress(orderAddress) < 1) {
			return null;
		}
		
		//3. 장바구니 업데이트
		if(cartMapper.updateCartOrderNo(id, orderList.getOrderlist_no(), noList) < 1) {
			return null;
		}

		return PaymentItem.builder().orderNo(orderList.getOrderlist_no()).totalPrice(totalAmount).build();
	}
	

	
	public List<OrderList> getOrderList(Common common) {
		return orderMapper.selectOrderList(common);
	}
	
	public Map<String,Object> getOrder(int orderlistNo,int gno) {
		return orderMapper.selectOrderId(orderlistNo,gno);
	}
	
	public int save(OrderList order) {
		if(order.getOrderlist_no() == 0)
			return orderMapper.insertOrderList(order);
		else
			return orderMapper.updateOrderList(order);

	}

	public int removeOrderList(int orderlistNo) {
		return orderMapper.deleteOrderList(orderlistNo);
	}
	
	public int updateWayData(OrderList order) {
		return orderMapper.updateWaybillData(order);
	}
	
}
