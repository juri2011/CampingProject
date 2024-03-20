<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />

<title>클레임 관리 게시판</title>
<style>
.w3-container {
  padding: 0.01em 16px;
}

.w3-container:after,
.w3-container:before,
.w3-panel:after,
.w3-panel:before,
.w3-row:after,
.w3-row:before,
.w3-row-padding:after,
.w3-row-padding:before,
.w3-cell-row:before,
.w3-cell-row:after,
.w3-topnav:after,
.w3-topnav:before,
.w3-clear:after,
.w3-clear:before,
.w3-btn-group:before,
.w3-btn-group:after,
.w3-btn-bar:before,
.w3-btn-bar:after,
.w3-bar:before,
.w3-bar:after {
  content: "";
  display: table;
  clear: both;
}

.w3-responsive {
  overflow-x: auto;
}

.w3-table,
.w3-table-all {
  border-collapse: collapse;
  border-spacing: 0;
  width: 50%;
  display: table;
}

.w3-table-all {
  border: 1px solid #ccc;
  margin: 0 auto;
}

.w3-bordered tr,
.w3-table-all tr {
  border-bottom: 1px solid #ddd;
}

.w3-table-all tr:nth-child(odd) {
  background-color: #fff;
}

.w3-table-all tr:nth-child(even) {
  background-color: #f1f1f1;
}

.w3-table td,
.w3-table th,
.w3-table-all td,
.w3-table-all th {
  padding: 8px 8px;
  display: table-cell;
  text-align: left;
  vertical-align: top;
   
  white-space: nowrap; /* 글자를 자동으로 줄바꿈하지 않도록 설정 */
}


.w3-table-all td.dlevel-2{
  text-align: center;
}

