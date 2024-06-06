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
    margin-top: 30px;
}

.id_wrap, .pw_wrap {
    margin-bottom: 10px;
}

span {
    font-size: 20px;
}

.wrap {
    display: flex;
    flex-direction: column;
    align-items: center;
}

img {
    width: 220px;
    height: 220px;
}

.logo_wrap {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100%;
}

.login_button_wrap {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 500px;
}

.login_button, .join_button {
    margin-right: 10px;
    margin-top: 10px;
}

button:last-child {
    margin-right: 0;
}
</style>
<body>

<div class="wrapper">
    <div class="common-container">
        <div class="wrap">
            <!-- spring security를 사용하는 경우 action을 /login으로 -->
            <form id="login_form" action="/login" method="post">
                <div class="login_wrap">
                    <div class="logo_wrap">
                        <img alt="" src="/resources/images/캠핑가로고.PNG">
                    </div>
                    <div class="id_wrap">
                        <div class="id_input_box">
                            <!-- spring security를 사용하는 경우 아이디의 name을 username으로 -->
                            <input class="id_input form-control" name="username" placeholder="아이디">
                        </div>
                    </div>
                    <div class="pw_wrap">
                        <div class="pw_input_box">
                            <!-- spring security를 사용하는 경우 비밀번호의 name을 password로 -->
                            <input class="pw_input form-control" type="password" autocomplete="current-password" name="password" placeholder="비밀번호">
                        </div>
                    </div>
                    
                    <div class="login_button_wrap">
                        <button type="submit" class="login_button btn btn-primary">로그인</button>
                        <button type="button" class="join_button btn btn-primary" onclick="location.href='/member/join'">회원가입</button>
                    </div>
                    <div class="login_warn"><c:out value="${error}" /></div>
                    <div class="logout"><c:out value="${logout}" /></div>
                </div>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            </form>
        </div>
    </div>
</div>

</body>
</html>
