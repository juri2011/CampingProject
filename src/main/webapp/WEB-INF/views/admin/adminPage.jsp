<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>관리자 페이지</title>
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
        margin-bottom: 20px;
        text-align: center; /* 가운데 정렬 */
    }

    .menu {
        display: inline-block;
        width: 200px;
        height: 200px;
        padding: 10px 20px;
        margin: 0 40px; /* 간격 설정 */
        font-weight: 800;
        font-size: 18px;
        background-color: #005555;
        color: #000;
        text-decoration: none;
        border-radius: 5px;
        transition: background-color 0.3s;
        vertical-align: top; /* 버튼을 상단으로 정렬 */
    }

    .menu:hover {
        background-color: #0056b3;
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
        <h1>관리자 페이지</h1>

        <hr>
        <p>
            <a href="/admin/itemManager" class="menu"><img alt="" src="/resources/images/상품.png">상품관리</a>
            <a href="/admin/orderManager" class="menu"><img alt="" src="/resources/images/주문.png">주문관리</a>
            <a href="/admin/memberManager" class="menu"><img alt="" src="/resources/images/회원.png">회원관리</a>
        </p>
    </div>
</div>

</body>
</html>
