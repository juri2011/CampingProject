<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="http://code.jquery.com/jquery-1.7.js"></script>
<script src="<c:url value='/resources/js/common.js'/>" charset="utf-8"></script>
<script src="/resources/ckeditor2/ckeditor.js"></script>
<!--===============================================================================================-->	
	<link rel="icon" type="image/png" href="/resources/images/icons/favicon.png"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/resources/vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/resources/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="../resources/fonts/iconic/css/material-design-iconic-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/resources/fonts/linearicons-v1.0.0/icon-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/resources/vendor/animate/animate.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="/resources/vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/resources/vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/resources/vendor/select2/select2.min.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="/resources/vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/resources/vendor/slick/slick.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/resources/vendor/MagnificPopup/magnific-popup.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/resources/vendor/perfect-scrollbar/perfect-scrollbar.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/resources/css/main.css">
<!--===============================================================================================-->
<style>
@CHARSET "UTF-8";

a:link, a:visited {text-decoration: none; color: #656565;}

.board_list {width:100%;border-top:2px solid #252525;border-bottom:1px solid #ccc}
.board_list thead th:first-child{background-image:none}
.board_list thead th {border-bottom:1px solid #ccc;padding:12px 0 13px 0;color:#3b3a3a;vertical-align:middle}
.board_list tbody td {border-top:1px solid #ccc;padding:10px 0;text-align:center;vertical-align:middle}
.board_list tbody tr:first-child td {border:none}
.board_list tbody td.title {text-align:left; padding-left:20px}
.board_list tbody td a {display:inline-block}

.board_view {width:50%;border-top:2px solid #252525;border-bottom:1px solid #ccc}
.board_view tbody th {text-align:left;background:#f7f7f7;color:#3b3a3a}
.board_view tbody th.list_tit {font-size:13px;color:#000;letter-spacing:0.1px}
.board_view tbody .no_line_b th, .board_view tbody .no_line_b td {border-bottom:none}
.board_view tbody th, .board_view tbody td {padding:15px 0 16px 16px;border-bottom:1px solid #ccc}
.board_view tbody td.view_text {border-top:1px solid #ccc; border-bottom:1px solid #ccc;padding:45px 18px 45px 18px}
.board_view tbody th.th_file {padding:0 0 0 15px; vertical-align:middle}

a {
  text-decoration: none;
  color: #666;
}

h1 {
    text-align: center;
    padding: 50px 0;
    font-weight: normal;
    font-size: 2em;
    letter-spacing: 10px;
}  

.pad_5 {padding: 5px;}
.wdp_90 {width:90%}
.btn {border-radius:3px;padding:5px 11px;color:#fff !important; display:inline-block; background-color:#6b9ab8; border:1px solid #56819d;vertical-align:middle}

#listbutton {
	padding-bottom: 40px;
}

div.col-sm-6.col-lg-3.p-b-50 {
	padding-top: 20px;
}
</style>
</head>
<body>

	<header class="header-v4">
		<!-- Header desktop -->
		<div class="container-menu-desktop">
				<nav class="limiter-menu-desktop container">
					
					<!-- Logo desktop -->		
					<a href="/home" class="logo">
						<img src="/resources/images/icons/logo-01.png" alt="IMG-LOGO">
					</a>

					<!-- Menu desktop -->
					<div class="menu-desktop">
						<ul class="main-menu">
							 <li class="active-menu">
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
							</li>
					</div>	

				</nav>
				
		</div>

		<!-- Header Mobile -->
		<div class="wrap-header-mobile">
			<!-- Logo moblie -->		
			<div class="logo-mobile">
				<a href="/home"><img src="/resources/images/icons/logo-01.png" alt="IMG-LOGO"></a>
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
						Free shipping for standard order over $100
					</div>
				</li>

				<li>
					<div class="right-top-bar flex-w h-full">
						<a href="#" class="flex-c-m p-lr-10 trans-04">
							Help & FAQs
						</a>

						<a href="#" class="flex-c-m p-lr-10 trans-04">
							My Account
						</a>

						<a href="#" class="flex-c-m p-lr-10 trans-04">
							EN
						</a>

						<a href="#" class="flex-c-m p-lr-10 trans-04">
							USD
						</a>
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
					<img src="/resources/images/icons/icon-close2.png" alt="CLOSE">
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

<br><br>
<div align="center">
<h2>${title}</h2>
</div>

<br><br>
<div align="center">
	<form name="frm" id="frm" enctype="multipart/form-data" method="post">
		<table align="center" border="0">
			<tr>
				<th>상세내용</th>
				<td>
					<textarea rows="30" cols="100" id="content" name="content">
					<c:if test="${type eq 'modify'}">${claim.content}</c:if>
					</textarea>
				</td>
			</tr>

			<tr>
				<th>종류</th>
				<td>
					<select name="#">
						<option value="1">교환</option>
						<option value="2">환불</option>
					</select>
				</td>
			</tr>

			<tr>
				<th>교환/환불 사유</th>
				<td>
					<select name="status">
						<option value="1">단순변심</option>
						<option value="2">제품하자</option>
						<option value="3">사이즈</option>
						<option value="4">오배송</option>
						<option value="5">기타</option>
					</select>
				</td>
			</tr>
			<input type="hidden" id="gno" name="gno" value="${gno}">
		</table>
		
		<div class="image">
			<div class="image-wrap">
				<p>업로드 이미지</p>
				<br> <input type="file" name="uploadFile" id="mainImage" >
			</div>
	
			<div id="previewContainer" style="width: 30%;"> </div>
		</div>
	
		<br>	
		<div align="center">
			<c:if test="${type eq 'write'}"><a href="#this" class="btn" id="write" onClick="fn_chk()">작성하기</a></c:if>
			<c:if test="${type eq 'modify'}"><a href="#this" class="btn" id="update" onClick="fn_chk()">수정하기</a></c:if>
			<a href="/goodsDetail/${gno }" class="btn">목록으로</a>
		</div>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	</form>

</div>
<br><br><br>
<!-- commandForm  -->
<form id="commonForm" name="commonForm"></form>

<script type="text/javascript">
function addOption(){
	
	const input = $("#option");
	const inputVal = input.val();
	const option_list = $("#option_list");

	option_list.text(option_list.text() + inputVal + "\n");
	input.val("");
}

$(function(){
	CKEDITOR.replace('content',{
        width:'120%',
        height:'400px',
		filebrowserUploadUrl: "<c:url value="/fileupload.do?"/>${_csrf.parameterName}=${_csrf.token}"
	});
});

	var gfv_count = 1;

$(document).ready(function() {

	$("#write").on("click", function(e){ //작성하기 버튼
		e.preventDefault();
		fn_insertBoard();
	});

	$("#update").on("click", function(e){ //수정하기 버튼
		e.preventDefault();
		fn_updateGoods();	
	});

	const mainImageInput = document.querySelector("#mainImage");
	const previewContainer = document.getElementById("previewContainer");
	
	
	mainImageInput.addEventListener("change", (event) => {
        const file = event.target.files[0];
        
        if (file) {
            // FileReader 인스턴스 생성
            const reader = new FileReader();
			alert("성공");
            // 파일 읽기 성공 시 미리보기 생성
            reader.onload = (e) => {
                const imagePreview = document.createElement("img");
                alert("성공");
                imagePreview.src = e.target.result;
                imagePreview.style.maxWidth = "200px"; // 미리보기 이미지 크기 제한 (선택사항)
                previewContainer.innerHTML = ""; // 기존 미리보기 제거
                previewContainer.appendChild(imagePreview);
            };

            // 파일 읽기 시작
            reader.readAsDataURL(file);
        }
    });		
});

function fn_updateGoods(){
	var comSubmit = new ComSubmit("frm");
	comSubmit.setUrl("<c:url value='/editclaim.do?glno=${claim.glno}' />");
	let editorContent=CKEDITOR.instances.content.getData();
	let convertContent = editorContent.replace(/(<([^>]+)>)/ig, "");
	comSubmit.submit();
}

function fn_insertBoard() { // 유효성체크

	var comSubmit = new ComSubmit("frm"); // 객체생성
	comSubmit.setUrl("<c:url value='/regclaim.do' />"); // url설정
	
	// 게시글 내용 필요
 	let editorContent=CKEDITOR.instances.content.getData();
    if(editorContent =='' 
            || editorContent.length ==0){
        alert("내용을 입력해주세요.");
        $("#content").focus();
        return false;
    }
    
    let convertContent = editorContent.replace(/(<([^>]+)>)/ig, "");
    
    let result = confirm("문의 사항을 작성하시겠습니까?");
    
    if(result){
    	alert("해당 글이 작성되었습니다.")
    } else {
    	return false;
    }
    
	comSubmit.submit();
}

function fn_chk() {
	
	
	var obj = $("[name=PICK]");
	var chkArray = new Array(); //배열 선언

	$('input:checkbox[name=PICK]:checked').each(function() { //체크된 값을 가져옴
		chkArray.push(this.value);
	});
	$('#GOODS_PICK').val(chkArray);

	//alert($('#GOODS_PICK').val());

	
	var obj1 = $("[name=SIZE]");
	var chkArray1 = new Array(); //배열 선언

	$('input:checkbox[name=SIZE]:checked').each(function() { //체크된 값을 가져옴
		chkArray1.push(this.value);
	});
	$('#GOODS_ATT_SIZE').val(chkArray1);

	//alert($('#GOODS_ATT_SIZE').val());
		
}

</script>

	<footer class="bg3 p-t-75 p-b-32">
		<div class="container">
			<div class="row">
				<div class="col-sm-6 col-lg-3 p-b-50">
					<h4 class="stext-301 cl0 p-b-30">
						Categories
					</h4>

					<ul>
						<li class="p-b-10">
							<a href="#" class="stext-107 cl7 hov-cl1 trans-04">
								Women
							</a>
						</li>

						<li class="p-b-10">
							<a href="#" class="stext-107 cl7 hov-cl1 trans-04">
								Men
							</a>
						</li>

						<li class="p-b-10">
							<a href="#" class="stext-107 cl7 hov-cl1 trans-04">
								Shoes
							</a>
						</li>

						<li class="p-b-10">
							<a href="#" class="stext-107 cl7 hov-cl1 trans-04">
								Watches
							</a>
						</li>
					</ul>
				</div>

				<div class="col-sm-6 col-lg-3 p-b-50">
					<h4 class="stext-301 cl0 p-b-30">
						Help
					</h4>

					<ul>
						<li class="p-b-10">
							<a href="#" class="stext-107 cl7 hov-cl1 trans-04">
								Track Order
							</a>
						</li>

						<li class="p-b-10">
							<a href="#" class="stext-107 cl7 hov-cl1 trans-04">
								Returns 
							</a>
						</li>

						<li class="p-b-10">
							<a href="#" class="stext-107 cl7 hov-cl1 trans-04">
								Shipping
							</a>
						</li>

						<li class="p-b-10">
							<a href="#" class="stext-107 cl7 hov-cl1 trans-04">
								FAQs
							</a>
						</li>
					</ul>
				</div>

				<div class="col-sm-6 col-lg-3 p-b-50">
					<h4 class="stext-301 cl0 p-b-30">
						GET IN TOUCH
					</h4>

					<p class="stext-107 cl7 size-201">
						Any questions? Let us know in store at 8th floor, 379 Hudson St, New York, NY 10018 or call us on (+1) 96 716 6879
					</p>

					<div class="p-t-27">
						<a href="#" class="fs-18 cl7 hov-cl1 trans-04 m-r-16">
							<i class="fa fa-facebook"></i>
						</a>

						<a href="#" class="fs-18 cl7 hov-cl1 trans-04 m-r-16">
							<i class="fa fa-instagram"></i>
						</a>

						<a href="#" class="fs-18 cl7 hov-cl1 trans-04 m-r-16">
							<i class="fa fa-pinterest-p"></i>
						</a>
					</div>
				</div>

				<div class="col-sm-6 col-lg-3 p-b-50">
					<h4 class="stext-301 cl0 p-b-30">
						Newsletter
					</h4>

					<form>
						<div class="wrap-input1 w-full p-b-4">
							<input class="input1 bg-none plh1 stext-107 cl7" type="text" name="email" placeholder="email@example.com">
							<div class="focus-input1 trans-04"></div>
						</div>

						<div class="p-t-18">
							<button class="flex-c-m stext-101 cl0 size-103 bg1 bor1 hov-btn2 p-lr-15 trans-04">
								Subscribe
							</button>
						</div>
					</form>
				</div>
			</div>

			<div class="p-t-40">
				<div class="flex-c-m flex-w p-b-18">
					<a href="#" class="m-all-1">
						<img src="/resources/images/icons/icon-pay-01.png" alt="ICON-PAY">
					</a>

					<a href="#" class="m-all-1">
						<img src="/resources/images/icons/icon-pay-02.png" alt="ICON-PAY">
					</a>

					<a href="#" class="m-all-1">
						<img src="/resources/images/icons/icon-pay-03.png" alt="ICON-PAY">
					</a>

					<a href="#" class="m-all-1">
						<img src="/resources/images/icons/icon-pay-04.png" alt="ICON-PAY">
					</a>

					<a href="#" class="m-all-1">
						<img src="/resources/images/icons/icon-pay-05.png" alt="ICON-PAY">
					</a>
				</div>

				<p class="stext-107 cl6 txt-center">
					<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | Made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a> &amp; distributed by <a href="https://themewagon.com" target="_blank">ThemeWagon</a>
<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->

				</p>
			</div>
		</div>
	</footer>
</body>
</html>