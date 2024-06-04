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
.login_warn{
    margin-top: 30px;
}
</style>
<body>

	<div class="wrapper">

		<div class="common-container">
			<!-- spring security를 사용하는 경우 action을 /login으로 -->
			<form id="login_form" action="/login" method="post">
				<div class="logo_wrap">
					<span>캠핑가</span>
				</div>
				<div class="login_wrap">
					<div class="id_wrap">
						<div class="id_input_box">
							<!-- spring security를 사용하는 경우 아이디의 name을 username으로 -->
							<input class="id_input" name="username" placeholder="아이디">
						</div>
					</div>
					<div class="pw_wrap">
						<div class="pw_input_box">
							<!-- spring security를 사용하는 경우 비밀번호의 name을 password로 -->
							<input class="pw_iput" type="password" autocomplete="current-password" name="password" placeholder="비밀번호">
						</div>
					</div>
					
					<div class="login_button_wrap">
						<input type="submit" class="login_button" value="로그인">
					</div>
					<div class="login_warn"><c:out value="${error}" /></div>
					<div class="logout"><c:out value="${logout}" /></div>
				</div>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			</form>

		</div>

	</div>


</body>
</html>