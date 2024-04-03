<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Cart Page</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
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
				<c:forEach var="cart" items="${cartItemList}">	
					<tr class="cartItem" data-no="<c:out value='${cart.cart_no}'/>">
						<td><img src="" alt="상품이미지"></td>
						<td><c:out value='${cart.item_name}'/></td>
						<td><c:out value='${cart.price}'/></td>
						<td>
							<input type="number" name="quantity" value="<c:out value='${cart.quantity}'/>" min="1" max="100"/>
						</td>
						<td>
							<!-- onclick="deleteCartItem(${item.cartNo})" style="cursor:pointer;스크립트삭제가능참고 -->
							<button class="cart-delete">삭제</button>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<button>구매</button>
		<button>전체 삭제</button>
	</form>
</body>
<script src="/resources/js/cart.js"></script>
<script>
	$(document).ready(function(){
		$('.cart-delete').on('click', function(e){
			e.preventDefault();
			const cart_no = $(this).parent().parent().data('no')
			console.log(cart_no);
			cartService.remove(cart_no, function(result){
				alert(result);
			});
		});
	});
</script>
</html>