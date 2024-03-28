<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<link
  rel="stylesheet"
  href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css"
/>
<link rel="stylesheet" type="text/css" href="../resources/css/reviewlist.css">
<link rel="stylesheet" type="text/css" href="../resources/css/detail.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
	integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk">

<script src="https://code.jquery.com/jquery-3.5.1.min.js"
	integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
	crossorigin="anonymous"> 
</script>
<script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<!-- CSS only -->

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<!-- JS, Popper.js, and jQuery -->
<!-- <script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
	integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"
	integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI"
	crossorigin="anonymous"></script> -->

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body style="overflow: visible;">
	<br>
	<br>
	<div style="width:100%; position:relative; left:calc(50% - 600px); height:600px; display:inline">

		<div class="detailArea">
			<div class="xans-element- xans-product xans-product-image imgArea">
				<div style="width:500;">
					<table border="0">
						<tr>
							<td>
								<img src="/upload/main/${goods.imagepath}" width="100%" height="500" />
								<input type="hidden" id="goods_no_ajax" value="${goods.gno}" />
							</td>
						</tr>
					</table>
					<div id="test-swiper" class="swiper-container xans-element- xans-product xans-product-addimage listImg cboth" style="position: relative; margin-top: 10px; height: 134px;">
						<ul class="swiper-wrapper">
							<c:forEach var="item" items="${imagelist}">
								<li class="swiper-slide">
									<div style="float: left;">
										<img src="/upload/sub/${item.imagepath}" class="ThumbImage" alt>
									</div>							
								</li>	 
							</c:forEach>
						</ul>
						<button type="button" class="prev" style="display: none;">이전</button>
						<button type="button" class="next"></button>				
					</div>
				</div>
			</div>
				<div style="float:left; margin-left:30px; width:682;">
						<table border="0">
			 
							<tr>
								<td>
									<div id="sale_bg" style="display: block;">
										<span class="sale_text">23%</span>
										SALE
									</div>
								</td>
							</tr>
			
							<tr>
								<td id="pname" value="${goods.pname}"><font size="5"
									style="box-sizing: border-box; position: relative;"><h2>${goods.pname}</h2></font></td>
							</tr>
									
							<tr>
								<td><hr style="border-top: 1px solid #bbb;" width=670px>
								<td>
							</tr>
						
			
			<%-- 				<tr>
								<td><font size="3">${ColorSize}color</font></td>
							</tr> --%>
			
							<tr>
								<td></td>
							</tr>
			
							<tr style="display: inline-block; flex:left;">
								<td id="sellPrice" width="200px"
									style="font-weight: 600px; font-Size: 18px; line-height: 42px;">
									판매가격 
								</td>
								<td id="test">
									<fmt:formatNumber value="${goods.sellPrice}" pattern="#,###" />원
								</td>
			
							</tr>
							
							<tr>
								<td id="discountPrice" 
									style="font-weight: 600px; font-Size: 24px; line-height: 42px; color: red;">
									할인가격 <fmt:formatNumber value="${goods.discountPrice}" pattern="#,###" />원
								</td>
								<!-- <td>3만원 이상 구매시 할인가격 구매 가능</td> -->
							</tr>
						</table>
			
			<!-- 			<table>
							<tr>
								<td><hr style="border-top: 1px solid #bbb;" width=670px>
								<td>
							</tr>
						</table> -->
			
						<br>
					
						<table>
							<tr class="option_section">
								<td width="340px"><font size="3">배송비</font></td>
								<td><font size="3">선불 3,000원(50,000원 이상 무료배송)</font></td>
							</tr>
						</table>
						<table>
							<tr class="option_section">
								<td width="537px"><font size="3">배송종류</font></td>
								<td><font size="3">&nbsp;국내배송</font></td>
							</tr>
						</table>
			 			<table>
							<tr>
								<td><hr style="border-top: 1px solid #bbb;" width=670px>
								<td>
							</tr>
						</table>
						<div id="item_option">
							<c:set var="list" value="${goods.option_list_split}" />			
							<div id="item_option">
								<table>
									<tr>
										<td><select name="option" id="option"
											class='org.zerock.domain.Goods'  onclick="changeOptionSelect()"
											style="width: 600px; height: 30px;">
												<option id="option_box_0" value="">== (필수)옵션: 세부 사항 선택 ==</option>
												<c:forEach var="option_each" items="${list}" varStatus="status">
													<option id="option_box_${status.count}" value="${option_each}" class="option_each">${option_each}</option>
												</c:forEach>
											</select>
										</td>
									</tr>
								</table>
							</div>
						</div>
					<div id="totalProducts">
						<table border="1" summary>
							<caption>상품 목록</caption>
							<colgroup>
								<col style="width:284px;">
								<col style="width:80px;">
								<col style="width:110px;">
							</colgroup>
							<thead>
								<tr class="displaynone">
									<th scope="col">상품명</th>
									<th scope="col">상품수</th>
									<th scope="col">가격</th>
								</tr>
							</thead>
			
							<tbody class="option_products" id="option_products">
			
							</tbody>
						</table>
					</div>
						<form id="frm" name="frm" method="post">
			
							<div>
								<table style="border:1px;" id="dynamicTable">
									<thead>
									</thead>
			
									<tbody id="dynamicTbody">
										
									</tbody>
									
								</table>
							</div>
			
						</form>
									
						<div class="totals-item totals-item-total" style="float:left; margin-left:400px;">
				      		<label class="total_price">총상품금액</label>&nbsp;&nbsp;
				     		 <div class="total_price" style="float:right;">원</div>
				      		<div class="totals-value" id="cart-total" style="float:right;">0</div>
				   	    </div>
						<br><br>
						
						<table>
							<tr>
								<td><hr style="border-top: 1px solid #bbb;" width=670px>
								<td>
							</tr>
						</table>
			
						<button style="width: 124px; height: 58px;"
							class="btn btn-outline-danger" id="insertLike">
							<font size="5px">♥</font>
						</button>
						<button style="width: 270px; height: 58px;"
							class="btn btn-outline-danger" id="insertBasket">장바구니</button>
						<button style="width: 270px; height: 58px;"
							class="btn btn-outline-danger" id="goodsOrder">구매하기</button>
						<br>
			
						<!-- <button id="update" onclick="fn_update()">수정하기</button> -->
					
					</div> 
				</div> 
			
		</div>


		<div style="clear: both;"></div>

	<br><br><br><br><br>
	<div id="wrap">
		<div id="container">
			<div id="contents">
				<div class="xans-element- xans-product xans-product-additional">
					<div id="detail" class="cboth pdt80">
					</div>
					<div class="detail_tab">
						<ul class="cboth title_detail">
							<li class="tab_open">
								<a href="#datail" data-tab="1">상품상세정보</a>
							</li>
							<li>
								<a href="#review" data-tab="2" class="crema-product-reviews-count crema-applied" data-product-code="634" data-format="리뷰 ({{{count}}})">리뷰 (${ReviewCount})</a>
 							</li>
 							<li>
 								<a href="#guide" data-tab="3">구매유의사항</a>
 							</li>
 							<li>
 								<a href="#qna" data-tab="4">상품 Q&A</a>
 							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<div class="tab-content current" id="myTabContent1" align="center" style="">
