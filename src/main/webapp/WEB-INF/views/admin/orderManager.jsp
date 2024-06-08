<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>주문 관리</title>
  <style>
    body {
      font-family: sans-serif;
      margin: 0;
      padding: 0;
    }

    .container {
      width: 100%;
      max-width: 1200px;
      margin: 0 auto;
    }

    .table-wrapper {
      margin-top: 20px;
      border: 1px solid #ddd;
    }

    .table {
      width: 100%;
      border-collapse: collapse;
    }

    th, td {
      padding: 10px;
      border: 1px solid #ddd;
    }

    th {
      text-align: center;
    }
    
    img {
    	width: 200px;
    	height: 200px;
    }
    
    .item-name {
    	width: 350px;
    	text-align: center;
    }

    .order-date {
      text-align: right;
    }

    .status {
      text-align: center;
    }

    .product-name {
      text-align: left;
    }

    .price {
      text-align: right;
    }

    .shipping {
      text-align: center;
    }

    .total-price {
      font-weight: bold;
      text-align: right;
    }
  </style>
</head>
<body>
  <div class="common-container">
    <h2>주문관리 페이지</h2>
    <c:forEach items="${orderMap}" var="entry">
    <div class="table-wrapper">
      <table class="table">
        <thead>
          <tr>
          	<th>상품이미지</th>
            <th>주문번호</th>
            <th>상품명</th>
            <th>주문일</th>
            <th>수량</th>
            <th>가격</th>
            <th>배송 상태</th>
            <th>주문확정하기</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach items="${entry.value}" var="order">
            <tr>
              <td><img src="/resources/img/${order.fileName}" alt="상품이미지" /></td>
              <td>${order.ord_no}</td>
              <td class="item-name">${order.item_name}</td>
              <td class="order-date"><fmt:formatDate value="${order.regdate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
              <td>${order.amount}</td>
              <td class="price"><fmt:formatNumber value="${order.price}" pattern="#,###원" /></td>
              <td class="shipping">
                <c:choose>
                  <c:when test="${order.status == 1}">
                    결제완료
                  </c:when>
                  <c:when test="${order.status == 2}">
                    배송준비
                  </c:when>
                  <c:when test="${order.status == 3}">
                    배송중
                  </c:when>
                  <c:when test="${order.status == 4}">
                    배송완료
                  </c:when>
                </c:choose>
              </td>
              <td>
                <form action="/admin/updateOrderStatus" method="post">
                  <input type="hidden" name="ord_no" value="${order.ord_no}" />
                  <input type="hidden" name="cart_no" value="${order.cart_no}" />
                  <select name="status">
                    <option value="1" <c:if test="${order.status == 1}">selected</c:if>>결제완료</option>
                    <option value="2" <c:if test="${order.status == 2}">selected</c:if>>배송준비</option>
                    <option value="3" <c:if test="${order.status == 3}">selected</c:if>>배송중</option>
                    <option value="4" <c:if test="${order.status == 4}">selected</c:if>>배송완료</option>
                  </select>
                  <input type="submit" value="변경" />
                  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                </form>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>
    </c:forEach>
  </div>
</body>
</html>
