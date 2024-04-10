<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원관리 페이지</title>
</head>
<style>
h2 {
	text-align: center;
}

table {
	width: 100%;
}

td {
	text-align: center;
}

#outter {
	display: block;
	width: 60%;
	margin: auto;
}

a {
	text-decoration: none;
}
</style>

<body>
	<h2>회원관리</h2>

	<div id="outter">
		<div style="float: right;">
			<select id="cntPerPage" name="sel" onchange="selChange()">
				<option value="5"
					<c:if test="${paging.cntPerPage == 5}">selected</c:if>>5줄
					보기</option>
				<option value="10"
					<c:if test="${paging.cntPerPage == 10}">selected</c:if>>10줄
					보기</option>
				<option value="15"
					<c:if test="${paging.cntPerPage == 15}">selected</c:if>>15줄
					보기</option>
				<option value="20"
					<c:if test="${paging.cntPerPage == 20}">selected</c:if>>20줄
					보기</option>
			</select>
		</div>
		<!-- 옵션선택 끝 -->
		<table border="1">
			<tr>
				<th>아이디</th>
				<th>이름</th>
				<th>이메일</th>
				<th>전화번호</th>
				<th>가입일</th>
				<th>회원상태</th>
			</tr>
			<c:forEach items="${viewAll}" var="member">
				<tr>

					<td>${member.mem_id}</td>
					<td><a href="#">${member.name}</a></td>
					<td>${member.email}</td>
					<td>${member.phone}</td>
					<td><fmt:formatDate value="${member.regdate}"
							pattern="yyyy.MM.dd" /></td>
					<c:choose>
						<c:when test="${member.mem_status == 1}">
							<td>정상</td>
						</c:when>
						<c:when test="${member.mem_status == 2}">
							<td>탈퇴</td>
						</c:when>
						<c:otherwise>
						</c:otherwise>
					</c:choose>
				</tr>
			</c:forEach>
		</table>

		<div style="display: block; text-align: center;">
			<c:if test="${paging.startPage != 1}">
				<a
					href="/admin/memberManager?nowPage=${paging.startPage - 1}&cntPerPage=${paging.cntPerPage}">&lt;</a>
			</c:if>
			<c:forEach begin="${paging.startPage}" end="${paging.endPage}"
				var="p">
				<c:choose>
					<c:when test="${p == paging.nowPage}">
						<b>${p}</b>
					</c:when>
					<c:otherwise>
						<a
							href="/admin/memberManager?nowPage=${p}&cntPerPage=${paging.cntPerPage}">${p}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${paging.endPage != paging.lastPage}">
				<a
					href="/admin/memberManager?nowPage=${paging.endPage + 1}&cntPerPage=${paging.cntPerPage}">&gt;</a>
			</c:if>
		</div>
	</div>
	<script>
		function selChange() {
			var sel = document.getElementById('cntPerPage').value;
			location.href = "/admin/memberManager?nowPage=1&cntPerPage=" + sel; // 현재 페이지를 1페이지로 리셋
		}
	</script>

</body>
</html>