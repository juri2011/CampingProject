<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f4f4f4;
}

#wrapper {
    width: 1280px;
    margin: 10px auto;
    background-color: #fff;
    border: 1px solid #ddd;
    border-radius: 5px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.common-container {
    padding: 30px;
}

h1 {
    font-size: 28px;
    margin-bottom: 30px;
    color: #333;
}

p {
    text-align: center;
}

a.menu {
    display: inline-block;
    width: 200px;
    height: 200px;
    padding: 10px 20px;
    margin: 40px; /* 간격 설정 */
    background-color: #005555;
    color: #fff;
    font-weight: 800;
    font-size: 18px;
    text-decoration: none;
    border-radius: 5px;
    transition: background-color 0.3s;
    box-sizing: border-box; /* 내부 패딩, 테두리를 포함하여 요소의 전체 크기를 지정합니다. */
    vertical-align: top; /* 내부 패딩, 테두리를 포함하여 요소의 전체 크기를 지정합니다. */
}

a.menu:hover {
    background-color: #004040;
}

img {
    width: 100%;
    height: 90%;
}
</style>
</head>
<body>
<div id="wrapper">
    <div class="common-container">
        <h1>마이 페이지</h1>

        <hr>
        <p>
            <a href="/member/toCartList" class="menu"><img alt="" src="/resources/images/장바구니.png">장바구니</a>
            <a href="/member/toOrderList" class="menu"><img alt="" src="/resources/images/주문관리.png">주문/결제내역 확인</a>
            <a href="/member/memberUpdate" class="menu"><img alt="" src="/resources/images/회원관리.png">회원정보 관리</a>
        </p>
    </div>
</div>

</body>
</html>
