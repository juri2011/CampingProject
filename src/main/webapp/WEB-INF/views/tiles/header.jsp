<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
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
            <div class="top_gnb_area">
                <ul class="list">
                    <!-- 비로그인 상태 -->
                    <c:if test="${sessionScope.memberInfo.mem_id == null}">
                        <li><a href="/member/login">로그인</a></li>
                        <li><a href="/member/join">회원가입</a></li>
                        <li>고객센터</li>
                    </c:if>

                    <!-- 로그인한 상태 -->
                    <c:if test="${ sessionScope.memberInfo.mem_id != null }">
                        <div class="login_success_area">
                            <span>${sessionScope.memberInfo.mem_id}님, 환영합니다.</span>
                        </div>
                        <c:choose>
                            <c:when test="${sessionScope.memberInfo.isAdmin}">
                                <li><a href="/admin/adminPage">관리자 페이지</a></li>
                            </c:when>
                            <c:otherwise>
                                <li><a href="/member/memberPage">마이페이지</a></li>
                            </c:otherwise>
                        </c:choose>
                        <li><a id="gnb_logout_button">로그아웃</a></li>
                        <li><a href="/member/toCartList">장바구니</a></li>
                    </c:if>
                </ul>
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
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");

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
    
	/* gnb_area 로그아웃 버튼 작동 */
	$("#gnb_logout_button").click(function() {
		//alert("버튼 작동");
		$.ajax({
			type : "POST",
			url : "/member/logout.do",
			
			/* 
				spring security에서 CSRF보호를 활성화하면
				POST 요청을 보낼때 CSRF 토큰이 올바른지 검증한다
			*/
			beforeSend: function(xhr) {
	            xhr.setRequestHeader(header, token);
	        },
			success : function(data) {
				alert("로그아웃 성공");
				//document.location.reload();
				location.href="/";
			}
		}); // ajax 
	});
</script>