<%--   			<div class="swiper">
				<div class="swiper-wrapper">
					<div class="swiper-slide" style="justify: center;">

						<c:if test="${!empty reviewList2}">
							<c:forEach var="review2" items="reviewList2" begin="0" end="4"
								step="1">
								<div class="container"
									style="display: inline-block; max-width: 200px; margin-right: 20px;">
									<div class="card" style="width: 200px">
										<img class="card-img-top" src="${review2.imagepath}"
											alt="Card image" style="width: 200px; height: 200px;">
										<div>
											<!-- class="card-body" -->
											<p
												style="padding-top: 0; padding-bottom: 5px; color: black; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; font-size: 12px; margin: 0;">${review2.content}</p>
											<p id="choo"
												style="display: inline-block; margin: 0; padding: 0; display: flex; justify-content: space-between;">
												<span
													style="float: left; max-width: 55px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; font-size: 11px; line-height: 16px;">${review2.mem_id}</span>
												<span
													style="float: right; display: block; margin: 0; color: #767676; font-size: 11px; line-height: 16px;">${review2.regidate}</span>
											</p>
										</div>
									</div>
									<br>
								</div>
							</c:forEach>
						</c:if>
					</div>
 					<div class="swiper-slide" style="justify: center;">
						<c:if test="${!empty reviewList2}">
							<c:forEach var="review2" items="reviewList2" begin="5" end="9"
								step="1">
								<div class="container"
									style="display: inline-block; max-width: 200px; margin-right: 20px;">
									<div class="card" style="width: 200px">
										<img class="card-img-top" src="${review2.imagepath}"
											alt="Card image" style="width: 200px; height: 200px;">
										<div>
											<!-- class="card-body" -->
											<p
												style="padding-top: 0; padding-bottom: 5px; color: black; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; font-size: 12px; margin: 0;">${review2.content}</p>
											<p id="choo"
												style="display: inline-block; margin: 0; padding: 0; display: flex; justify-content: space-between;">
												<span
													style="float: left; max-width: 55px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; font-size: 11px; line-height: 16px;">${review2.mem_id}</span>
												<span
													style="float: right; display: block; margin: 0; color: #767676; font-size: 11px; line-height: 16px;">${review2.regidate}</span>
											</p>
										</div>
									</div>
									<br>
								</div>
							</c:forEach>
						</c:if>
					</div> 
				</div>
				<div class="swiper-pagination"></div>  
			</div> --%>
			
			<!-- 상세정보 -->
			<div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">${goods.content}</div>
		</div>
 
