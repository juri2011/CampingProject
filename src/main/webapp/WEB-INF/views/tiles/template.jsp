<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="_csrf" content="${_csrf.token}"/>
	<meta name="_csrf_header" content="${_csrf.headerName}"/>
    <title>CampingGa</title>
    <!-- 공통 CSS 파일을 여기에 포함 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <!-- jQuery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
    <div id="container">
        <!-- 헤더 영역: tiles.xml에서 정의한 헤더 파일을 삽입. -->
        <header>
            <tiles:insertAttribute name="header" />
        </header>
        
        <!-- 본문 영역: 각 페이지에서 정의한 body 속성의 내용 삽입. -->
        <div id="main-content">
            <tiles:insertAttribute name="body" />
        </div>
        
        <!-- 푸터 영역: tiles.xml에서 정의한 푸터 파일 삽입 -->
        <footer>
            <tiles:insertAttribute name="footer" />
        </footer>
    </div>
</body>
</html>

