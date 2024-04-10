package com.campingga.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.TreeMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.campingga.common.CommonUtils;
import com.campingga.domain.CartVO;
import com.campingga.domain.ItemVO;
import com.campingga.domain.MemberVO;
import com.campingga.domain.OrderListVO;
import com.campingga.domain.PurchaseDTO;
import com.campingga.service.CartService;
import com.campingga.service.ItemService;
import com.campingga.service.MemberService;
import com.campingga.service.OrderService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/order")
@Log4j
public class OrderController {

	@Autowired
	public OrderService orderService;
	
	@Autowired
	public CartService cartService;
	
	@Autowired
	public ItemService itemService;
	
	@Autowired
	public MemberService memberService;
	
	//구매 화면으로 이동
	@GetMapping("/purchase")
	public String orderListForm(HttpSession session, Model model) {
		
		Boolean accessGranted = (Boolean) session.getAttribute("accessGranted");
		if(Boolean.TRUE.equals(accessGranted)) {
			session.removeAttribute("accessGranted");
			
			//session으로부터 user 정보 가져옴
				
			  Authentication auth = SecurityContextHolder.getContext().getAuthentication();   
		    String userId = auth.getName();
		    MemberVO user = memberService.getShippingInfo(userId);
		    log.info(user);
			List<CartVO> cartList = cartService.getCartItemList(userId);
			log.info(cartList);
			int totalPrice = cartService.getTotalPrice(cartList);
			log.info(totalPrice);
			model.addAttribute("totalPrice",totalPrice);
			model.addAttribute("cartList",cartList);
			model.addAttribute("member", user);
		
			return "order/purchase";
			
		}
		else {
			return "redirect:/";
		}
		
	}
	
	@PostMapping("/purchase/direct")
	public String orderListFormDirect(CartVO cartVO, Model model) {
		//String userId = "user003"; 임시
		
		List<CartVO> cartList = new ArrayList<CartVO>();
		cartList.add(cartVO);
		
		
		model.addAttribute("totalPrice",cartVO.getPrice() * cartVO.getQuantity());
		model.addAttribute("cartList",cartList);
		/*
		if(session.getAttribute("member") != null) {
			MemberVO member = (MemberVO) session.getAttribute("member");
			model.addAttribute("member", member);
		}
		*/
		//비회원으로 테스트해보기 -> 에러 예상
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();   
    String userId = auth.getName();
    MemberVO member = memberService.getShippingInfo(userId);
		model.addAttribute("member", member);
		return "order/purchase";
	}
	
	//장바구니 or 바로구매 버튼으로만 들어온 사용자에 한해서만 order/purchase 페이지 접근 가능하도록
	//세션 발행
	@PostMapping("/purchase")
	public String permitAccessToPuchase(HttpSession session) {
		session.setAttribute("accessGranted", true);
		return "redirect:/order/purchase";
	}
	
	/*
	시큐리티를 사용하는 코드이므로 보류
	@PostMapping("/purchase")
	@ResponseBody
	public AjaxRes newOrder(@RequestBody List<NewOrder> cartList) {
		String id = null;
		
		// 로그인 유저 체크
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth.getName() == null || auth.getName().equals("") || auth.getName().equals("anonymousUser")) {
			// 미로그인 상태
			return AjaxRes.builder().status("FAIL").message("Not logged in").build();
		}
		
		id = auth.getName();
		PaymentItem paymentItem = orderService.newOrder(id,cartList);
		if(paymentItem == null) {
		}
		
		return AjaxRes.builder().status("SUCCESS").data(paymentItem).build();
	}
	*/
	
	@GetMapping("/orderList")
	public String orderList(Model model) {
	  Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String mem_id = auth.getName();
		
		List<OrderListVO> orderList = orderService.getOrderList(mem_id);
		
		//TreeMap은 기본적으로 오름차순이기 때문에 내림차순으로 정렬하도록 지정
		Map<String, List<OrderListVO>> orderMap = new TreeMap<>(Collections.reverseOrder());
		Map<String, Integer> totalPriceMap = new HashMap<>();
		
		
		//주문번호별로 그룹화
		for(OrderListVO order : orderList) {
			
			//order의 item_no를 이용해서 아이템정보(이름, 가격)등을 받아온다.
			ItemVO item = itemService.get(order.getItem_no());
			order.setItem_name(item.getItem_name());
			order.setPrice(item.getPrice());
			
			//주문번호로 key 생성
			String orderKey = order.getOrd_no();
			
			//아직 주문번호로 key값이 만들어지지 않았으면 생성 (초기화)
			if (!orderMap.containsKey(orderKey)) {
                orderMap.put(orderKey, new ArrayList<>());
                totalPriceMap.put(orderKey, 0);
            }
			log.info("================================"+order.getAmount());
			//주문번호 key로 ArrayList value에 현재 order를 추가
			orderMap.get(orderKey).add(order);
			
			int totalPrice = totalPriceMap.get(orderKey) + (order.getPrice() * order.getAmount());
			totalPriceMap.put(orderKey, totalPrice);
			
		}
		
		
		//orderList.forEach(order -> log.info(order));
		model.addAttribute("orderMap",orderMap);
		model.addAttribute("totalPriceMap", totalPriceMap);
		//model.addAttribute("orderList",orderList);
		return "order/orderList";
	}
	
