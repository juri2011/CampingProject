<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>

/* 로그인 실패시 경고글 */
.login_warn {
	color: red;
}
</style>
<body>

	<div class="wrapper">

		<div class="wrap">
			<form id="login_form" method="post">
				<div class="logo_wrap">
					<span>캠핑가</span>
				</div>
				<div class="login_wrap">
					<div class="id_wrap">
						<div class="id_input_box">
							<input class="id_input" name="mem_id" placeholder="아이디">
						</div>
					</div>
					<div class="pw_wrap">
						<div class="pw_input_box">
							<input class="pw_iput" type="password" autocomplete="current-password" name="pwd" placeholder="비밀번호">
						</div>
					</div>

					<c:if test="${result == 0 }">
						<div class="login_warn">사용자 ID 또는 비밀번호를 잘못 입력하셨습니다.</div>
					</c:if>

					<div class="login_button_wrap">
						<input type="button" class="login_button" value="로그인">
					</div>
				</div>
			</form>

		</div>

	</div>

	<script>
		const loginButton = document.querySelector(".login_button");

		loginButton.addEventListener("click", function() {

			//alert("로그인 버튼 작동");

			//로그인 폼 요소를 가져옵니다.
			const loginForm = document.getElementById("login_form");

			//로그인 폼의 action 속성을 설정합니다.
			loginForm.setAttribute("action", "/member/login");

			//로그인 폼을 서버에 제출합니다.
			loginForm.submit();

		});
	</script>

</body>
</html>