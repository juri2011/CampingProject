<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<table class="w3-table-all" id="1">
	<c:choose>
		<c:when test="${answer != null || claim == null }">
			<tr>
				<td>번호</td>
				<td>${answer.anscno }</td>
			</tr>
			<tr>
				<td>제목</td>
				<td>${answer.title }</td>
			</tr>
			<tr>
				<td>아이디</td>
				<td>${gclaim.id }</td>
			</tr>
			<tr>
				<td>날짜</td>
				<td><fmt:formatDate pattern="yy/MM/dd HH:mm"
						value="${answer.regidate}" /></td>
			</tr>
			<tr>
				<td>절차단계</td>
				<td>${answer.status }</td>
			</tr>
			<tr>
				<td>상품id</td>
				<td>${gclaim.gno }</td>
			</tr>
			<tr class="fixed-height">
				<td>내용</td>
				<td>${answer.content }</td>
			</tr>
		</c:when>
		<c:when test="${claim != null || answer == null }">
			<tr>
				<td>고유번호</td>
				<td>${claim.glno }</td>
			</tr>
			<tr>
				<td>제목</td>
				<td></td>
			</tr>
			<tr>
				<td>고객ID</td>
				<td>${claim.id }</td>
			</tr>
			<tr>
				<td>날짜</td>
				<td><fmt:formatDate pattern="yy/MM/dd HH:mm"
						value="${claim.regidate}" /></td>
			</tr>
			<tr>
				<td>절차단계</td>
				<td>${claim.status }</td>
			</tr>
			<tr>
				<td>상품id</td>
				<td>${claim.gno }</td>
			</tr>
			<tr class="fixed-height">
				<td>내용</td>
				<td>${claim.content }</td>
			</tr>
		</c:when>
	</c:choose>
</table>