<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="org.springframework.security.core.Authentication" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.userdetails.UserDetails" %>
<%@ page import="org.springframework.security.core.GrantedAuthority" %>
<%@ page import="java.util.*" %>
<%
	Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	String id = auth.getName();
	request.setAttribute("userId", id);
	
	boolean hasRole = auth.getAuthorities().stream()
            .map(GrantedAuthority::getAuthority)
            .anyMatch(role -> role.equals("ROLE_ADMIN"));
	
	if(hasRole){
		request.setAttribute("role", "ROLE_ADMIN");
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />

<title>클레임 관리 게시판</title>
<style>
.w3-container {
	padding: 10px;
}

.w3-container:after, .w3-container:before, .w3-panel:after, .w3-panel:before,
	.w3-row:after, .w3-row:before, .w3-row-padding:after, .w3-row-padding:before,
	.w3-cell-row:before, .w3-cell-row:after, .w3-topnav:after, .w3-topnav:before,
	.w3-clear:after, .w3-clear:before, .w3-btn-group:before, .w3-btn-group:after,
	.w3-btn-bar:before, .w3-btn-bar:after, .w3-bar:before, .w3-bar:after {
	content: "";
	display: table;
	clear: both;
}

.w3-responsive {
	overflow-x: auto;
	margin: 0px 0px 0px 100px;
}

.w3-table, .w3-table-all {
	border-collapse: collapse;
	border-spacing: 0;
	width: 900px;
	display: table;
}

.w3-table-all {
	border: 1px solid #ccc;
	margin: 0 auto;
}

.w3-bordered tr, .w3-table-all tr {
	border-bottom: 1px solid #ddd;
}

.w3-table-all tr:nth-child(odd) {
	background-color: #fff;
}

.w3-table-all tr:nth-child(even) {
	background-color: #f1f1f1;
}

.w3-table td, .w3-table th, .w3-table-all td, .w3-table-all th {
	padding: 8px 8px;
	display: table-cell;
	text-align: left;
	vertical-align: top;
	border-left: 1px solid #ddd;
}

.w3-table-all tr.fixed-height {
	height: 400px;
}

.w3-table th:first-child, .w3-table td:first-child, .w3-table-all th:first-child,
	.w3-table-all td:first-child {
	padding-left: 16px;
	width: 10%;
}

.w3-center {
	text-align: center !important;
}

.w3-center .w3-bar {
	display: inline-block;
	width: auto;
}

.w3-bar-block .w3-center .w3-bar-item {
	text-align: center;
}

.w3-btn, .w3-btn-floating, .w3-dropnav a, .w3-btn-floating-large,
	.w3-btn-block, .w3-navbar a, .w3-navblock a, .w3-sidenav a,
	.w3-pagination li a, .w3-hoverable tbody tr, .w3-hoverable li,
	.w3-accordion-content a, .w3-dropdown-content a, .w3-dropdown-click:hover,
	.w3-dropdown-hover:hover, .w3-opennav, .w3-closenav, .w3-closebtn, *[class*="w3-hover-"]
	{
	-webkit-transition: background-color 0.25s, color 0.15s, box-shadow
		0.25s, opacity 0.25s, filter 0.25s, border 0.15s;
	transition: background-color 0.25s, color 0.15s, box-shadow 0.15s,
		opacity 0.25s, filter 0.25s, border 0.15s;
}

.a {
  position: relative;
  left: 200px;
}

.containerA{
	width: 500px;
	margin: 0 auto;
}

ul.tabsA{
	margin: 0px;
	padding: 0px;
	list-style: none;
}
ul.tabsA li{
	background: none;
	color: #222;
	display: inline-block;
	padding: 10px 15px;
	cursor: pointer;
}

ul.tabsA li.current{
	background: #ededed;
	color: #222;
}

.tab-content{
	display: none;
	background: #ededed;
	padding: 15px;
}

.tab-content.current{
	display: inherit;
}   

</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>

<script>
$(document).ready(function(){
	
	$('ul.tabsA li').click(function(){
		var tab_id = $(this).attr('data-tab');

		$('ul.tabsA li').removeClass('current');
		$('.tab-content').removeClass('current');

		$(this).addClass('current');
		$("#"+tab_id).addClass('current');
	})

})

</script>
</head>
<body>
<div class="w3-container">
<h2>상세 조회</h2>
	<div class="w3-responsive">
	    <div class="containerA">
	
	        <ul class="tabsA">
	            <li class="tab-link current" data-tab="tab-1">메뉴_하나</li>
	            <li class="tab-link" data-tab="tab-2">메뉴_둘</li>
	        </ul>
	    
	        <div id="tab-1" class="tab-content current">
	   			<jsp:include page="text.jsp"></jsp:include>
	        </div>
	        <div id="tab-2" class="tab-content">
	        	<jsp:include page="goodsinfo.jsp"></jsp:include>
	        </div>
	    
	    </div>
	
	</div>

<br><br>

    	<a class="a" href="/admin/claims">목록</a>
   	<c:choose>
   		<c:when test='${claim != null }'>
			<button type="button" class="btn btn-secondary btn-sm"
					onclick="fn_Review('/admin/answerToClaim/write',${claim.glno})">답변하기</button>
		</c:when>
		<c:when test='${claim == null }'>
			<button type="button" class="btn btn-secondary btn-sm"
					onclick="fn_Review2('/admin/answerToClaim/modify',${answer.anscno})">답변수정</button>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test='${role == "ROLE_ADMIN" }'>
			<c:if test="${answer != null }">
				<button type="button" class="btn btn-secondary btn-sm"
							onclick="fn_Review3('/admin/deleteAnswer',${answer.anscno})">삭제하기</button>
			</c:if>
			<c:if test="${answer == null }">
				<button type="button" class="btn btn-secondary btn-sm"
							onclick="fn_Review4('/admin/clearcase',${claim.glno })">삭제하기</button>
			</c:if>			
		</c:when>
		<c:when test='${role != "ROLE_ADMIN" }'>
		</c:when>
	</c:choose>
</div>
</body>
<script>
function fn_Review(url,data){
	var form = document.createElement("form");
	form.setAttribute("method", "get");
	form.setAttribute("action", url);
	var parentNOInput = document.createElement("input");
	parentNOInput.setAttribute("type","hidden");
	parentNOInput.setAttribute("value",data);
	parentNOInput.setAttribute("name","glno");
	
	form.appendChild(parentNOInput);
	document.body.appendChild(form);
	  
	console.log(form);
		
	form.submit();
}

function fn_Review2(url,data){
	var form = document.createElement("form");
	form.setAttribute("method", "get");
	form.setAttribute("action", url);
	var parentNOInput = document.createElement("input");
	parentNOInput.setAttribute("type","hidden");
	parentNOInput.setAttribute("value",data);
	parentNOInput.setAttribute("name","answer_no");
	
	form.appendChild(parentNOInput);
	document.body.appendChild(form);
	  
	console.log(form);
		
	form.submit();
}

function fn_Review3(url,data){
	var form = document.createElement("form");
	form.setAttribute("method", "post");
	form.setAttribute("action", url);
	
	var csrfInput = document.createElement("input");
	csrfInput.setAttribute("type", "hidden");
	csrfInput.setAttribute("name", "${_csrf.parameterName}"); // csrf 토큰을 보내는 필드 이름 (서버에서 사용하는 이름과 동일해야 합니다)
	csrfInput.setAttribute("value", "${_csrf.token}");
	form.appendChild(csrfInput);
	
	var parentNOInput = document.createElement("input");
	parentNOInput.setAttribute("type","hidden");
	parentNOInput.setAttribute("value",data);
	parentNOInput.setAttribute("name","anscno");
	
	form.appendChild(parentNOInput);
	document.body.appendChild(form);
	  
	console.log(form);
		
	form.submit();
}

function fn_Review4(url,data){
	var form = document.createElement("form");
	form.setAttribute("method", "post");
	form.setAttribute("action", url);
	
	var csrfInput = document.createElement("input");
	csrfInput.setAttribute("type", "hidden");
	csrfInput.setAttribute("name",  "${_csrf.parameterName}"); // csrf 토큰을 보내는 필드 이름 (서버에서 사용하는 이름과 동일해야 합니다)
	csrfInput.setAttribute("value", "${_csrf.token}");
	form.appendChild(csrfInput);
	
	var parentNOInput = document.createElement("input");
	parentNOInput.setAttribute("type","hidden");
	parentNOInput.setAttribute("value",data);
	parentNOInput.setAttribute("name","glno");
	
	form.appendChild(parentNOInput);
	document.body.appendChild(form);
	  
	console.log(form);
		
	form.submit();
}
</script>
</html>