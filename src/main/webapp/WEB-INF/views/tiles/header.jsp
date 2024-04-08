<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    <div class="header">
    	<!-- 상단: 로고, 로그인/회원가입, 마이페이지/장바구니 -->
    	<div class="header-top">    	
		    <!-- 로고 -->
		    <div class="logo-container">
		        <!-- 로고 이미지를 클릭하면 /home으로 이동하도록 설정 -->
		        <a href="/main"><img src="${pageContext.request.contextPath}/resources/images/캠핑가로고1.png" alt="Logo"></a>
		    </div>
		    
		    <!-- 로그인,회원가입 및 마이페이지,장바구니 아이콘 영역 -->
	        <div class="auth-links">
		        <!-- 로그인, 회원가입 링크 그룹 -->
		        <div class="auth-group">
		            <a href="/member/login">로그인</a> | 
		            <a href="/member/join">회원가입</a>
		        </div>
		
		        <!-- 마이페이지와 장바구니 아이콘 그룹 -->
		        <div class="icon-group">
		            <a href="${pageContext.request.contextPath}/mypage"><img src="${pageContext.request.contextPath}/resources/images/mypage-icon.png" alt="마이페이지"></a>
		            <a href="/cart/list"><img src="${pageContext.request.contextPath}/resources/images/cart-icon.png" alt="장바구니"></a>
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
			            <a href="/item/list?category=텐트">텐트</a>
			            <a href="/item/list?category=침낭">침낭</a>
			            <a href="/item/list?category=매트">매트</a>
			            <a href="/item/list?category=난로">난로</a>
			        </div>
			    </div> 
			  
			    <!-- 편리함 카테고리 -->
			    <div class="dropdown">
			        <a href="#">편리함</a>
			        <div class="dropdown-content">
			            <a href="/item/list?category=침낭">캠핑가구</a>
			            <a href="/item/list?category=조리도구">조리도구</a>
			            <a href="/item/list?category=랜턴">조명/랜턴</a>
			            <a href="/item/list?category=전자제품">전자기기</a>
			        </div>
			    </div> 
	            <a href="${pageContext.request.contextPath}/campsite">캠핑장 조회</a>
	        </div>
	
	        <!-- 검색 메뉴(임의!) -->
	        <div class="search-menu">
	            <form action="/item/list" method="get">
	                <input type="text" name="keyword" placeholder="검색...">
	                <button type="submit">검색</button>
	            </form>
	        </div>        
        </div>
    </div>

<script>
	console.log("hi")
	$('.dropdown>a').click(function(e){
		e.preventDefault();
		$(".dropdown-content").hide();
		$(this).parent().find('.dropdown-content').toggle();
	});
	$(document).click(function(event) {
	    if (!$(event.target).closest('.dropdown').length) {
	      $(".dropdown-content").hide();
	    }
	});
</script>