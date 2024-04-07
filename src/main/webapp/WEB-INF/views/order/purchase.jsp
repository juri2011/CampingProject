<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<!-- jQuery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<title>구매 페이지</title>
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
    }
    .container {
        max-width: 600px;
        margin: 20px auto;
        padding: 20px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }
    h2 {
        margin-top: 0;
    }
    .order-details, .shipping-details {
        margin-bottom: 20px;
    }
    .order-details img {
        max-width: 100px;
        height: auto;
    }
    .order-details table {
        width: 100%;
        border-collapse: collapse;
    }
    .order-details th, .order-details td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: left;
    }
    .shipping-details input[type="text"], .shipping-details input[type="tel"], .shipping-details textarea {
        width: 100%;
        padding: 8px;
        margin-bottom: 10px;
        border: 1px solid #ddd;
        border-radius: 5px;
    }
    .btn-container {
        text-align: center;
    }
    .btn {
        padding: 10px 20px;
        background-color: #007bff;
        color: #fff;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }
    .btn:hover {
        background-color: #0056b3;
    }
</style>
</head>
<body>
<div class="container">
    <h2>주문 확인</h2>
    <div class="order-details">
        <table>
            <tr>
            	<th>상품</th>
                <th>상품명</th>
                <th>수량</th>
                <th>가격</th>
                <th>상태</th>
            </tr>
            <c:forEach var="cart" items="${cartList}">
            	<tr>
            	<td><img src="product.jpg" alt="<c:out value='${cart.item_name}'/>"></td>
                <td>
                	<c:out value='${cart.item_name}'/>
                	<input type="hidden" name="cart_no" id="cart_no" value="${cart.cart_no}" />
                	<input type="hidden" name="item_no" id="item_no" value="${cart.item_no}" />
                </td>
                <td class="item-quantity"><c:out value='${cart.quantity}'/></td>
                <td><fmt:formatNumber value="${cart.price}" pattern="#,###원" /></td>
                <td><c:out value='${cart.status eq 1 ? "판매중" : "판매중단"}'/></td>
                
            </tr>
            </c:forEach>
            <tr>
                <td colspan="3"><b>총 상품 금액:</b></td>
                <td colspan="2"><fmt:formatNumber value="${totalPrice}" pattern="#,###원" /></td>
            </tr>
            
        </table>
    </div>
    <h2>배송 정보</h2>
    <%-- <div class="shipping-details">
        <input id="name" type="text" placeholder="받으실 분" value='<c:out value="${sessionScope.member.name}"/>'>
        <input id="phone" type="tel" placeholder="전화번호" value='<c:out value="${sessionScope.member.phone}"/>'>
        <input id="stnum" type="text" placeholder="주소" value='<c:out value="${sessionScope.member.userStnum}"/>'>
        <input id="addr1" type="text" placeholder="주소" value='<c:out value="${sessionScope.member.userAddr}"/>'>
        <input id="addr2" type="text" placeholder="상세주소" value='<c:out value="${sessionScope.member.userDaddr}"/>'>
        <textarea id="memo" placeholder="배송 메시지">파손되지 않게 조심히 배송해주세요</textarea>
    </div> --%>
    <div class="shipping-details">
        <input id="name" type="text" placeholder="받으실 분" value='<c:out value=""/>'>
        <input id="phone" type="tel" placeholder="전화번호" value='<c:out value=""/>'>
        <input id="stnum" type="text" placeholder="주소" value='<c:out value=""/>'>
        <input id="addr1" type="text" placeholder="주소" value='<c:out value=""/>'>
        <input id="addr2" type="text" placeholder="상세주소" value='<c:out value=""/>'>
        <textarea id="memo" placeholder="배송 메시지">파손되지 않게 조심히 배송해주세요</textarea>
    </div>
    <div class="btn-container">
        <button class="btn" id="purchase">결제</button>
        <button class="btn">다시 입력</button>
        <button class="btn" id="cancel">결제취소</button>
    </div>
</div>
</body>
<!-- 결제  -->
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script>
	function initPayment() {
		const IMP = window.IMP;
		IMP.init("imp65002722");
	}

	$(function () {
		initPayment();
	})

	function callPayment(data) {
		//상품명 가공

		let prdCount = 0;
		let prdName = "";

		$(".num-product").each(function () {
			prdCount += 1;
			if (prdCount == 1) {
				const input = $(this);
				prdName = input.parent().parent().siblings('.column-2').text();
			}
		});

		const paymentData = {
			pg: "kcp.A52CY",
			pay_method: "card",
			merchant_uid: data.orderNo,
			name: prdName + (prdCount > 1 ? "외 " + (prdCount - 1) + "건" : ""),
			amount: data.totalPrice
		}

		IMP.request_pay(paymentData, function (rsp) {
		});
	}
</script>
<script>
	function validate() {
		if ($("#name").val() == '') {
			alert("이름을 입력하세요.");
			return false;
		}
	
		if ($("#phone").val() == '') {
			alert("연락처를 입력하세요.");
			return false;
		}
	
		if ($("#addr1").val() == '') {
			alert("주소를 선택하세요.");
			return false;
		}
	
		if ($("#addr2").val() == '') {
			alert("상세주소를 입력하세요.");
			return false;
		}
	
		return true;
	
	}

	$(document).ready(function(){
		$('#cancel').on('click',function(){
			history.back();
		});
		
		$('#purchase').on('click', function(){
            let hasStatusTwo = false; // '2'라는 상태가 있는지 여부를 저장하는 변수 초기화
            $('.order-details tr').each(function() { // 각 행을 순회하며
                const status = $(this).find('td:last').text(); // 각 행의 마지막 td 요소에서 상태 정보를 가져옴
                if (status === '2') { // '2'라는 상태가 있으면
                    hasStatusTwo = true; // hasStatusTwo 변수를 true로 설정
                    return false; // forEach 반복문을 중단
                }
            });
            if (hasStatusTwo) { // '2'라는 상태가 하나라도 있으면
                alert('장바구니에 품절된 아이템이 있습니다. 결제를 진행할 수 없습니다.'); // alert를 띄움
            } else { // 모든 상태가 '2'가 아니면
            	if (validate() == false) {
					return;
				}
                // 결제 로직을 진행하는 코드 작성
                const list = [];
			
				$("[name=cart_no]").each(function(idx){
					const data = {
						name: $("#name").val(),
						phone: $("#phone").val(),
						stnum: $("#stnum").val(),
						userAddr: $("#addr1").val(),
						userDaddr: $("#addr2").val(),
						d_memo: $("#memo").val(),
						cart_no: Number($("[name=cart_no]:eq(" + idx + ")").val()),
						item_no: Number($("[name=item_no]:eq(" + idx + ")").val()),
						amount: Number($(".item-quantity").eq(idx).html())
					};
					console.log(data.cart);
					list.push(data);
				});
				
				$.ajax({
				    url: '/order/addOrder',
				    type: 'POST',
				    contentType: 'application/json',
				    data: JSON.stringify(list),
				    success: function(response) {
				        // 성공적으로 데이터를 전송한 후 실행할 코드
				        console.log(response);
				        alert('결제가 완료되었습니다.');
		    		    self.location='/order/orderList';
				    },
				    error: function(xhr, status, error) {
				        // 에러 처리
				        console.error(error);
				    }
				});

		        
				/*
				if(location.pathname === '/order/purchase/direct'){
					console.log('단일상품');
				} */
				
				/*
    			$.ajax({
    				type: "POST",
    				 beforeSend: function (xhr) {
    					xhr.setRequestHeader(header, token);
    				}, 
    				url:'/order/purchase',
    				data: JSON.stringify(list),
    				contentType: "application/json; charset=utf-8",
    				dataType: "json",
    				success: function (data) {
    					if (data != null) {
    						if (data.status != "SUCCESS") {
    							alert(data.message);
    						} else {
    							//주문 등록 성공 => 결제 호출
    							callPayment(data.data);
    						}
    					} else {
    						alert("접속 도중 오류가 발생했습니다.(2)");
    					}

    				},
    				error: function (data) {
    					alert("접속 도중 오류가 발생했습니다.");
    				}
    			});
                */
            }
        });
		
		
	});
</script>
</html>