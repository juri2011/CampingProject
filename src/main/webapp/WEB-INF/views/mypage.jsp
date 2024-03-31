<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>MyPage</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css">

</head>
<body>

	<!-- 로고 -->
	<a href="${pageContext.request.contextPath}/home">
	    <img src="${pageContext.request.contextPath}/resources/images/캠핑가로고1.png" alt="Logo">
	</a>

	<h1>My Page</h1>

	<div class="mypage-conteiner">
		<!-- 장바구니 -->
		<div class="flex-item">
			<a href="${pageContext.request.contextPath}/cart">
				<img src="${pageContext.request.contextPath}/resources/images/cart-icon.png" alt="장바구니" />
			</a>
			<p><a href="${pageContext.request.contextPath}/cart">장바구니</a></p>
		</div>

		<div class="flex-item">
			<a href="${pageContext.request.contextPath}/order">
				<img src="${pageContext.request.contextPath}/resources/images/Payment-details-icon.png" alt="결재내역" />
			</a>
			<p><a href="${pageContext.request.contextPath}/order">결재내역</a></p>
		</div>

		<div class="flex-item">
			<a href="${pageContext.request.contextPath}/editmember">
				<img src="${pageContext.request.contextPath}/resources/images/correction-icon.png" alt="회원정보수정" />
			</a>
			<p><a href="${pageContext.request.contextPath}/editmember">회원정보수정</a></p>
		</div>

	</div>
</body>
</html>