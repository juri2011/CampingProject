<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<table class="w3-table-all" id="1">
	<tr>
		<td>상품번호</td>
		<td>${goods.gno }</td>
	</tr>
	<tr>
		<td>분류</td>
		<td>${goods.category }</td>
	</tr>
	<tr>
		<td>상품명</td>
		<td>${goods.pname }</td>
	</tr>
	<tr>
		<td>최근입고날짜</td>
		<td>
			<fmt:formatDate pattern="yy/MM/dd HH:mm"
				value="${answer.updatedate}" />
		</td>
	</tr>
	<tr>
		<td>재고상태</td>
		<td>${goods.status }</td>
	</tr>
	<tr>
		<td>재고량</td>
		<td>${goods.stock }</td>
	</tr>
</table>