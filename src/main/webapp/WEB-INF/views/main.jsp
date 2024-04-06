<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<title>Welcome Campingga</title>
</head>
<style>
header {
	text-align: center;
}
a {
	text-decoration: none;
}
/* 홈페이지 기능 네비 */
.top_gnb_area {
	width: 100%;
	height: 50px;
	background-color: #f0f01;
	position: relative;
	border: 1px solid white;
}

.top_gnb_area .list {
	position: absolute;
	top: 0px;
	right: 0;
}

.top_gnb_area .list li {
	list-style: none;
	float: left;
	padding: 13px 15px 0 10px;
	font-weight: 900;
	cursor: pointer;
}

.login_success_area span {
	position: absolute;
	right: 15%;
	bottom: 60%;
}
</style>
<body>

	<div class="wrapper">
			<header>
			<h1>캠핑용품 쇼핑몰</h1>
		</header>
		<div class="top_gnb_area">
			<ul class="list">
				<!-- 비로그인 상태 -->
				<c:if test="${member == null}">
					<li><a href="/member/login">로그인</a></li>
					<li><a href="/member/join">회원가입</a></li>
					<li>고객센터</li>
				</c:if>

				<!-- 로그인한 상태 -->
				<c:if test="${ member != null }">
					<div class="login_success_area">
						<span>${member.mem_id}님, 환영합니다.</span>
					</div>
					<li><a href="/admin/adminPage">관리자 페이지(수정 예정)</a></li>
					<li><a id="gnb_logout_button">로그아웃</a></li>
					<li>마이페이지</li>
					<li>장바구니</li>
				</c:if>
			</ul>
		</div>

	
	</div>
	<script>
		/* gnb_area 로그아웃 버튼 작동 */
		$("#gnb_logout_button").click(function() {
			//alert("버튼 작동");
			$.ajax({
				type : "POST",
				url : "/member/logout.do",
				success : function(data) {
					alert("로그아웃 성공");
					document.location.reload();
				}
			}); // ajax 
		});
	</script>
</body>
</html>