<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/member/join.css">
</head>
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
<body>

<div class="wrapper">
	<form id="join_form" method="post">
	<div class="wrap">
			<div class="subjecet">
				<span>회원가입</span>
			</div>
			<div class="id_wrap">
				<div class="id_name">아이디</div>
				<div class="id_input_box">
					<input class="id_input" name="mem_id">
				</div>
			</div>
			<div class="pw_wrap">
				<div class="pw_name">비밀번호</div>
				<div class="pw_input_box">
					<input class="pw_input" name="pwd">
				</div>
			</div>
			<div class="pwck_wrap">
				<div class="pwck_name">비밀번호 확인</div>
				<div class="pwck_input_box">
					<input class="pwck_input" name="pwd">
				</div>
			</div>
			<div class="user_wrap">
				<div class="user_name">이름</div>
				<div class="user_input_box">
					<input class="user_input" name="name">
				</div>
			</div>
			<div class="birth_wrap">
				<div class="birth_name">생년월일(예시:2005-08-20)</div>
				<div class="birth_input_box">
					<input class="birth_input" name="birth">
				</div>
			</div>
			<div class="phone_wrap">
				<div class="phone_name">전화번호(번호 사이에"-"필수)</div>
				<div class="phone_input_box">
					<input class="phone_input" name="phone">
				</div>
			</div>
				<div class="gender_wrap">
				<div class="gender_name">성별(버튼 선택으로 바꿀예정)</div>
				<div class="gender_input_box">
					<input class="gender_input" name="gender">
				</div>
			</div>
			<div class="mail_wrap">
				<div class="mail_name">이메일</div> 
				<div class="mail_input_box">
					<input class="mail_input" name="email">
				</div>
				
			</div>
			<div class="address_wrap">
				<div class="address_name">주소(API 들어갈 예정)</div>
				<div class="address_input_1_wrap">
					<div class="address_input_1_box">
						<input class="address_input_1" name="userAddr">
					</div>
					<!-- <div class="address_button">
						<span>주소 찾기</span>
					</div> -->
					<div class="clearfix"></div>
				</div>
				<div class ="address_input_2_wrap">
					<div class="address_input_2_box">
						<input class="address_input_2" name="userDaddr" placeholder="상세주소">
					</div>
				</div>
			
			</div>
			<div class="join_button_wrap">
				<input type="button" class="join_button" value="가입하기">
			</div>
		</div>
	</form>
</div>

<script>

$(document).ready(function(){
	//회원가입 버튼(회원가입 기능 작동)
	$(".join_button").click(function(){
		$("#join_form").attr("action", "/member/join");
		$("#join_form").submit();
	});
});

</script>

</body>
</html>