<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
<style>
/* 기본 스타일 설정 */
body {
    font-family: Arial, sans-serif;
    background-color: #f5f5f5;
    margin: 0;
    padding: 0;
}

/* 레이아웃 설정 */
#wrapper {
    width: 100%;
    max-width: 1200px;
    margin: 50px auto;
    padding: 20px;
    background-color: #fff;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    border-radius: 8px;
}

h2{
	margin-left:18px;
}

.common-container {
    text-align: left;
}

.common-container h2 {
    margin-bottom: 20px;
    font-size: 24px;
    color: #333;
}


.common-container ul li {
    margin: 10px 0;
}

.common-container ul li a {
    display: inline-block;
    padding: 10px 20px;
    font-size: 18px;
    transition: background-color 0.3s;
}

.common-container ul li a:hover {
    text-decoration:underline;
}
</style>
</head>
<body>

<div id="wrapper">
    <div class="common-container">
        <h2>회원정보 관리</h2>

        <ul>
            <li><a href="/member/memberDetailPage">회원정보 수정</a></li>
            <li><a href="/member/changePassword">비밀번호 변경</a></li>
        </ul>
    </div>
</div>

</body>
</html>
