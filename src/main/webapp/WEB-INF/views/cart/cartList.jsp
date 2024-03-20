<!-- Author : Jihyeon Kim / Sangkyeol Kim
무단 복제 사용을 금합니다.
-->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

			<body class="animsition">
				<style>
					.cart-input {
						width: 100% !important;
					}

					.delivery-info,
					.price-info,
					.payment {
						width: 100%;
					}

					.delivery-info>div,
					.price-info>div,
					.payment>div {
						display: flex;
						flex-direction: column;
					}

					.delivery-info>div>span {
						margin-top: 1vw;
					}

					.total-price {
						display: flex;
						flex-direction: row;
					}

					.final-price {
						display: flex;
						flex-direction: row;
					}

					.find-addr-modal {
						display: none;
						position: fixed;
						overflow: hidden;
						z-index: 9999;
						-webkit-overflow-scrolling: touch;
					}

					.close-btn {
						cursor: pointer;
						position: absolute;
						right: -3px;
						top: -3px;
						z-index: 1
					}
				</style>

				<!-- breadcrumb -->
				<div class="container">
					<div class="bread-crumb flex-w p-l-25 p-r-15 p-t-30 p-lr-0-lg">
						<a href="/" class="stext-109 cl8 hov-cl1 trans-04">
							Home
							<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
						</a>

						<span class="stext-109 cl4">
							장바구니
						</span>
					</div>
				</div>


				<!-- Shoping Cart -->
				<form class="bg0 p-t-75 p-b-85">
					<div class="container">
						<div class="row">
							<div class="col-lg-10 col-xl-7 m-lr-auto m-b-50">
								<div class="m-l-25 m-r--38 m-lr-0-xl">
									<div class="wrap-table-shopping-cart">
										<table class="table-shopping-cart product-list">
											<tr class="table_head">
												<th class="column-1">상품명</th>
												<th class="column-2"></th>
												<th class="column-3">가격</th>
												<th class="column-4">수량</th>
												<th class="column-5">합계</th>
											</tr>

											<!-- 상품 리스트업 섹션 -->
											<c:forEach var="cartItem" items="${cartItemList}">
												<tr class="table_row" data-goods-no="${cartItem.goodsNo}"
													data-goods-price="${cartItem.goodsPrice}"
													data-cart-no="${cartItem.cartNo}">
													<td class="column-1">
														<div class="how-itemcart1">
															<img src="/upload/main/${cartItem.goodsImage}"
																alt="${cartItem.goodsName}">
														</div>
													</td>
													<td class="column-2">${cartItem.goodsName}</td>
													<td class="column-3">${cartItem.goodsPrice}원</td>
													<input type="hidden" name="cartNo" id="cartNo" value="${cartItem.cartNo}" />
													<td class="column-4">
														<div class="wrap-num-product flex-w m-l-auto m-r-0">
															<div
																class="btn-num-product-down cl8 hov-btn3 trans-04 flex-c-m">
																<i class="fs-16 zmdi zmdi-minus"></i>
															</div>

															<input class="mtext-104 cl3 txt-center num-product"
																type="number" value="${cartItem.quantity}">

															<div
																class="btn-num-product-up cl8 hov-btn3 trans-04 flex-c-m">
																<i class="fs-16 zmdi zmdi-plus"></i>
															</div>
														</div>
													</td>
													<td class="column-5 item-price">${cartItem.goodsPrice *
														cartItem.quantity}원</td>
												</tr>
											</c:forEach>
										</table>
									</div>
								</div>
							</div>

							<!--===================== 결제창 시작 =================== -->
							<div class="col-sm-10 col-lg-7 col-xl-5 m-lr-auto m-b-50">
								<div class="bor10 p-lr-40 p-t-30 p-b-40 m-l-63 m-r-40 m-lr-0-xl p-lr-15-sm">
									<h4 class="mtext-109 cl2 p-b-30">주문하기</h4>

									<div class="flex-w flex-t bor12 p-b-13 price-info">
										<div>
											<div class="total-price">
												<span class="stext-110 cl2"> 상품 금액: </span>
												<span class="mtext-110 cl2 total-price-val" style="margin-left: 0.5vw;">
													0원 </span>
											</div>
											<span style="margin-top: 0.5vw;">+ 배송비: 3,500원</span>
											<div class="total-price" style="margin-top: 0.5vw;">
												<span class="stext-110 cl2"> 결제 총액: </span>
												<span class="mtext-110 cl2 payment-price-val"
													style="margin-left: 0.5vw;"> 0원 </span>
											</div>
										</div>
									</div>

									<div class="flex-w flex-t bor12 p-t-15 p-b-30">
										<div class="p-rl-18 delivery-info">
											<div>
												<span>성명</span>

												<input id="name"
													class="stext-104 cl2 plh4 size-117 bor13 p-lr-20 m-r-10 m-tb-5 cart-input"
													type="text" placeholder="성명을 입력해주세요">

												<span>전화번호</span>
												<input id="phone"
													class="stext-104 cl2 plh4 size-117 bor13 p-lr-20 m-r-10 m-tb-5 cart-input"
													type="text" placeholder="전화번호를 입력해주세요">

												<span>배송주소</span>
												<input id="addr1"
													class="stext-104 cl2 plh4 size-117 bor13 p-lr-20 m-r-10 m-tb-5 cart-input"
													type="text" placeholder="여기를 눌러 주소를 검색하세요" readonly
													style="cursor: pointer;" onclick="loadAddrModal()">
												<input id="addr2"
													class="stext-104 cl2 plh4 size-117 bor13 p-lr-20 m-r-10 m-tb-5 cart-input"
													type="text" placeholder="상세주소를 입력하세요">

												<span>배송메모</span>
												<input id="memo"
													class="stext-104 cl2 plh4 size-117 bor13 p-lr-20 m-r-10 m-tb-5 cart-input"
													type="text" placeholder="ex. 문앞에 놔주세요.">
											</div>
										</div>
									</div>

									<div class="flex-w flex-t bor12 p-t-15 p-b-30 payment">
										<button
											class="flex-c-m stext-101 cl0 size-116 bg3 bor14 hov-btn3 p-lr-15 trans-04 pointer"
											id="payment">
											결제하기</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</form>
				<!-- 결제창 끝 -->
				<input id="carttype"  name="carttype" value="${carttype}" type="hidden">
				<!-- 주소검색 modal -->
				<div id="layer" class ="find-addr-modal">
					<img src="https://t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer"
						class="close-btn" onclick="closeDaumPostcode()" alt="닫기 버튼">
				</div>
				<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
				<script>
					var element_layer = document.getElementById('layer');
					function closeDaumPostcode() {
						element_layer.style.display = 'none';
					}

					function loadAddrModal() {
						new daum.Postcode({
							oncomplete: function (data) {
								var addr = data.roadAddress;
								document.getElementById("addr1").value = addr;
								document.getElementById("addr2").focus();
								element_layer.style.display = 'none';
							},
							width: '100%',
							height: '100%',
							maxSuggestItems: 5
						}).embed(element_layer);
						element_layer.style.display = 'block';

						initLayerPosition();
					}
					function initLayerPosition() {
						var width = 50;
						var height = 60;
						var borderWidth = 3;

						element_layer.style.width = width + '%';
						element_layer.style.height = height + '%';
						element_layer.style.border = borderWidth + 'px solid';
						element_layer.style.left = '25%';
						element_layer.style.top = '30%';
					}
				</script>

				<!-- 결제  -->
				<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
				<script>
					function initPayment() {
						const IMP = window.IMP;
						IMP.init("imp65002722");
					}

					$(function () {
						initPayment();
					})

					function callPayment(data) {
						//상품명 가공

						let prdCount = 0;
						let prdName = "";

						$(".num-product").each(function () {
							prdCount += 1;
							if (prdCount == 1) {
								const input = $(this);
								prdName = input.parent().parent().siblings('.column-2').text();
							}
						});

						const paymentData = {
							pg: "kcp.A52CY",
							pay_method: "card",
							merchant_uid: data.orderNo,
							name: prdName + (prdCount > 1 ? "외 " + (prdCount - 1) + "건" : ""),
							amount: data.totalPrice
						}

						IMP.request_pay(paymentData, function (rsp) {
						});
					}
				</script>

				<script>
					function updateTotal() {
						let finalPrice = 0;

						$(".num-product").each(function () {
							const input = $(this);

							const count = input.val();
							const goodsPrice = input.parent().parent().parent().attr("data-goods-price");
							const totalPrice = count * goodsPrice;

							finalPrice += totalPrice;
						});

						$(".total-price-val").text(finalPrice + "원");
						$(".payment-price-val").text((finalPrice + 3500) + "원");
					}

					function updateCount(input) {
						const count = input.val();
						const cartNo = input.parent().parent().parent().attr("data-cart-no");
						const goodsPrice = input.parent().parent().parent().attr("data-goods-price");
						const newTotalPrice = count * goodsPrice;

						input.parent().parent().siblings(".item-price").text(newTotalPrice + "원");

						updateTotal();

						//DB에 업데이트

						const token = $("meta[name='_csrf']").attr("content");
						const header = $("meta[name='_csrf_header']").attr("content");

						const data = { cartNo: cartNo, quantity: count };

						$.ajax({
							type: "POST",
							beforeSend: function (xhr) {
								xhr.setRequestHeader(header, token);
							},
							url: "/order/updateCart",
							data: JSON.stringify(data),
							contentType: "application/json; charset=utf-8",
							dataType: "json",
							success: function (data) {
								if (data != null) {
									if (data.status != "SUCCESS") {
										alert(data.message);
									}
								} else {
									alert("접속 도중 오류가 발생했습니다.(2)");
								}

							},
							error: function (data) {
								alert("접속 도중 오류가 발생했습니다.");
							}
						});

					}

					function validate() {
						if ($("#name").val() == '') {
							alert("이름을 입력하세요.");
							return false;
						}

						if ($("#phone").val() == '') {
							alert("연락처를 입력하세요.");
							return false;
						}

						if ($("#addr1").val() == '') {
							alert("주소를 선택하세요.");
							return false;
						}

						if ($("#addr2").val() == '') {
							alert("상세주소를 입력하세요.");
							return false;
						}

						return true;

					}

					$(function () {
						updateTotal();

						$('.btn-num-product-down').on('click', function (e) {
							updateCount($(this).next());
						});

						$('.btn-num-product-up').on('click', function (e) {
							updateCount($(this).prev());
						});

						var num = $("#carttype").val();
						console.log(num);
						var url ="/order/" + ((num === 1) ? 'new1' : 'new2');
						//결제하기
						$("#payment").click(function (e) {
							e.preventDefault();
							if (validate() == false) {
								return;
							}

							//장바구니에 있는 전체 상품을 대상으로 결제합니다.
							/**
							 * 1. 전체 금액 체크, 주문번호 받아오기
							 * 2. 결제창 호출
							 * 3. 결제 결과 업데이트
							 **/

							const token = $("meta[name='_csrf']").attr("content");
							const header = $("meta[name='_csrf_header']").attr("content");

							const list = [];
							
							$("[name=cartNo]").each(function(idx){
								const data = {
										name: $("#name").val(),
										phone: $("#phone").val(),
										addr1: $("#addr1").val(),
										addr2: $("#addr2").val(),
										memo: $("#memo").val(),
										cart: $("[name=cartNo]:eq(" + idx + ")").val()
									};
								console.log(data.cart);
								list.push(data);
							});

							
							$.ajax({
								type: "POST",
								beforeSend: function (xhr) {
									xhr.setRequestHeader(header, token);
								},
								url:url,
								data: JSON.stringify(list),
								contentType: "application/json; charset=utf-8",
								dataType: "json",
								success: function (data) {
									if (data != null) {
										if (data.status != "SUCCESS") {
											alert(data.message);
										} else {
											//주문 등록 성공 => 결제 호출
											callPayment(data.data);
										}
									} else {
										alert("접속 도중 오류가 발생했습니다.(2)");
									}

								},
								error: function (data) {
									alert("접속 도중 오류가 발생했습니다.");
								}
							});

						});
					})
				</script>