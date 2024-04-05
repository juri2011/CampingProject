<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>결제 내역</title>
  <style>
    body {
      font-family: sans-serif;
      margin: 0;
      padding: 0;
    }

    .container {
      width: 100%;
      max-width: 1200px;
      margin: 0 auto;
    }

    .table-wrapper {
      margin-top: 20px;
      border: 1px solid #ddd;
    }

    .table {
      width: 100%;
      border-collapse: collapse;
    }

    th, td {
      padding: 10px;
      border: 1px solid #ddd;
    }

    th {
      text-align: center;
    }

    .order-date {
      text-align: right;
    }

    .status {
      text-align: center;
    }

    .product-name {
      text-align: left;
    }

    .price {
      text-align: right;
    }

    .shipping {
      text-align: center;
    }

    .total-price {
      font-weight: bold;
      text-align: right;
    }
  </style>
</head>
<body>
  <div class="container">
    <h2>결제 내역</h2>

    <div class="table-wrapper">
      <table class="table">
        <thead>
          <tr>
          	<th>이미지</th>
            <th>주문일</th>
            <th>상품명</th>
            <th>수량</th>
            <th>가격</th>
            <th>배송 상태</th>
          </tr>
        </thead>
        <tbody>
          <tr>
          	<td><img src="" alt="이미지" /></td>
            <td class="order-date">2024년 4월 5일</td>
            <td class="product-name">상품명 1</td>
            <td>1</td>
            <td class="price">10,000원</td>
            <td class="shipping">배송 준비</td>
          </tr>
          <tr>
         	 <td><img src="" alt="이미지" /></td>
            <td class="order-date">2024년 4월 5일</td>
            <td class="product-name">상품명 2</td>
            <td>2</td>
            <td class="price">20,000원</td>
            <td class="shipping">배송 중</td>
          </tr>
          <tr>
         	 <td><img src="" alt="이미지" /></td>
            <td class="order-date">2024년 4월 5일</td>
            <td class="product-name">상품명 3</td>
            <td>3</td>
            <td class="price">30,000원</td>
            <td class="shipping">배송 완료</td>
          </tr>
        </tbody>
        <tfoot>
          <tr>
            <td colspan="6" class="total-price">총 결제 금액: 60,000원</td>
          </tr>
        </tfoot>
      </table>
    </div>
  </div>
</body>
</html>