<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Cart Page</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css">
</head>
<body>
	<!-- 로고 -->
	<a href="${pageContext.request.contextPath}/home">
	    <img src="${pageContext.request.contextPath}/resources/images/캠핑가로고1.png" alt="Logo">
	</a>
	<h1>cart</h1>
	
	<form action="/cart" method="post">
		<table>
			<thead>
				<tr>
					<th>상품 이미지</th>
					<th>상품명</th>
					<th>가격</th>
					<th>수량</th>
					<th>삭제</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="" var="cartItem" >			
						<td><img src="" alt="상품이미지"></td>
						<td><%-- ${ } cart리스트에서.상품명--%></td>
						<td><%-- ${ } cart리스트에서.가격 --%></td>
						<td>
							
							<input type="number" name="quantity" value="1" min="1" max="100"/>
						</td>
						<td>
							<!-- onclick="deleteCartItem(${item.cartNo})" style="cursor:pointer;스크립트삭제가능참고 -->
							<img src="${pageContext.request.contextPath}/resources/static/images/delete-icon.png" alt="삭제" style="width: 20px; height: 20px; cursor:pointer;"/>
						</td>
				</c:forEach>
			</tbody>
		</table>
	</form>
</body>
</html>