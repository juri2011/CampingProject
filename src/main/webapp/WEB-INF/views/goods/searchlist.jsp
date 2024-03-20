<%@page import="com.fasterxml.jackson.annotation.JsonInclude.Include"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>

input[type=text], input[type=password] {
    height: 30px;
    line-height: 20px;
    padding: 2px 4px;
    border: 1px solid #d5d5d5;
    color: #353535;
    font-size: 12px;
}

.search-form {

}

select {
    height: 24px;
    border: 1px solid #d5d5d5;
}

.search-form .searchbox {
    border: 3px solid #e9e9e9;
    margin: 21px 0 20px;
    padding: 45px 0;
    background: #fff;
    width:100%;
}
.search-form .searchbox fieldset {
    width: 600px;
    margin: 0 auto;
    padding: 0 47px;
}

legend {
    visibility: hidden;
    position: absolute;
    left: -9999px;
    top: -9999px;
    width: 0;
    height: 0;
    line-height: 0;
}
.search-form .searchbox .item {
    margin: 8px 0 0;
    color: #353535;
    line-height: 20px;
    *zoom: 1;
}

.search-form .searchbox .popular {
    margin: 6px 0 0 86px;
    font-size: 11px;
    line-height: 18px;
    *zoom: 1;
}

.search-form .searchbox .popular.xans-search-hotkeyword {
    margin-bottom: 17px;
}

.search-form .searchbox .item strong {
    float: left;
    width: 75px;
    padding: 5px 10px 0 0;
}
strong {
    font-weight: bold;
}

.search-form .searchbox #product_price1 {
    width: 170px;
    margin: 0 5px 0 0;
}

.search-form .searchbox .item input {
    padding: 5px 4px 5px 10px;
	display: inline-block;
}


.search-form .searchbox #product_price2 {
    width: 170px;
    margin: 0 0 0 5px;
}
search-form .searchbox #order_by {
    width: 400px;
}

.search-form .searchbox select {
    height: 30px;
    display: inline-block;
}	

.search-form .searchbox #search_type {
    width: 120px;
}

.search-form .searchbox #keyword {
    width: 260px;
}

.search-form .searchbox .popular strong {
    float: left;
    min-width: 55px;
    padding: 0 10px 0 0;
    color: #6b6b6b;
}

.search-form .searchbox #exceptkeyword {
    width: 200px;
    padding: 5px 4px 5px 10px;
}

.search-form .searchbox .button .btnSubmitFix {
    background-color: #333;
}

[class^='btn'][class*='Fix'].sizeM {
    width: 120px;
    padding-left: 8px;
    padding-right: 8px;
}
[class^='btn'].sizeM {
    padding: 10px 16px;
}

[class^='btnSubmit'], a[class^='btnSubmit'] {
    display: inline-block;
    box-sizing: border-box;
    padding: 2px 8px;
    border: 1px solid transparent;
    border-radius: 2px;
    font-family: "굴림",Gulim;
    font-size: 12px;
    line-height: 18px;
    font-weight: normal;
    text-decoration: none;
    vertical-align: middle;
    word-spacing: -0.5px;
    letter-spacing: 0;
    text-align: center;
    white-space: nowrap;
    color: #fff;
    background-color: #4a5164;
}

.search-form .searchbox .button {
    margin: 30px 0 0 170px;
}

</style>

<body class="animsition">

				<form action="/goods/search.do" >
					<div class="search-form">
						<div class="ec-base-box searchbox">
							<fieldset>
								<legend>상품 검색</legend>
								<div class="item">
									<strong>상품분류</strong> 
									<select id="category_no" name="category" >
										<option value="0" selected="selected">상품분류 선택</option>
										<option value="skincare">skincare</option>
										<option value="base">base</option>
										<option value="eye">eye</option>
										<option value="lip">lip</option>
										<option value="cheek">cheek</option>
									</select>
								</div>
								<div class="item overview">
									<strong>검색조건</strong> 
									<select id="search_type" name="searchId">
										<option value="pname" selected="selected">상품명</option>
										<option value="product_code">상품코드</option>
										<option value="ma_product_code">자체상품코드</option>
										<option value="manu_name">제조사</option>
										<option value="prd_model">모델명</option>
										<option value="prd_brand">브랜드명</option>
										<option value="prd_trand">트랜드명</option>
									</select> 
									<input id="keyword" name="searchText"  class="inputTypeText" placeholder="화장품명을 입력해주세요" size="15" value="" type="text">
								</div>
								<div class="item">
									<strong>판매가격대</strong> 
									<input id="product_price1" name="price1" class="input01" placeholder="" size="15" value="0" type="text"> ~ 
									<input id="product_price2" name="price2" class="input01" placeholder="" size="15" value="0" type="text">
								</div>
<!--  								<div class="item">
									<strong>검색정렬기준</strong> 
									<select id="order_by" name="order_by">
										<option value="" selected="selected">::: 기준선택 :::</option>
										<option value="recent">신상품 순</option>
										<option value="name">상품명순</option>
										<option value="priceasc">낮은가격 순</option>
										<option value="price">높은가격 순</option>
									</select>
								</div>-->
									<p class="button">
										<button type="submit" class="btnSubmitFix sizeM">검색</button>
									</p>
							</fieldset>
						</div>
					</div>
				</form>

	<!-- Product -->
	<div class="bg0 m-t-23 p-b-140">
		<div class="container">
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
					<div
						class="flex-c-m stext-106 cl6 size-105 bor4 pointer hov-btn3 trans-04 m-tb-4 js-show-search">
						<i class="icon-search cl2 m-r-6 fs-15 trans-04 zmdi zmdi-search"></i>
						<i
							class="icon-close-search cl2 m-r-6 fs-15 trans-04 zmdi zmdi-close dis-none"></i>
						Search
					</div>
				</div>

				<!-- Search product -->
				<div class="dis-none panel-search w-full p-t-10 p-b-15">
					<div class="bor8 dis-flex p-l-15">
						<button class="size-113 flex-c-m fs-16 cl2 hov-cl1 trans-04">
							<i class="zmdi zmdi-search"></i>
						</button>

						<input class="mtext-107 cl2 size-114 plh2 p-r-15" type="text"
							name="search-product" placeholder="Search">
					</div>
				</div>

				<!-- Filter -->
				
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
											<a href="#" class="btn-addwish-b2 dis-block pos-relative js-addwish-b2">
												<img class="icon-heart1 dis-block trans-04" src="../resources/images/icons/icon-heart-01.png" alt="ICON">
												<img class="icon-heart2 dis-block trans-04 ab-t-l" src="../resources/images/icons/icon-heart-02.png" alt="ICON">
											</a>
										</div>
									</div>
								</div>
							</div>			
					
						</c:forEach>
					</c:when>
				</c:choose>
			</div>
				
			</div>

			<!-- Load more -->
			<div class="flex-c-m flex-w w-full p-t-45">
				<a href="#"
					class="flex-c-m stext-101 cl5 size-103 bg2 bor1 hov-btn1 p-lr-15 trans-04">
					Load More </a>
			</div>
		</div>

	<%@include file="../includes/modal.jsp"%>