<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상품 보여주기</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div class="container">
  <h2>상품 리스트</h2>
  <p>여기다 뭘 쓸수도 있음</p>
  <c:if test="${!empty goodsList}">
    <table class="table">
    <thead>
      <tr>
        <th>썸네일</th>
        <th>이름</th>
        <th>카테고리</th>
        <th>가격</th>
        <th>수량</th>
        <th>등록날짜</th>
      </tr>
    </thead>
    <tbody>
    <c:forEach var="good" items="${goodsList}">
      <tr>
        <td><img src="upload/main/${good.simagepath}"></img></td>
        <td>${good.pname}</td>
        <td>${good.category}</td>
        <td>${good.sellPrice}</td>
        <td>${good.stock}</td>
        <td>${good.regidate}</td>
      </tr>
    </c:forEach>
    </tbody>
  </table>
  </c:if>        

</div>
</body>
</html>