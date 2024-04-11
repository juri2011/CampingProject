<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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

<!-- 메인 3 개 출력 -->
<style>
    .container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 20px;
        display: flex;
        flex-wrap: wrap;
        gap: 20px; /* 요소 사이의 간격 설정 */
    }
    .card {
        background-color: #fff;
        border-radius: 5px;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        padding: 20px;
        width: 320px;
        margin-bottom: 20px;
        cursor: pointer;
    }
    .card img {
        max-width: 100%;
        height: auto;
    }
    .card-title {
        font-size: 18px;
        font-weight: bold;
        margin: 10px 0;
    }
    .card-price {
        font-size: 16px;
        color: #888;
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
					<li><a href="/member/memberPage">마이페이지</a></li>
					<li><a href="/member/toCartList">장바구니</a></li>
				</c:if>
			</ul>
		</div>
	
	<!-- 최신 3개 -->
	<hr />
	<h2>최신 상품</h2>
	<div class="container">
		<c:forEach var="item" items="${newItem}">
			<div class="card" data-no="<c:out value='${item.item_no}' />">
		         <a class="item-img" href="<c:out value='${item.item_no}'/>">
	          	 <img src="/resources/img/${item.img_name}"/>
	          	 </a>
		        <div class="card-details">
		            <div class="card-title"><c:out value="${item.item_name}" /></div>
		            <div class="card-price">가격: <fmt:formatNumber value="${item.price}" pattern="#,###원" /></div>
		        </div>
		    </div>
		</c:forEach>
	</div>
	
	</div>
	<script>
		/* 상품 목록 클릭하면 상세페이지로 이동 */
		$(document).ready(function(){
			$('.card').click(function(){
				const item_no = $(this).data("no");
				location.href="/item/detail?item_no="+item_no;
			});
			
			
			$(".item-img").on('click',function(e){
				e.preventDefault();
				self.location = "/item/detail?item_no=" + $(this).attr('href');
			});
		});
		
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