	//주문 내역 준비
	@PostMapping("/prepareOrder")
	public @ResponseBody PurchaseDTO prepareOrder(HttpSession session, @RequestBody List<OrderListVO> orderList){

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    String userId = auth.getName();
	    
		//name, phone, addr1, addr2, memo, item_no, amount
	    
	    //주문번호에 들어갈 날짜 정보
		Date now = new Date();
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
	    String orderNoDate = dateFormat.format(now);
	    int totalPrice = 0;
			
	    for(OrderListVO order : orderList) {
			order.setMem_id(userId);
			
			order.setOrd_no(userId + "_" + orderNoDate);
			
			ItemVO currentItem = itemService.get(order.getItem_no());
			
			order.setItem_name(currentItem.getItem_name());
			order.setPrice(currentItem.getPrice());
			
			log.info(order);
			log.info("가격========================"+currentItem.getPrice());
			totalPrice += order.getAmount() * order.getPrice();
		}
	    
	    log.info(totalPrice);
				
	    PurchaseDTO dto = new PurchaseDTO();
	    dto.setName(orderList.get(0).getName());
	    dto.setOrd_no(orderList.get(0).getOrd_no());
	    dto.setTotalPrice(totalPrice);
	    dto.setOrderList(orderList);
	    
	    //하나만 주문 시 그 상품명만 출력,
	    //여러 상품 출력시 대표 상품 이름만 출력
	    dto.setOrderName(orderList.size() > 1 ? (orderList.get(0).getItem_name() + "외 " + (orderList.size()-1) +"건"):
	    	orderList.get(0).getItem_name()
    	);
	    session.removeAttribute("paymentData");
	    //세션에 구매할 내역 일단 저장
	    session.setAttribute("paymentData", dto);
    	return dto;
	}
	
	//실제로 주문 내역에 추가
	@PostMapping("/addOrder")
	public @ResponseBody ResponseEntity<String> addOrder(@RequestBody PurchaseDTO purchaseDTO){
		
	  Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    String userId = auth.getName();
    
		int insertCount = 0;
		//int totalPrice = 0;
		
		List<OrderListVO> orderList = purchaseDTO.getOrderList();
		log.info(orderList);
		
	    for(OrderListVO order : orderList) {
	    	
			//order.setMem_id(userId);
			//order.setOrd_no(userId + "_" + orderNoDate);
			
			//ItemVO currentItem = itemService.get(order.getItem_no());
			
			//order.setItem_name(currentItem.getItem_name());
			//order.setPrice(currentItem.getPrice());
			
			log.info(order);
			if(orderService.addOrder(order) == 1)insertCount++;
			//이 경로로 왔다는 것은 결제 처리가 정상적으로 되었다는 뜻이므로 removeCart로 삭제
			cartService.removeCart(order.getCart_no());
		}
	    
	    //log.info(totalPrice);
	    	
		return insertCount == orderList.size()
		        ? new ResponseEntity<>("success", HttpStatus.OK)
		        : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
			
	}
	/*
	//장바구니, 바로구매페이지에서 Bill테이블에 데이터 추가(비동기로)
	@PostMapping("/addBill")
	public @ResponseBody String addBill(@RequestBody List<CartVO> cartList) {
		log.info(cartList);
		cartList.forEach(cart -> {
			BillVO bill = new BillVO();
			bill.setAmount(cart.getQuantity());
			bill.setItem_no(cart.getItem_no());
			if(cart.getCart_no()>1) bill.setCart_no(cart.getCart_no());
			bill.setMem_id(cart.getMember_id());
			
			orderService.addBill(bill);
		});
		return "success";
	}
*/
	

}