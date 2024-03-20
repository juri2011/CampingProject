<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="org.springframework.security.core.Authentication" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.userdetails.UserDetails" %>
<%@ page import="org.springframework.security.core.GrantedAuthority" %>
<%@ page import="java.util.*" %>

<!--===============================================================================================-->	
	<link rel="icon" type="image/png" href="../resources/images/icons/favicon.png"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="../resources/vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="../resources/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="../resources/fonts/iconic/css/material-design-iconic-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="../resources/fonts/linearicons-v1.0.0/icon-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="../resources/vendor/animate/animate.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="../resources/vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="../resources/vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="../resources/vendor/select2/select2.min.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="../resources/vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="../resources/vendor/slick/slick.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="../resources/vendor/MagnificPopup/magnific-popup.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="../resources/vendor/perfect-scrollbar/perfect-scrollbar.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="../resources/css/util.css">
	<link rel="stylesheet" type="text/css" href="../resources/css/main.css">
<!--===============================================================================================-->


<style>
.logoutbtn{
	margin: 0px 0px 0px 10px;
	height: 100%;
	color: #fff; /* 글자 색상을 설정합니다. */
    background-color: transparent; /* 배경을 투명하게 만듭니다. */
    border: none; /* 테두리를 제거합니다. */
    font-size: 11px;
}
</style>
<!-- Header -->
	<header class="header-v4">
<%
	Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	String id = auth.getName();
	request.setAttribute("userId", id);
	
	boolean hasRole = auth.getAuthorities().stream()
            .map(GrantedAuthority::getAuthority)
            .anyMatch(role -> role.equals("ROLE_MANAGER"));
	
	if(hasRole){
		request.setAttribute("role", "ROLE_MANAGER");
	}
