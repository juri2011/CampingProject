<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>



<body class="animsition">

		

	<!-- Slider -->
	<section class="section-slide">
		<div class="wrap-slick1">
			<div class="slick1">
				<div class="item-slick1" style="background-image: url(../resources/images/banner_3.jpg);">
					<div class="container h-full">
						<div class="flex-col-l-m h-full p-t-100 p-b-30 respon5">
							<div class="layer-slick1 animated visible-false" data-appear="fadeInDown" data-delay="0">
								<span style="color:#ffffff;" class="ltext-101 cl2 respon2">
									Women Collection 2023
								</span>
							</div>
								
							<div class="layer-slick1 animated visible-false" data-appear="fadeInUp" data-delay="800">
								<h2 style="color:#ffffff;" class="ltext-201 cl2 p-t-19 p-b-43 respon1">
									NEW SEASON
								</h2>
							</div>
								
							<div class="layer-slick1 animated visible-false" data-appear="zoomIn" data-delay="1600">
								<a href="/showlist" class="flex-c-m stext-101 cl0 size-101 bg1 bor1 hov-btn1 p-lr-15 trans-04">
									Shop Now
								</a>
							</div>
						</div>
					</div>
				</div>

				<div class="item-slick1" style="background-image: url(../resources/images/banner_4.jpg);">
					<div class="container h-full">
						<div class="flex-col-l-m h-full p-t-100 p-b-30 respon5">
							<div class="layer-slick1 animated visible-false" data-appear="rollIn" data-delay="0">
								<span class="ltext-101 cl2 respon2">
									Men New-Season
								</span>
							</div>
								
							<div class="layer-slick1 animated visible-false" data-appear="lightSpeedIn" data-delay="800">
								<h2 class="ltext-201 cl2 p-t-19 p-b-43 respon1">
									Jackets & Coats
								</h2>
							</div>
								
							<div class="layer-slick1 animated visible-false" data-appear="slideInUp" data-delay="1600">
								<a href="/showlist" class="flex-c-m stext-101 cl0 size-101 bg1 bor1 hov-btn1 p-lr-15 trans-04">
									Shop Now
								</a>
							</div>
						</div>
					</div>
				</div>

				<div class="item-slick1" style="background-image: url(../resources/images/banner_3.jpg);">
					<div class="container h-full">
						<div class="flex-col-l-m h-full p-t-100 p-b-30 respon5">
							<div class="layer-slick1 animated visible-false" data-appear="rotateInDownLeft" data-delay="0">
								<span style="color:#ffffff;" class="ltext-101 cl2 respon2">
									Men Collection 2023
								</span>
							</div>
								
							<div class="layer-slick1 animated visible-false" data-appear="rotateInUpRight" data-delay="800">
								<h2 style="color:#ffffff;" class="ltext-201 cl2 p-t-19 p-b-43 respon1">
									New arrivals
								</h2>
							</div>
								
							<div class="layer-slick1 animated visible-false" data-appear="rotateIn" data-delay="1600">
								<a  href="/showlist.do" class="flex-c-m stext-101 cl0 size-101 bg1 bor1 hov-btn1 p-lr-15 trans-04">
									Shop Now
								</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	
				
	
	
	<!-- Product -->
	<section class="bg0 p-t-23 p-b-140">
		<div class="container">
			<div class="p-b-10">
				<h3 class="ltext-103 cl5">
					Product Overview
				</h3>
			</div>

			<div class="flex-w flex-sb-m p-b-52">
				<div class="flex-w flex-l-m filter-tope-group m-tb-10">
					<button class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5 how-active1" data-filter="*">
						All Products
					</button>

					<button class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5" data-filter=".skincare">
						skincare
					</button>

					<button class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5" data-filter=".base">
						base
					</button>

					<button class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5" data-filter=".eye">
						eye
					</button>

					<button class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5" data-filter=".lip">
						lip
					</button>

					<button class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5" data-filter=".cheek">
						cheek
					</button>
				</div>

				<div class="flex-w flex-c-m m-tb-10">

					<div class="flex-c-m stext-106 cl6 size-105 bor4 pointer hov-btn3 trans-04 m-tb-4 js-show-search">
						<i class="icon-search cl2 m-r-6 fs-15 trans-04 zmdi zmdi-search"></i>
						<i class="icon-close-search cl2 m-r-6 fs-15 trans-04 zmdi zmdi-close dis-none"></i>
						Search
					</div>
				</div>
				
				<!-- Search product -->
				<div class="dis-none panel-search w-full p-t-10 p-b-15">
					<div class="bor8 dis-flex p-l-15">
						<form action="/goods/search.do"  class="wrap-search-header flex-w p-l-15">
							<button class="size-113 flex-c-m fs-16 cl2 hov-cl1 trans-04">
								<i class="zmdi zmdi-search"></i>
							</button>
							<input class="mtext-107 cl2 size-114 plh2 p-r-15" type="text" name="searchText" placeholder="Search">
							<input type="hidden" name="searchId" value="pname">
						</form>
					</div>	
				</div>

			</div>

			<div class="row isotope-grid">
				<c:choose>
					<c:when test="${!empty goodsList}">
						<c:forEach var="goods"  items="${goodsList}">  
							<div class="col-sm-6 col-md-4 col-lg-3 p-b-35 isotope-item ${goods.category}">
								<!-- Block2 -->
								<div class="block2">
									<div class="block2-pic hov-img0">
										<img src="/upload/main/${goods.imagepath}" alt="IMG-PRODUCT">
										<a href="#" class="block2-btn flex-c-m stext-103 cl2 size-102 bg0 bor2 hov-btn1 p-lr-15 trans-04 js-show-modal1">
											Quick View
										</a>
									</div>
		
									<div class="block2-txt flex-w flex-t p-t-14">
										<div class="block2-txt-child1 flex-col-l ">
											<a href="/goodsDetail/${goods.gno}" class="stext-104 cl4 hov-cl1 trans-04 js-name-b2 p-b-6">
												${goods.pname} 
											</a>
			
											<span class="stext-105 cl3">
												${goods.sellPrice} 
											</span>
										</div>
										
										<div class="block2-txt-child2 flex-r p-t-3">
											<a class="btn-addwish-b2 dis-block pos-relative js-addwish-b2">
												<img class="icon-heart1 dis-block trans-04" src="../resources/images/icons/icon-heart-01.png" alt="ICON">
												<img class="icon-heart2 dis-block trans-04 ab-t-l" src="../resources/images/icons/icon-heart-02.png" alt="ICON">
												<input type="hidden" name="goods_no" value="${goods.gno}" class="goodsno"/>
											</a>
										</div>
									</div>
								</div>
							</div>			
						
						</c:forEach>
						
					</c:when>
				</c:choose>
				
			</div>

			
			<div class="text-center">
				<c:if test="${tot != null }" >

					<ul class="pagination">

					<c:choose>
							<c:when test="${section > 1 && page==1 }">
								<li><a class="no-uline"
									href="/board/list.do?section=${section-1}&pageNum=${(section-1)*20 +1 }&katNo=${katTargetNo}">&lt;&nbsp;</a></li>
							</c:when>
							<c:otherwise>
								<li><a class="no-uline">&lt;&nbsp;</a></li>
							</c:otherwise>
					</c:choose>
						<c:choose>
							<c:when test="${tot > 200 }">
								<c:forEach var="page" begin="1" end="10" step="1">
									<c:if test="${section > 1 && page==1 }">
									</c:if>
										<li><a class="no-uline"
											href="/home?section=${section}&pageNum=${page}&katNo=${katTargetNo}">${(section-1)*20 +page}</a></li>
								</c:forEach>
							</c:when>
							<c:when test="${tot == 200 }">
								<c:forEach var="page" begin="1" end="10" step="1">
									<li><a class="no-uline" href="#">${page}</a>
									<li>
								</c:forEach>
							</c:when>
							<c:when test="${tot< 200 }">
								<c:forEach var="page" begin="1" end="${tot/20 +1}" step="1">
									<c:choose>
										<c:when test="${page== pageNum }">
											<li><a class="sel-page"
												href="/home?section=${section}&pageNum=${page}&katNo=${katTargetNo}">${page }
											</a></li>
										</c:when>
										<c:otherwise>
											<li><a class="no-uline"
												href="/home?section=${section}&pageNum=${page}&katNo=${katTargetNo}">${page }
											</a></li>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</c:when>
						</c:choose>
					<c:choose>
							<c:when test="${section < 1 && page<10 }">
								<li><a class="no-uline" style="color:black;">&nbsp;&gt;</a></li>
							</c:when>
							<c:otherwise>
								<li><a class="no-uline"
									href="/home?section=${section+1}&pageNum=${section*20+1}&katNo=${katTargetNo}">&nbsp;&gt;</a></li>
							</c:otherwise>
					</c:choose>
						

						
					</ul>
				</c:if>
			</div>
		</div>
	</section>

