<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<head>
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<script src="../resources/ckeditor/ckeditor.js"></script>


</head>

<!--  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>-->

<style>

@CHARSET "UTF-8";

a:link, a:visited {
	text-decoration: none;
	color: #656565;
}

.board_list {
	width: 50%;
	border-top: 2px solid #252525;
	border-bottom: 1px solid #ccc;
	margin: auto;
}

.board_list thead th:first-child {
	background-image: none
}

.board_list thead th {
	border-bottom: 1px solid #ccc;
	padding: 12px 0 13px 0;
	color: #3b3a3a;
	vertical-align: middle
}

.board_list tbody td {
	border-top: 1px solid #ccc;
	padding: 10px 0;
	text-align: center;
	vertical-align: middle
}

.board_list tbody tr:first-child td {
	border: none
}

.board_list tbody td.title {
	text-align: left;
	padding-left: 20px
}

.board_list tbody td a {
	display: inline-block
}

.board_view {
	width: 50%;
	border-top: 2px solid #252525;
	border-bottom: 1px solid #ccc;
	margin: auto;
	
}

.board_view tbody th {
	text-align: left;
	background: #f7f7f7;
	color: #3b3a3a
}

.board_view tbody th.list_tit {
	font-size: 13px;
	color: #000;
	letter-spacing: 0.1px
}

.board_view tbody .no_line_b th, .board_view tbody .no_line_b td {
	border-bottom: none
}

.board_view tbody th, .board_view tbody td {
	padding: 15px 0 16px 16px;
	border-bottom: 1px solid #ccc
}

.board_view tbody td.view_text {
	border-top: 1px solid #ccc;
	border-bottom: 1px solid #ccc;
	padding: 45px 18px 45px 18px
}

.board_view tbody th.th_file {
	padding: 0 0 0 15px;
	vertical-align: middle
}

.pad_5 {
	padding: 5px;
}

.wdp_90 {
	width: 90%
}

.btn {
	border-radius: 3px;
	padding: 5px 11px;
	color: #fff !important;
	display: inline-block;
	background-color: #6b9ab8;
	border: 1px solid #56819d;
	vertical-align: middle
}

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

#frm fieldset{
    display: inline-block; /* 하위 별점 이미지들이 있는 영역만 자리를 차지함.*/
    direction: rtl; /* 이모지 순서 반전 */
    border: 0; /* 필드셋 테두리 제거 */
}
#frm fieldset legend{
    text-align: left;
}
#frm input[type=radio]{
    display: none; /* 라디오박스 감춤 */
}
#frm label{
    display: inline-block; /* 하위 별점 이미지들이 있는 영역만 자리를 차지함.*/

    font-size: 3em; /* 이모지 크기 */
    color: transparent; /* 기존 이모지 컬러 제거 */
    text-shadow: 0 0 0 #f0f0f0; /* 새 이모지 색상 부여 */
}
#frm label:hover{
    text-shadow: 0 0 0 #a00; /* 마우스 호버 */
}
#frm label:hover ~ label{
    text-shadow: 0 0 0 #a00; /* 마우스 호버 뒤에오는 이모지들 */
}
#frm input[type=radio]:checked ~ label{
    text-shadow: 0 0 0 #a00; /* 마우스 클릭 체크 */
}
</style>
<body class="animsition">
	<br>
	<br>
	<div align="center">
		<h2>리뷰 작성</h2>
	</div>

	<br>
	<br>
	<div align="center" class="board_list">
		<form name="frm" id="frm" action="/review/save.do" method="post">
			<input type="hidden" name="mem_id" value=""> <!-- 로그인 값 auth -->
			<input type="hidden" name="goods_no" value="">
			
			<table width="100%" align="center" border="0">
				<tr>
					<th>별점을 선택해주세요</th>
					<td>
					    <fieldset>
					        <input type="radio" name="score" value="5" id="rate1"><label for="rate1">⭐</label>
					        <input type="radio" name="score" value="4" id="rate2"><label for="rate2">⭐</label>
					        <input type="radio" name="score" value="3" id="rate3"><label for="rate3">⭐</label>
					        <input type="radio" name="score" value="2" id="rate4"><label for="rate4">⭐</label>
					        <input type="radio" name="score" value="1" id="rate5"><label for="rate5">⭐</label>
					    </fieldset>
					</td>

				</tr>
				<tr>
					<th>상품내용</th>
					<td>
						<textarea id="content" name="content">
						</textarea>
					</td>
				</tr>
			</table>

			<br>
			<div align="center">
				<a href="#this" class="btn" id="write">작성하기</a>
				<!-- <a href="#this" class="btn" id="update" onClick="fn_chk()">수정하기</a> -->
				<a href="#this" class="btn" id="list">목록으로</a>
			</div>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />			
			<input type="hidden" name="goodsNo" value="${gno}">
		</form>

	</div>
	<!-- commandForm  -->
	<form id="commonForm" name="commonForm"></form>

	<script type="text/javascript">
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");

		$(function() {
			CKEDITOR
					.replace(
							'content',
							{
								width : '100%',
								height : '400px',
								filebrowserUploadUrl : "<c:url value="/fileReviewUpload.do?"/>${_csrf.parameterName}=${_csrf.token}"

							});
		});

		var gfv_count = 1;

		// $(document).ready(function() 함수 또는 코드가 호출 또는 실행되는 시점을
		// 스케쥴링할 수 있게 해준다. 그 시점은 바로 문서객체모델이라고 하는 DOM
		// (Document Object Model)이 모두 로딩되었을 때인데 이렇게
		// $(document).ready(function() 안에 위치한 코드를 DOM이 모두 준비된 이후에 
		// 실행되게끔 해준다.
		$(document).ready(function() {

			$("#list").on("click", function(e) {//목록으로 버튼
				//html 에서 a 태그나 submit 태그는 고유의 동작이 있다. 
				//페이지를 이동시킨다거나 form 안에 있는 input 등을 전송한다던가 
				//그러한 동작이 있는데 e.preventDefault 는 그 동작을 중단시킨다.
				e.preventDefault();
				fn_openDetailList();
			});

			$("#write").on("click", function(e) { //작성하기 버튼
				e.preventDefault();
				fn_insertReview();
			});

		});

		function fn_insertReview() {

			var form = document.frm;
			form.submit();
/* 			var form = document.createElement("form");
			form.setAttribute("method", "post");
			form.setAttribute("action", "/review/save.do");
		    var parentNOInput = document.createElement("input");

		    form.appendChild(parentNOInput);
		 	document.body.appendChild(form);
		    
		 	console.log(form);
		 	
			form.submit();
 */

		}
	</script>
</body>