<!-- 	<div class="tab-content current" id="myTabContent1" align="center" style="">

		</div> -->	
		<div class="tab-content" id="myTabContent2" align="center" >
			<!-- 리뷰 -->
			<jsp:include page="../review/list.jsp"></jsp:include>
		</div>
		<div class="tab-content" id="myTabContent3" align="center">	
			<!-- 상품 유의 사항 -->
			<div id="prdInfo">
				<div class="cboth prdInfo_box">
					<div class="prdInfo_line">
						<div class="pinfo">
							<h3>상품결제정보</h3>
						</div>
						<div class="cboth prdInfo_text">
							" 고액결제의 경우 안전을 위해 카드사에서 확인전화를 드릴 수도 있습니다. 확인과정에서 도난 카드의 사용이나 타인 명의의 주문등 정상적인 주문이 아니라고 판단될 경우 임의로 주문을 보류 또는 취소할 수 있습니다.  "
							<br>
							<br>
							" 무통장 입금은 상품 구매 대금은 PC뱅킹, 인터넷뱅킹, 텔레뱅킹 혹은 가까운 은행에서 직접 입금하시면 됩니다."
							<br>
							" 주문시 입력한 입금자명과 실제입금자의 성명이 반드시 일치하여야 하며, 4일 이내로 입금을 하셔야 하며 입금되지 않은 주문은 자동취소 됩니다."
						</div>
					</div>
					<div class="prdInfo_line">
						<div class>
							<h3>배송정보</h3>
						</div>
						<div class="cboth prdInfo_text"></div>
					</div>
				</div>
				<div class="cboth prdInfo_box topline" style="margin-top:0px !important;"></div>
			
			</div>
		</div>
		<div class="tab-content" id="myTabContent4" align="center">
			<!-- 클레임 or Qna -->
			<jsp:include page="../claim/customclaim.jsp"></jsp:include>
		</div>	
	</div> 

	<input type="hidden" id="hii" value="${goods.discountPrice}" />
