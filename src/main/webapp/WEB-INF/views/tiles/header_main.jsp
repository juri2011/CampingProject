<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<meta name="viewport" content="width=device-width, initial-scale=1" />
<meta name="author" content="Untree.co" />

    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700&display=swap"
      rel="stylesheet"
    />

    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/fonts/icomoon/style.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/fonts/flaticon/font/flaticon.css" />

    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/tiny-slider.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/aos.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/style.css" />

<style>
	#wrapper{
		margin-top: 150px;
	}
	.span-welcome{
		color: white;
	}
</style>

<div class="header-template">
	<div class="hero">
      <div class="hero-slide">
        <div
          class="img overlay"
          style="background-image: url('${pageContext.request.contextPath}/resources/images/hero_bg_3.jpg')"
        ></div>
        <div
          class="img overlay"
          style="background-image: url('${pageContext.request.contextPath}/resources/images/hero_bg_2.jpg')"
        ></div>
        <div
          class="img overlay"
          style="background-image: url('${pageContext.request.contextPath}/resources/images/hero_bg_1.jpg')"
        ></div>
      </div>

      <div class="container">
        <div class="row justify-content-center align-items-center">
          <div class="col-lg-9 text-center">
            <h1 class="heading" data-aos="fade-up">
              Easiest way to find your dream home
            </h1>
            <form
              action="/item/list"
              method="get"
              class="narrow-w form-search d-flex align-items-stretch mb-3"
              data-aos="fade-up"
              data-aos-delay="200"
            >
              <input
                type="text"
                class="form-control px-4"
                name="keyword" placeholder="검색..."
              />
              <button type="submit" class="btn btn-primary">Search</button>
            </form>
          </div>
        </div>
      </div>
    </div>
	
	<div class="site-mobile-menu site-navbar-target">
      <div class="site-mobile-menu-header">
        <div class="site-mobile-menu-close">
          <span class="icofont-close js-menu-toggle"></span>
        </div>
      </div>
      <div class="site-mobile-menu-body"></div>
    </div>

    <nav class="site-nav">
      <div class="container">
        <div class="menu-bg-wrap">
          <div class="site-navigation">
            <a href="/" class="logo m-0 float-start">CampingGa</a>

            <ul
              class="js-clone-nav d-none d-lg-inline-block text-start site-menu float-end"
            >
              <!-- 비로그인 상태 -->
              <c:if test="${sessionScope.memberInfo.mem_id == null}">
                  <li><a href="/member/login">로그인</a></li>
                  <li><a href="/member/join">회원가입</a></li>
              </c:if>

              <!-- 로그인한 상태 -->
              <c:if test="${ sessionScope.memberInfo.mem_id != null }">
                  <li class="login_success_area">
                      <span class="span-welcome">${sessionScope.memberInfo.mem_id}님, 환영합니다.</span>
                  </li>
                  <c:choose>
                      <c:when test="${sessionScope.memberInfo.isAdmin}">
                          <li><a href="/admin/adminPage">관리자 페이지</a></li>
                      </c:when>
                      <c:otherwise>
                          <li><a href="/member/memberPage">마이페이지</a></li>
                      </c:otherwise>
                  </c:choose>
                  <li><a href="/main" id="gnb_logout_button">로그아웃</a></li>
                  <li><a href="/member/toCartList">장바구니</a></li>
              </c:if>
              
              
              <li class="has-children">
                <a href="#">아늑함</a>
                <ul class="dropdown">
                    <!-- 삼품리스트 내에서 변경될시 아래 경로 코드는 의미 없을 듯. -->
                    <li><a href="/item/list?category=텐트">텐트</a></li>
                    <li><a href="/item/list?category=침낭">침낭</a></li>
                    <li><a href="/item/list?category=매트">매트</a></li>
                    <li><a href="/item/list?category=난로">난로</a></li>
                </ul>
              </li> 
          
            <!-- 편리함 카테고리 -->
              <li class="has-children">
                <a href="#">편리함</a>
                <ul class="dropdown">
                    <li><a href="/item/list?category=캠핑가구">캠핑가구</a></li>
                    <li><a href="/item/list?category=조리도구">조리도구</a></li>
                    <li><a href="/item/list?category=랜턴">조명/랜턴</a></li>
                    <li><a href="/item/list?category=전자제품">전자기기</a></li>
                </ul>
              </li> 
              
            </ul>

            <a
              href="#"
              class="burger light me-auto float-end mt-1 site-menu-toggle js-menu-toggle d-inline-block d-lg-none"
              data-toggle="collapse"
              data-target="#main-navbar"
            >
              <span></span>
            </a>
          </div>
        </div>
      </div>
    </nav>
</div>

<script src="<c:url value = "/resources/js/bootstrap.bundle.min.js" />"></script>
<script src="<c:url value = "/resources/js/tiny-slider.js"/>"></script>
<script src="<c:url value = "/resources/js/aos.js"/>"></script>
<script src="<c:url value = "/resources/js/navbar.js"/>"></script>
<script src="<c:url value = "/resources/js/counter.js"/>"></script>
<script src="<c:url value = "/resources/js/custom.js"/>"></script>
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
	$(".site-menu").on('click','#gnb_logout_button',function(e) {
		e.preventDefault();
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