.w3-table th:first-child,
.w3-table td:first-child,
.w3-table-all th:first-child,
.w3-table-all td:first-child {
  padding-left: 16px;
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

.w3-pagination {
  display: inline-block;
  padding: 0;
  margin: 0;
}

.w3-pagination li {
  display: inline;
}

.w3-pagination li a {
  text-decoration: none;
  color: #000;
  float: left;
  padding: 8px 16px;
}

.w3-pagination li a:hover {
  background-color: #ccc;
}

.w3-btn,
.w3-btn-floating,
.w3-dropnav a,
.w3-btn-floating-large,
.w3-btn-block,
.w3-navbar a,
.w3-navblock a,
.w3-sidenav a,
.w3-pagination li a,
.w3-hoverable tbody tr,
.w3-hoverable li,
.w3-accordion-content a,
.w3-dropdown-content a,
.w3-dropdown-click:hover,
.w3-dropdown-hover:hover,
.w3-opennav,
.w3-closenav,
.w3-closebtn,
*[class*="w3-hover-"] {
  -webkit-transition: background-color 0.25s, color 0.15s, box-shadow 0.25s,
    opacity 0.25s, filter 0.25s, border 0.15s;
  transition: background-color 0.25s, color 0.15s, box-shadow 0.15s,
    opacity 0.25s, filter 0.25s, border 0.15s;
}

.w3-green,
.w3-hover-green:hover {
  color: #fff !important;
  background-color: #4caf50 !important;
}


/* 계층형을 나타내는 레벨마다 들여쓰기 적용 (이 예시에서는 최대 5단계 까지 표현) */
.level-1 {
  padding-left: 0px;
}

.level-2 {
  padding-left: 32px;
}

header{
  height: 40px;
  border-bottom: 1px solid black;
  display: flex;
  align-items: center;
}

header div{
  margin: 0;
}

header div.a{
  width: 70%;
}

.notice td {
	text-align: center;
}

</style>
</head>
<body>

<header style="height: 100px">
<div class="logo-mobile">
<a href="/home"><img style="height: 90px;" src="../resources/images/icons/logo-01.png" alt="IMG-LOGO"></a>
</div>
<div class="a"></div>
<div class="b">
<form action="/logout.do" method='post'>
	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" >
	<button>로그아웃</button>
</form>
</div>
</header>


<div class="w3-container">
 
   <h2>클레임 관리 게시판</h2>
   <div class="w3-responsive">
     <table class="w3-table-all">
     	<thead>
        <tr>
          <th>번호</th>
          <th>고객ID</th>
          <th>게시글</th>
          <th>작성일</th>
          <th>상태</th>
        </tr>
       </thead>
       <tbody>
       	<!-- 매니저/관리자 전용 공지사항 테이블 필요? -->


			<tr class="notice" align="center">
				<!-- 다른곳에서 복붙하지말고 여기에 추가해주세요  -->
				<td colspan="5">[공지] 친절한 고객 응대 [공지]</td>
			</tr>


		<c:choose>
			<c:when test="${claimlist == null }">
				<tr height="10">
					<td colspan="6">
						<p align="center">
							<b><span style="font-size: 9pt;">등록된 글이 없습니다.</span></b>
						</p>
					</td>
				</tr>
			</c:when>
			<c:when test="${claimlist != null }">
				<c:forEach var="item" items="${claimlist }" varStatus="articleNum">
					<tr>
						<td>${articleNum.count}</td>
						<td>${item.mem_id}</td>
						<td>
							<div class="level-${item.level }">
							<c:if test="${item.level == 1 }">
								<a href="/admin/claims/claim?gclaim_no=${item.gclaim_no }">
									${fn:substring(item.content, 0, 20)}${fn:length(item.content) > 20 ? '...' : ''}
								</a>
							</c:if>								
							<c:if test="${item.level == 2 }">
								<a href="/admin/claims/answer?answer_no=${item.answer_no}">
									${fn:substring(item.content, 0, 17)}${fn:length(item.content) > 17 ? '...' : ''}
								</a>
							</c:if>
							</div>
						</td>
						<td><fmt:formatDate pattern="yy/MM/dd HH:mm" value="${item.regidate}"/></td>
						<td class="dlevel-${item.level }">
							<c:if test="${item.level == 1 && item.status == 1 }">
								변심
							</c:if>
							<c:if test="${item.level == 1 && item.status == 2 }">
								제품하자
							</c:if>
							<c:if test="${item.level == 1 && item.status == 3 }">
								사이즈
							</c:if>
							<c:if test="${item.level == 1 && item.status == 4 }">
								오배송
							</c:if>
							<c:if test="${item.level == 1 && item.status == 5 }">
								기타
							</c:if>
							<c:if test="${item.level == 2}">
								${item.status }단계
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</c:when>
		</c:choose>
       </tbody>
     </table>
   </div>
   
   <br />

<!-- pagination -->
<div class="w3-center">
	<c:if test="${tot != null }">
		<ul class="w3-pagination">
			<c:choose>
				<c:when test="${tot > 100 }">
					<c:forEach var="page" begin="1" end="10" step="1">
						<c:if test="${section > 1 && page==1 }">
							<li><a href="/admin/claims?section=${section-1}&pageNum=${(section-1)*10 +1 }">&laquo;</a></li>
						</c:if>
						<li><a href="/admin/claims.do?section=${section}&pageNum=${page}">${(section-1)*10 +page }</a></li>
						<c:if test="${page == 10 }">
							<li><a href="/admin/claims?section=${section+1}&pageNum=${section*10+1}">&raquo;</a></li>
						</c:if>
					</c:forEach>
					
				</c:when>
				<c:when test="${tot==100 }">
					<c:forEach var="page" begin="1" end="10" step="1">
						<li><a href="/admin/claims?section=${section }&pageNum=${page}">${page }</a></li>
					</c:forEach>
				</c:when>
				
				<c:when test="${tot<100 }">
					<c:forEach var="page" begin="1" end="${tot/10 + 1 }" step="1">
						<c:choose>
							<c:when test="${page==pageNum }">
								<li><a class="w3-green" href="/admin/claims?section=${section}&pageNum=${page}">${page }</a></li>
							</c:when>
							<c:otherwise>
								<li><a href="/admin/claims?section=${section }&pageNum=${page}">${page }</a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:when>
			</c:choose>
		</ul>
	</c:if>
</div>
</div>  
</body>
</html>