<!--  	</div>-->


	<br>
	<br>
	<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
	<script>
		$(document).ready(function(){
			  
			$('ul.title_detail li a').click(function(){
			  	var tab_id = $(this).attr('data-tab');
	
			    $('ul.title_detail li').removeClass('tab_open');
			    $('.tab-content').removeClass('current');
	
			    $(this).parent().addClass('tab_open');
			    $("#myTabContent"+tab_id).addClass('current');
			})
			
			
			var swiper = new Swiper("#test-swiper", {
		        spaceBetween: 5,    // 슬라이드 사이 여백
	
		        slidesPerView : 5, // 한 슬라이드에 보여줄 갯수
		        autoplay: {     //자동슬라이드 (false-비활성화)
		          delay: 30000000, // 시간 설정
		          disableOnInteraction: false, // false-스와이프 후 자동 재생
		        },

		        loop : false,   // 슬라이드 반복 여부
		        loopAdditionalSlides : 1,

		 	
		      });

		  	
		    $("#insertBasket").click(function(){
		    	var dataList = []; 
	   			var pname = $("#pname").attr('value'); 
	   			var gno = $("#gno").val();
	   			
	   			//옵션별 넣어주어야 할 내용
	   			for(var i = 0; i < arr.length; i++){
	   				var option_num = arr[i].slice(-1);
	   				
	   				var option_name = $("#option_name_" + option_num).attr('value');
	   				var sub_price = $('#option_box_price2_' + option_num).text();
	   				var quantity = $("#input_box_" + option_num).val();
	   				sub_price = sub_price.replaceAll(',','');
	   				sub_price = sub_price.replace(' 원','');
	   				var jsonData = {
		                      pname : pname,
		                      goods_no : gno,
		                      optionName : option_name,
		                      totalPrice : sub_price,
		    				  quantity : quantity                 
		            }
	   				dataList.push(jsonData); 

	   			}	   			
	   		
				console.log(dataList);
				console.log(JSON.stringify(dataList));
 	        	$.ajax({
	        		url: '/cart/putCart',
	        		processData: false,
	        		contentType: 'application/json',
	        		data: JSON.stringify(dataList),
	        		type: 'POST',
	        		dataType: false,
	        		beforeSend: function(xhr) { //XMLHttpRequest (XHR)은 AJAX 요청을 생성하는 JavaScript API이다. XHR의 메서드로 브라우저와 서버간의 네트워크 요청을 전송할 수 있다.
	        			xhr.setRequestHeader(header, token); //csrf 전송하지 않으면 아예 ajax가 되지 않는 문제가 생김.
	        		},
	        		success: function(result){
	        			console.log(result);
	        			alert('장바구니에 추가되었습니다.');
	        			$("#option_products").html('');
	        			$("#cart-total").html('0');
	        		},
	    			error: function(jqXHR, textStatus, errorThrown) {
	    				alert("ERROR : " + textStatus + " : " + errorThrown);
	    			}
	        	});  //$.ajax
	        });
			
		    $("#goodsOrder").click(function(){
		    	var dataList = []; 
	   			var pname = $("#pname").attr('value'); 
	   			var gno = $("#gno").val();
	   			
	   			//옵션별 넣어주어야 할 내용
	   			for(var i = 0; i < arr.length; i++){
	   				var option_num = arr[i].slice(-1);
	   				
	   				var option_name = $("#option_name_" + option_num).attr('value');
	   				var sub_price = $('#option_box_price2_' + option_num).text();
	   				var quantity = $("#input_box_" + option_num).val();

	   				sub_price = sub_price.replaceAll(',','');
	   				sub_price = sub_price.replace(' 원','');
	   				var jsonData = {
		                      pname : pname,
		                      goods_no : gno,
		                      optionName : option_name,
		                      totalPrice : sub_price,
		    				  quantity : quantity                 
		            }
	   				dataList.push(jsonData); 
	   			}	   			
	   		
				console.log(dataList);
				console.log(JSON.stringify(dataList));
 	        	$.ajax({
	        		url: '/cart/putCart',
	        		processData: false,
	        		contentType: 'application/json',
	        		data: JSON.stringify(dataList),
	        		type: 'POST',
	        		dataType: 'json',
	        		beforeSend: function(xhr) { //XMLHttpRequest (XHR)은 AJAX 요청을 생성하는 JavaScript API이다. XHR의 메서드로 브라우저와 서버간의 네트워크 요청을 전송할 수 있다.
	        			xhr.setRequestHeader(header, token); //csrf 전송하지 않으면 아예 ajax가 되지 않는 문제가 생김.
	        		},
	        		success: function(result){
	        			console.log(result);
	        			alert('장바구니에 추가되었습니다.');
	        			var resultdata= JSON.stringify(result);
	        			
//	        			console.log(data);
	        			//$("#option_products").html('');
	        			location.href='/cart/direct?cart_no=' + result.list;
	        		},
	    			error: function(jqXHR, textStatus, errorThrown) {
	    				alert("ERROR : " + textStatus + " : " + errorThrown);
	    			}
	        	});  //$.ajax
	        });	
		    
		    
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
	        			(result === 'insert') ? alert('위시리스트에 추가되었습니다.') : alert('위시리스트에서 해제되었습니다.');
	        			alert('위시리스트에 추가되었습니다.');
	        		},
	    			error: function(jqXHR, textStatus, errorThrown) {
	    				alert("ERROR : " + textStatus + " : " + errorThrown);
	    			}
	        	});  //$.ajax
	        });	
		})
		
	
	// 매개 변수로 사용시 swiper가 초기화 될 때 동작합니다.
	    var swiper = new Swiper(".swiper", {
        spaceBetween: 30,    // 슬라이드 사이 여백

        slidesPerView : 'auto', // 한 슬라이드에 보여줄 갯수
        centeredSlides: true,    //센터모드
        autoplay: {     //자동슬라이드 (false-비활성화)
          delay: 1000000, // 시간 설정
          disableOnInteraction: false, // false-스와이프 후 자동 재생
        },

        loop : false,   // 슬라이드 반복 여부

        loopAdditionalSlides : 1,

 		// 슬라이드 반복 시 마지막 슬라이드에서 다음 슬라이드가 보여지지 않는 현상 수정
        pagination: { // 호출(pager) 여부
          el: ".swiper-pagination", //버튼을 담을 태그 설정
          clickable: true, // 버튼 클릭 여부
        },
        navigation: {   // 버튼
          nextEl: ".swiper-button-next",
          prevEl: ".swiper-button-prev",
        },
      });
	</script>
	<script>
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");

	var arr = [];
	var mymap = new Map();
	
	const number = document.getElementById('option').childElementCount - 1;
	for(var i = 1; i <= number; i++){
		var option_name = document.getElementById("option_box_" + i).value;
		mymap.set(option_name, i);
	}
	
	function changeOptionSelect(){
	    var optionSelect = document.getElementById("option");
	    var option_box_id = optionSelect.options[optionSelect.selectedIndex].id;
	    if(option_box_id === 'option_box_0') return;
	    if(arr.includes(option_box_id)){
	    	document.getElementById("option_box_0").selected = true;
	    	return;
	    }
	    
	    arr.push(option_box_id);
	    // select element에서 선택된 option의 value가 저장된다.
	    var selectValue = optionSelect.options[optionSelect.selectedIndex].value;
	 	
	    var optionProducts = document.getElementById("option_products");
		console.log(arr);
	    
	    let html = optionProducts.innerHTML;
	  
	    html += "<tr class='option_product' id='data-option" + mymap.get(selectValue) + "' data-option-index='"+ mymap.get(selectValue) + "' target-key='238'><td>" +
	    "<input type='hidden' id='gno' value='"+ ${goods.gno} +"'>" +
		"<input type='hidden' class='option_box_id'  value='#' name='option_code' data-item-add-option data-item-reserved='N' data-option-id='00PF' data-option-index='1'>" +
		"<p class='product'>" + "${goods.pname}" + "<br><span id='option_name_"+ mymap.get(selectValue) + "' value='"+ selectValue +"'>" + selectValue + "</span></span></p></td><td>" +
			"<span class='quantity' style='width:65px;'>" + 
				"<input type='text' id='input_box_" +mymap.get(selectValue)+ "' name='quantity_opt[]' class='quantity_opt eProductQuantityClass' value='1' product-no=" + "'" + ${goods.gno} + "'"  + "style='border:1;'/>" + 
 				'<a href="#none" class="up eProductQuantityUpClass" data-target="option_box_'+ mymap.get(selectValue) + '_up">' +
					'<img src="./../../../resources/img/up.png" id="option_box_'+ mymap.get(selectValue) + '_up" class="option_box_up" alt="수량증가" onclick="valueUp()"></a>' + 
				'<a href="#none" class="down eProductQuantityDownClass" data-target="option_box_' + mymap.get(selectValue) + '_down">' +
					'<img src="./../../../resources/img/down.png" id="option_box_'+ mymap.get(selectValue) + '_down" class="option_box_down" alt="수량감소" onclick="valueDown()"></a>' +  
			'</span>' + 
			'<a href="#none" class="delete">' + 
				'<img src="./../../../resources/img/x.png" alt="삭제" id="option_box_' + mymap.get(selectValue) + '_del" data-target="data-option"'+ mymap.get(selectValue) + ' class="option_box_del" onclick="deleteOption()">' + 
			'</a></td>' +
		'<td class="right">' + 
			'<span>' + 
				'<input type="hidden" id="option_box_price'+ mymap.get(selectValue) + '" class="option_box_price" value="' + ${goods.discountPrice} + '" product-no="' + ${goods.gno} + '"' + 
				'item_code="P00000JE00PF">' + 
				'<span id="option_box_price2_' + mymap.get(selectValue) + '" class="ec-front-product-item-price" code="P000000JE00PF" product-no="' + ${goods.gno} + '">' + 
				"<fmt:formatNumber value='${goods.discountPrice}' pattern='##,###' /> 원" + "</span></span></td></tr>";
		optionProducts.innerHTML = html;
		document.getElementById("option_box_0").selected = true;
		calculateTot();
	}
	
 	function deleteOption(){
		var deleteObj = event.target.id;
		var deleteObject = deleteObj.slice(11,12);
		var delTarget = document.getElementById("data-option" + deleteObject);
		delTarget.remove();
		var deleteThing = 'option_box_' + deleteObject;
		let filtered = arr.filter((element) => element !== deleteThing);
		arr = filtered;
		if(arr.length === 0){
			document.getElementById("option_box_0").selected = true;
		}
		calculateTot();
	} 
	
	function valueUp(){	
		var targetNum = event.target.id;
		var num = targetNum.slice(11,12);
		var inputbox = document.getElementById("input_box_" + num);
		var number = Number(inputbox.value);
		if(number <= 9){
			inputbox.setAttribute('value',number + 1);
		}else{
			return false;
		}
		calculateSub(num);
		calculateTot();
	}
	
	function valueDown(){
		
		var targetNum = event.target.id;
		var num = targetNum.slice(11,12);
		var inputbox = document.getElementById("input_box_" + num);
		var number = Number(inputbox.value);
		if(number >= 2){
			inputbox.setAttribute('value',number - 1);
		}else{
			return false;
		}
		calculateSub(num);
		calculateTot();
	} 
	
  	function calculateSub(num){
		var numTarget = document.getElementById("input_box_" + num);
		var quantity = Number(numTarget.value);
		var price = Number(document.getElementById("option_box_price"+num).value);
		console.log(quantity * price);
		
		document.getElementById("option_box_price2_"+num).setAttribute('value', (quantity * price));
		document.getElementById("option_box_price2_" + num).innerHTML = Number(quantity * price).toLocaleString()+" 원";
		
	}
  	
  	function imgStyleDel(){
  		var images = document.querySelectorAll(".tab-pane p img");
  		images.forEach((element) => {element.style=''});
  	}
  	function calculateTot(){
  		var calResult = 0;
  		const sections = document.querySelectorAll(".ec-front-product-item-price");
  		console.log(sections);
  		for(var i = 0; i < sections.length; i++){
  			var sp = sections[i].innerHTML;
  			sp = sp.replace(',','');
  			sp = sp.substr(0,sp.length-2);
  			calResult += Number(sp);
  		}
  		var cartTotal = document.getElementById("cart-total");
  		cartTotal.innerHTML = Number(calResult).toLocaleString();
  		return calResult;
  	}
  	imgStyleDel();
  	calculateTot();
  	
  	
	   function readURL(input) {
		      if (input.files && input.files[0]) {
			      var reader = new FileReader();
			      reader.onload = function (e) {
			        $('#preview').attr('src', e.target.result);
		          }
		         reader.readAsDataURL(input.files[0]);
		      }
		  }  

	</script>
</body>
</html>