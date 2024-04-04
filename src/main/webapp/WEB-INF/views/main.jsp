<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome Campingga</title>

</head>
<style>
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
	bottom:60%;
	
}
</style>
<body>

	<div class="wrapper">
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
					<li><a href="/admin/main">관리자 페이지(수정 예정)</a></li>
					<li><a class="logout" href="/member/logout.do">로그아웃</a></li>
					<li>마이페이지</li>
					<li>장바구니</li>
				</c:if>
			</ul>
		</div>
	</div>
<script>
    const logoutLink = document.querySelector(".logout");

    logoutLink.addEventListener("click", function(event) {
        event.preventDefault(); // 링크의 기본 동작을 중단합니다.
        alert("로그 아웃 되었습니다.");
    });
</script>
</body>
</html>