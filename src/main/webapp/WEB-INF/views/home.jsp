<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<div class="product-list">
    <h2>body</h2>
    <!-- 상품 정보를 담고 있는 items 컬렉션을 순회하면서 각 상품 정보를 표시 -->
    <!-- items 속성은 순회할 객체를 지정, var는 반복요소에 참조할 변수 이름 -->
<%--     <c:forEach items="${items}" var="item">
        <div class="product">
            <!-- (임의)상품 이미지와 이름을 클릭하면 상품 상세 페이지로 이동하도록 링크 설정 -->
            <a href="${pageContext.request.contextPath}/goodsDetail?item_no=${item.item_no}">
                <img src="${pageContext.request.contextPath}/resources/images/${item.item_no}.jpg" alt="${item.item_name}">
                <h3>${item.item_name}</h3>
            </a>
            <p>카테고리: ${item.category}</p>
            <!-- 상품 상태를 표시. 상태값에 따라 '판매중' 혹은 '품절'로 표시 -->
            <p> 
                <c:choose>
                    <c:when test="${item.status == '1'}">판매중</c:when>
                    <c:otherwise>품절</c:otherwise>
                </c:choose>
            </p>
        </div>
    </c:forEach> --%>
</div>
