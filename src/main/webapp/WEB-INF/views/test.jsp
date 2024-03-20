<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Document</title>
</head>
<style>
#myform fieldset{
    display: inline-block;
    direction: rtl;
    border:0;
}
#myform fieldset legend{
    text-align: right;
}
#myform input[type=radio]{
    display: none;
}
#myform label{
    font-size: 3em;
    color: transparent;
    text-shadow: 0 0 0 #f0f0f0;
}
#myform label:hover{
    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
#myform label:hover ~ label{
    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
#myform input[type=radio]:checked ~ label{
    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
#reviewContents {
    width: 100%;
    height: 150px;
    padding: 10px;
    box-sizing: border-box;
    border: solid 1.5px #D3D3D3;
    border-radius: 5px;
    font-size: 16px;
    resize: none;
}
</style>
<body>
	<form class="mb-3" name="myform" id="myform" method="post">
		<!-- 제목 -->
		<fieldset>
			<span class="text-bold">별점을 선택해주세요</span>
			<input type="radio" name="score" value="5" id="rate1"><label
				for="rate1">★</label>
			<input type="radio" name="score" value="4" id="rate2"><label
				for="rate2">★</label>
			<input type="radio" name="score" value="3" id="rate3"><label
				for="rate3">★</label>
			<input type="radio" name="score" value="2" id="rate4"><label
				for="rate4">★</label>
			<input type="radio" name="score" value="1" id="rate5"><label
				for="rate5">★</label>
		</fieldset>
		<input type="hidden" name="mem_id" value=""> <!-- 로그인 값 auth -->
		<input type="hidden" name="goods_no" value="">
		<div>
			<textarea class="col-auto form-control" type="text" id="reviewContents" name="content"
					  placeholder="좋은 수강평을 남겨주시면 Cocolo에 큰 힘이 됩니다! 포인트 5000p도 지급!!"></textarea>
		</div>
		<input type="hidden" name="csrfToken" id="csrfToken" value="">
		<button type="submit">1</button>
	</form>	
</body>
<script>
$(document).ready(function () {
	let csrf;
	let csrf_header;

	$("#myform").submit(function(event){
		event.preventDefault();

		let data = $(this).serialize();
		let csrfToken = $("#csrfToken").val();

		$.ajax({
			type:"post",
			url: "",
			data: "data",
			beforeSend: function(xhr) {
				xhr.setRequestHeader("X-CSRF-Token", csrfToken);
			},
			success: function (response) {
				console.log("응답: "+response)
			},
			error: function (xhr, status, error) {
				console.log(error)
			}
		})
	})

})
</script>
</html>