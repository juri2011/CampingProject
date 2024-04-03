<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
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
            </tr>
            <c:forEach var="cart" items="${cartList}">
            	<tr>
            	<td><img src="product.jpg" alt="<c:out value='${cart.item_name}'/>"></td>
                <td><c:out value='${cart.item_name}'/></td>
                <td><c:out value='${cart.quantity}'/></td>
                <td><fmt:formatNumber value="${cart.price}" pattern="#,###원" /></td>
            </tr>
            </c:forEach>
            
        </table>
    </div>
    <h2>배송 정보</h2>
    <div class="shipping-details">
        <input type="text" placeholder="받으실 분">
        <input type="tel" placeholder="전화번호">
        <input type="text" placeholder="주소">
        <textarea placeholder="배송 메시지"></textarea>
    </div>
    <div class="btn-container">
        <button class="btn">결제</button>
        <button class="btn">다시 입력</button>
        <button class="btn">결제취소</button>
    </div>
</div>
</body>
<script>
</script>
</html>