</body>

<%@include file="../includes/modal.jsp" %>	

<script>
$(document).ready(function(){
	
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");

	
    $("#insertLike").click(function(){
    	var gno = $("#goods_no_ajax").val();
			
			var jsonData = { 'gno' : gno }
			console.log(jsonData);
     	$.ajax({
    		url: '/wish/addwish',
    		data: jsonData,
    		type: 'POST',
    		beforeSend: function(xhr) { //XMLHttpRequest (XHR)은 AJAX 요청을 생성하는 JavaScript API이다. XHR의 메서드로 브라우저와 서버간의 네트워크 요청을 전송할 수 있다.
    			xhr.setRequestHeader(header, token); //csrf 전송하지 않으면 아예 ajax가 되지 않는 문제가 생김.
    		},
    		success: function(result){
    			console.log(result);
   		},
			error: function(jqXHR, textStatus, errorThrown) {
				alert("ERROR : " + textStatus + " : " + errorThrown);
			}
    	});  //$.ajax
    });	
    
    $(".btn-addwish-b2").click(function(){            //클릭 시
        var value = $(this).children('.goodsno').val();     //클릭한 a태그의 하이퍼링크를 변수저장
		var jsonData = { 'gno' : value }

        console.log(value);
     	$.ajax({
    		url: '/wish/addwish',
    		data: jsonData,
    		type: 'POST',
			datatype:"text",
    		beforeSend: function(xhr) { //XMLHttpRequest (XHR)은 AJAX 요청을 생성하는 JavaScript API이다. XHR의 메서드로 브라우저와 서버간의 네트워크 요청을 전송할 수 있다.
    			xhr.setRequestHeader(header, token); //csrf 전송하지 않으면 아예 ajax가 되지 않는 문제가 생김.
    		},
    		success: function(result){
    			console.log(result);
    			var str=JSON.stringify(result);
    			
    			console.log(str);
    			
    			
    		},
			error: function(jqXHR, textStatus, errorThrown) {
				alert("ERROR : " + textStatus + " : " + errorThrown);
			}
    	});  //$.ajax
    });
});

</script>