<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>결제 내역</title>
  <style>
    body {
      font-family: sans-serif;
      margin: 0;
      padding: 0;
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
    
    .order-date {
      text-align: right;
    }

    .status {
      text-align: center;
    }


    .price {
      text-align: center;
    }

    .shipping {
      text-align: center;
    }

    .total-price {
      font-weight: bold;
      text-align: right;
    }
    
    .product-name>a{
    	color:blue;
    	text-decoration:underline;
    }
  </style>
</head>
<body>
<div id="wrapper">
	<div class="common-container">
    <h2>결제 내역</h2>
    <c:forEach items="${orderMap}" var="entry">
    <div class="table-wrapper">
    <h3>주문번호 : <c:out value="${entry.value[0].ord_no}" /></h3>
      <table class="table">
        <thead>
          <tr>
          	<th>이미지</th>
            <th>주문일</th>
            <th>상품명</th>
            <th>수량</th>
            <th>가격</th>
            <th>배송 상태</th>
          </tr>
        </thead>
        <tbody>
	        <c:forEach items="${entry.value}" var="order">
	            <tr>
		        	<td><img src="/resources/img/${order.fileName}" alt="상품이미지" /></td>
		        	<td class="order-date"><fmt:formatDate value="${order.regdate}" pattern="yyyy-MM-dd hh:mm:ss" /></td>
		        	<td class="product-name"><a href="/item/detail?item_no=${order.item_no}"><c:out value="${order.item_name}" /></a></td>
		        	<td><c:out value="${order.amount}"/></td>
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
	          	</tr>
	        </c:forEach>
	          	<tr>
	            	<td colspan="6" class="total-price">총 결제 금액: <fmt:formatNumber value="${totalPriceMap[entry.key]}" pattern="#,###원" /></td>
	            </tr>
        </tbody>
        <tfoot>
          
        </tfoot>
      </table>
    </div>
   </c:forEach>
  </div>
</div>
  
</body>
</html>