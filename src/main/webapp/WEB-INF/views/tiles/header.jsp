<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>Header</title>
<%--     <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css"> <!-- 스타일시트 연결 --> --%>
</head>
<body>
    <div class="header">
    	<!-- 상단: 로고, 로그인/회원가입, 마이페이지/장바구니 -->
    	<div class="header-top">    	
		    <!-- 로고 -->
		    <div class="logo-container">
		        <!-- 로고 이미지를 클릭하면 /home으로 이동하도록 설정 -->
		        <a href="${pageContext.request.contextPath}/home"><img src="${pageContext.request.contextPath}/resources/images/캠핑가로고1.png" alt="Logo"></a>
		    </div>
		    
		    <!-- 로그인,회원가입 및 마이페이지,장바구니 아이콘 영역 -->
	        <div class="auth-links">
		        <!-- 로그인, 회원가입 링크 그룹 -->
		        <div class="auth-group">
		            <a href="${pageContext.request.contextPath}/login">로그인</a> | 
		            <a href="${pageContext.request.contextPath}/join">회원가입</a>
		        </div>
		
		        <!-- 마이페이지와 장바구니 아이콘 그룹 -->
		        <div class="icon-group">
		            <a href="${pageContext.request.contextPath}/mypage"><img src="${pageContext.request.contextPath}/resources/images/mypage-icon.png" alt="마이페이지"></a>
		            <a href="${pageContext.request.contextPath}/cart"><img src="${pageContext.request.contextPath}/resources/images/cart-icon.png" alt="장바구니"></a>
		        </div>
	        </div>
    	</div>
        
        <!-- 하단: 카테고리 메뉴, 검색창 -->
        <div class="header-bottom">
	        <!-- 카테고리 메뉴 -->
	        <div class="category-menu">
			    <!-- 아늑함 카테고리 -->
			    <div class="dropdown">
			        <a href="#">아늑함</a>
			        <div class="dropdown-content">
			        	<!-- 삼품리스트 내에서 변경될시 아래 경로 코드는 의미 없을 듯. -->
			            <a href="${pageContext.request.contextPath}/tent">텐트</a>
			            <a href="${pageContext.request.contextPath}/sleeping-bag">침낭</a>
			            <a href="${pageContext.request.contextPath}/mat">매트</a>
			            <a href="${pageContext.request.contextPath}/stove">난로</a>
			        </div>
			    </div> 
			  
			    <!-- 편리함 카테고리 -->
			    <div class="dropdown">
			        <a href="#">편리함</a>
			        <div class="dropdown-content">
			            <a href="${pageContext.request.contextPath}/camping-furniture">캠핑가구</a>
			            <a href="${pageContext.request.contextPath}/cooking-tools">조리도구</a>
			            <a href="${pageContext.request.contextPath}/lighting-lantern">조명/랜턴</a>
			            <a href="${pageContext.request.contextPath}/electronic-devices">전자기기</a>
			        </div>
			    </div> 
	            <a href="${pageContext.request.contextPath}/campsite">캠핑장 조회</a>
	        </div>
	
	        <!-- 검색 메뉴(임의!) -->
	        <div class="search-menu">
	            <form action="${pageContext.request.contextPath}/search" method="get">
	                <input type="text" name="query" placeholder="검색...">
	                <button type="submit">검색</button>
	            </form>
	        </div>        
        </div>
    </div>
</body>
</html>