%>




		<!-- Header desktop -->
		<div class="container-menu-desktop">
			<!-- Topbar -->
			<div class="top-bar">
				<div class="content-topbar flex-sb-m h-full container">
					<div class="left-top-bar">
						<p>나비, 피부에 다가오다</p>
					</div>

					<div class="right-top-bar flex-w h-full">
						<a href="#" class="flex-c-m trans-04 p-lr-25">
							Help & FAQs
						</a>
						<c:choose>
							<c:when test='${role != "ROLE_MANAGER" }'>
							</c:when>
							<c:when test='${role == "ROLE_MANAGER" }'>
								<a href="/admin/claims" class="flex-c-m trans-04 p-lr-25">
									고객관리
								</a>
							</c:when>
						</c:choose>
						<c:if test='${userId != "anonymousUser" }'>
							<a href="/order/list.do" class="flex-c-m trans-04 p-lr-25">
								주문내역
							</a>
						</c:if>
						<c:choose>
							<c:when test='${userId == "anonymousUser" }'>
								<a href="/member/login" class="flex-c-m p-lr-10 trans-04">
									로그인
								</a>
							</c:when>
							<c:when test='${userId != "anonymousUser" }'>
								<form action="/logout.do" method='post'>
									<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" >
									<button class="logoutbtn">로그아웃</button>
								</form>
							</c:when>
						</c:choose>
					</div>
				</div>
			</div>

			<div class="wrap-menu-desktop how-shadow1">
				<nav class="limiter-menu-desktop container">
					
					<!-- Logo desktop -->		
					<a href="/home" class="logo">
						<img src="../resources/images/icons/logo-01.png" alt="IMG-LOGO">
					</a>

					<!-- Menu desktop -->
					<div class="menu-desktop">
						<ul class="main-menu">
						<!--  	<li class="active-menu">
								<a href="/home?menu=1">Home</a>
 								<ul class="sub-menu">
									<li><a href="/home">Homepage 1</a></li>
									<li><a href="/home2">Homepage 2</a></li>
									<li><a href="/home3">Homepage 3</a></li>
								</ul>
							</li>

							<li>
								<a href="/showlist">Shop</a>
							</li>

							<li class="label1" data-label1="hot">
								<a href="/cart/view">Features</a>
							</li>

							<li>
								<a href="/blogs">Blog</a>
							</li>

							<li>
								<a href="/about">About</a>
							</li>

							<li>
								<a href="/contact">Contact</a>
							</li>-->
							<tiles:importAttribute name="menuList" />
							<c:forEach var="menu"  items="${menuList}"> 
								<c:choose>
									<c:when test="${menu.check1 == 1 }">
										<li class="active-menu">
											<a href="${menu.menuUrl}?menu=${menu.menuCd}">${menu.menuName}</a>
										</li>
									</c:when>
									<c:otherwise>
										<li>
											<a href="${menu.menuUrl}?menu=${menu.menuCd}">${menu.menuName}</a>
										</li>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</ul>
					</div>	

					<!-- Icon header -->
					<div class="wrap-icon-header flex-w flex-r-m">
						<div class="icon-header-item cl2 hov-cl1 trans-04 p-l-22 p-r-11 js-show-modal-search">
							<i class="zmdi zmdi-search"></i>
						</div>

						<tiles:importAttribute name="cartCount" />
						<a href="/cart/view">
							<div id="cartCount" class="icon-header-item cl2 hov-cl1 trans-04 p-l-22 p-r-11 icon-header-noti js-show-cart" data-notify="${cartCount}">
								<i class="zmdi zmdi-shopping-cart"></i>
							</div>
						</a>
						<tiles:importAttribute name="wishCount" />
						<a href="#" class="icon-header-item cl2 hov-cl1 trans-04 p-l-22 p-r-11 icon-header-noti" data-notify="${wishCount}">
							<i class="zmdi zmdi-favorite-outline"></i>
						</a>
					</div>
				</nav>
			</div>	
		</div>

		<!-- Header Mobile -->
		<div class="wrap-header-mobile">
			<!-- Logo moblie -->		
			<div class="logo-mobile">
				<a href="/home"><img src="../resources/images/icons/logo-01.png" alt="IMG-LOGO"></a>
			</div>

			<!-- Icon header -->
			<div class="wrap-icon-header flex-w flex-r-m m-r-15">
				<div class="icon-header-item cl2 hov-cl1 trans-04 p-r-11 js-show-modal-search">
					<i class="zmdi zmdi-search"></i>
				</div>

				<div class="icon-header-item cl2 hov-cl1 trans-04 p-r-11 p-l-10 icon-header-noti js-show-cart" data-notify="2">
					<i class="zmdi zmdi-shopping-cart"></i>
				</div>

				<a href="#" class="dis-block icon-header-item cl2 hov-cl1 trans-04 p-r-11 p-l-10 icon-header-noti" data-notify="0">
					<i class="zmdi zmdi-favorite-outline"></i>
				</a>
			</div>

			<!-- Button show menu -->
			<div class="btn-show-menu-mobile hamburger hamburger--squeeze">
				<span class="hamburger-box">
					<span class="hamburger-inner"></span>
				</span>
			</div>
		</div>


		<!-- Menu Mobile -->
		<div class="menu-mobile">
			<ul class="topbar-mobile">
				<li>
					<div class="left-top-bar">
						<p>나비, 피부에 다가오다</p>
					</div>
				</li>

				<li>
					<div class="right-top-bar flex-w h-full">
						<a href="#" class="flex-c-m p-lr-10 trans-04">
							Help & FAQs
						</a>
						<c:choose>
							<c:when test='${userId == "anonymousUser" }'>
								<a href="/member/login" class="flex-c-m p-lr-10 trans-04">
									로그인
								</a>
							</c:when>
							<c:when test='${userId != "anonymousUser" }'>
								<form action="/logout.do" method='post'>
									<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" >
									<button class="logoutbtn">로그아웃</button>
								</form>
							</c:when>
						</c:choose>
					</div>
				</li>
			</ul>

			<ul class="main-menu-m">
				<li>
					<a href="/home">Home</a>
					<ul class="sub-menu-m">
						<li><a href="/home">Homepage 1</a></li>
						<li><a href="/home2">Homepage 2</a></li>
						<li><a href="/home3">Homepage 3</a></li>
					</ul>
					<span class="arrow-main-menu-m">
						<i class="fa fa-angle-right" aria-hidden="true"></i>
					</span>
				</li>

				<li>
					<a href="/showlist">Shop</a>
				</li>

				<li>
					<a href="/cart/view" class="label1 rs1" data-label1="hot">Features</a>
				</li>

				<li>
					<a href="/blogs">Blog</a>
				</li>

				<li>
					<a href="/about">About</a>
				</li>

				<li>
					<a href="/contact">Contact</a>
				</li>
			</ul>
		</div>

		<!-- Modal Search -->
		<div class="modal-search-header flex-c-m trans-04 js-hide-modal-search">
			<div class="container-search-header">
				<button class="flex-c-m btn-hide-modal-search trans-04 js-hide-modal-search">
					<img src="../resources/images/icons/icon-close2.png" alt="CLOSE">
				</button>

				<form action="/goods/search.do"  class="wrap-search-header flex-w p-l-15">
					<button class="flex-c-m trans-04">
						<i class="zmdi zmdi-search"></i>
					</button>
					<input class="plh3" type="text" name="searchText" placeholder="Search...">
					<input type="hidden" name="searchId" value="pname">
					
				</form>
			</div>
		</div>
	</header>

	<!-- Cart -->
	<div class="wrap-header-cart js-panel-cart">
		<div class="s-full js-hide-cart"></div>

		<div class="header-cart flex-col-l p-l-65 p-r-25">
			<div class="header-cart-title flex-w flex-sb-m p-b-8">
				<span class="mtext-103 cl2">
					Your Cart
				</span>

				<div class="fs-35 lh-10 cl2 p-lr-5 pointer hov-cl1 trans-04 js-hide-cart">
					<i class="zmdi zmdi-close"></i>
				</div>
			</div>
			
			<div class="header-cart-content flex-w js-pscroll">
				<ul class="header-cart-wrapitem w-full">
					<li class="header-cart-item flex-w flex-t m-b-12">
						<div class="header-cart-item-img">
							<img src="../resources/images/item-cart-01.jpg" alt="IMG">
						</div>

						<div class="header-cart-item-txt p-t-8">
							<a href="#" class="header-cart-item-name m-b-18 hov-cl1 trans-04">
								White Shirt Pleat
							</a>

							<span class="header-cart-item-info">
								1 x $19.00
							</span>
						</div>
					</li>

					<li class="header-cart-item flex-w flex-t m-b-12">
						<div class="header-cart-item-img">
							<img src="../resources/images/item-cart-02.jpg" alt="IMG">
						</div>

						<div class="header-cart-item-txt p-t-8">
							<a href="#" class="header-cart-item-name m-b-18 hov-cl1 trans-04">
								Converse All Star
							</a>

							<span class="header-cart-item-info">
								1 x $39.00
							</span>
						</div>
					</li>

					<li class="header-cart-item flex-w flex-t m-b-12">
						<div class="header-cart-item-img">
							<img src="../resources/images/item-cart-03.jpg" alt="IMG">
						</div>

						<div class="header-cart-item-txt p-t-8">
							<a href="#" class="header-cart-item-name m-b-18 hov-cl1 trans-04">
								Nixon Porter Leather
							</a>

							<span class="header-cart-item-info">
								1 x $17.00
							</span>
						</div>
					</li>
				</ul>
				
				<div class="w-full">
					<div class="header-cart-total w-full p-tb-40">
						Total: $75.00
					</div>

					<div class="header-cart-buttons flex-w w-full">
						<a href="/cart/view" class="flex-c-m stext-101 cl0 size-107 bg3 bor2 hov-btn3 p-lr-15 trans-04 m-r-8 m-b-10">
							View Cart
						</a>

						<a href="shoping-cart.html" class="flex-c-m stext-101 cl0 size-107 bg3 bor2 hov-btn3 p-lr-15 trans-04 m-b-10">
							Check Out
						</a>
					</div>
				</div>
			</div>
		</div>
	</div>