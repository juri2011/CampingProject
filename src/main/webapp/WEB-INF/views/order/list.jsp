<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>


</style>
<link rel="stylesheet" type="text/css" href="../resources/css/orderlist.css">



<body class="animsition">
	<!-- Product -->
	<section class="bg0 p-t-23 p-b-140">
		<div class="container">
			<div class="p-b-10">
				<h3 class="ltext-103 cl5">주문 내역</h3>
			</div>

			<div class="flex-w flex-sb-m p-b-52">
				<c:forEach var="item" items="${list}" >
					<div class="content">
						<div class="content-head">
							<div class="update-date">${item.payDate} 주문</div>
							<div class="head-data">
								<a href="/goodsDetail/${item.gno}" target="_blank" class="sc-gnmni8-10 sc-8q24ha-0 yma-DD hPjYZj">
 									<span class="head-text">주문 상세보기</span>
 								</a>
							</div>
						</div>
						<div class="card">
							<table>
								<colgroup>
									<col width="1000">
									<col width="">
								</colgroup>
								<tbody>
									<tr>
										<td class="tablerow">
											<div class="left-head">
												<div class="left-data">
													<span font-weight="bold" color="#111111" style="font-size: 1.25rem" class=" hullgd">${item.dstatusStr}</span>
													<span size="4" class="SWzAJ">
														<span size="4" class="sc-13xhsmd-1 kMeFyN"></span>
													</span>
													<c:if test="${item.dstatus ne '1'}">
														<span font-weight="normal" color="#008C00" class="font-green font-size125">${item.parcelDate} 도착</span>
													</c:if>
												</div>
											</div>
											<div class="table-content">
												<div class="margin-top">
													<div class="order-data">
														<div class="image-form">
															<a class="thimage"  href="" target="_blank">
																<img loading="lazy" width="64" height="64" src="/upload/main/${item.imagepath}">
															</a>
														</div>
														<div class="text-form">
															<div class="jBCCpd">
																<a href="/goodsDetail/${item.gno}" target="_blank" class="sc-gnmni8-10 sc-8q24ha-0 yma-DD hPjYZj">
																	<span style="color:#111111;">${item.pname}</span>
																</a>
																<a class="yma-DD iDQVMP">
																	<div class="gFbjJh">
																		<div class="jxRaeI">
																			<span style="font-weight:normal;"  class="kftgZM">${item.originalPrice}원</span>
																			<span class="kYtEGM">
																				<span class="joIhoV"></span>
																			</span>
																			<span class="jtWNEg">1 개</span>
																		</div>
																	</div>
																	<div class="cUFnye">
																		<button class="iCTfhh bZaQeF">장바구니 담기</button>
																		<div class="sc-xuyxga-1 hxalxw"></div>
																	</div>
																</a>
																<div class="igPkOG"></div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</td>
										<td class="sc-gnmni8-6 gbTJl">
											<div class="sc-gnmni8-7 bCQoer">
												<c:if test="${item.dstatus ne '1'}">
													<button id="myButton1" class="sc-1k9quwu-0 fUUUKW sc-4d0nwb-0 iiEWkt" onclick="fn_Track('/track/list.do',${item.orderNo},${item.gno})">배송조회</button>
												</c:if>
												<button class="sc-1k9quwu-0 fTrGbC sc-gnmni8-8 kiiuoA" onclick="fn_Review('/review/form.do',${item.gno})">리뷰 작성하기</button>
												<input type="hidden" id="code" value="${item.parcelCd}">
												<input type="hidden" id="invoice" value="${item.waybillNum}">
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="sc-h20x0n-0 gcWEbw"></div>
					</div>
				</c:forEach>

				<!-- Load more -->
				<div class="flex-c-m flex-w w-full p-t-45">
					<a href="#" class="flex-c-m stext-101 cl5 size-103 bg2 bor1 hov-btn1 p-lr-15 trans-04">Load More</a>
				</div>
			</div>
		</div>
	</section>

</body>

<script>
	function fn_Review(url,data){
		var form = document.createElement("form");
		form.setAttribute("method", "get");
		form.setAttribute("action", url);
	    var parentNOInput = document.createElement("input");
	    parentNOInput.setAttribute("type","hidden");
	    parentNOInput.setAttribute("value",data);
	    parentNOInput.setAttribute("name","gno");
	
	    form.appendChild(parentNOInput);
	 	document.body.appendChild(form);
	    
	 	console.log(form);
	 	
		form.submit();
	 }
	
	function fn_Track(url,data,data2){
		var form = document.createElement("form");
		form.setAttribute("method", "get");
		form.setAttribute("action", url);
	    var parentNOInput = document.createElement("input");
	    parentNOInput.setAttribute("type","hidden");
	    parentNOInput.setAttribute("value",data);
	    parentNOInput.setAttribute("name","orderlistNo");

	    form.appendChild(parentNOInput);

	    var parentNOInput2 = document.createElement("input");

	    parentNOInput2.setAttribute("type","hidden");
	    parentNOInput2.setAttribute("value",data2);
	    parentNOInput2.setAttribute("name","gno");

	    form.appendChild(parentNOInput2);
	 	document.body.appendChild(form);
	    
	 	console.log(form);
	 	
		form.submit();
	 }


	
</script>
