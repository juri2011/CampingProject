<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" href="/resources/css/claim.css">




<div class="claims">
	<c:choose>
		<c:when test="${claimlist[0].goods_no == null}">
			<div>
				<span>등록된 글이 없습니다.</span>
			</div>
		</c:when>
		<c:when test="${claimlist != null }">
			<c:forEach var="item" items="${claimlist }" varStatus="articleNum">
				<c:if test="${item.level == 1 }">
					<div class="claim">
						<em class="claim__label">클레임</em>
						<div class="claim__wrap">
							<strong class="claim__author"></strong>
							<div class="claim__selected-option">${goods.pname }</div>
						</div>
						<div class="claim__content">
							${item.content }
						</div>
						<div class="claim__time">
							<c:if test="${id==item.mem_id }">
								<%-- <button type="button" class="btn btn-secondary btn-sm"
										onclick="fn_Review3('/deleteClaim', ${item.gclaim_no })">삭제</button> --%>
								<button type="button" class="btn btn-secondary btn-sm"
										onclick="fn_Review2('/writeclaim/modify/${gno }', ${item.gclaim_no })">수정</button>&nbsp;&nbsp;&nbsp;
							</c:if>
							<fmt:formatDate pattern="yy/MM/dd HH:mm" value="${item.regidate}"/>
						</div>
					</div>
				</c:if>
				<c:if test="${item.level == 2 }">
					<div class="claim__reply">
						<em class="claim__reply__label">
							<c:if test="${item.status == 1 }" >
								처리대기
							</c:if>
							<c:if test="${item.status == 2 }" >
								처리중
							</c:if>
							<c:if test="${item.status == 3 }" >
								처리완료
							</c:if>
						</em>
						<div class="claim__reply__wrap">
							<strong class="claim__reply__author">회사명</strong>
							<div class="claim__reply__selected-option"></div>
						</div>
						<div class="claim__reply__content">
							${item.content }
						</div>
						<div class="claim__reply__time">
							<fmt:formatDate pattern="yy/MM/dd HH:mm" value="${item.regidate}"/>
						</div>
					</div>
				</c:if>
			</c:forEach>	
		</c:when>
	</c:choose>
</div>

<!-- pagination -->
<div class="w3-center">
	<c:if test="${tot4 != null }">
		<ul class="w3-pagination">
			<c:choose>
				<c:when test="${tot4 > 100 }">
					<c:forEach var="page" begin="1" end="10" step="1">
						<c:if test="${section > 1 && page==1 }">
							<li><a href="#">&laquo;</a></li>
						</c:if>
						<li><a href="#">${(section-1)*10 +page }</a></li>
						<c:if test="${page == 10 }">
							<li><a href="#">&raquo;</a></li>
						</c:if>
					</c:forEach>
					
				</c:when>
				<c:when test="${tot4==100 }">
					<c:forEach var="page" begin="1" end="10" step="1">
						<li><a href="#">${page }</a></li>
					</c:forEach>
				</c:when>
				
				<c:when test="${tot4<100 && tot4>10 }">
					<c:forEach var="page" begin="1" end="${tot/10 + 1 }" step="1">
						<c:choose>
							<c:when test="${page==pageNum }">
								<li><a class="w3-green" href="#">${page }</a></li>
							</c:when>
							<c:otherwise>
								<li><a href="#">${page }</a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:when>
				<c:when test="${tot4<=10 }">
				</c:when>
			</c:choose>
		</ul>
	</c:if>
</div>
<div style="margin-left: 1050px">
<c:choose>
	<c:when test='${id == "anonymousUser" }'>
	</c:when>
	<c:when test='${id != "anonymousUser" }'>
			<button type="button" class="btn btn-secondary btn-sm"
				onclick="fn_Review('/writeclaim/write/${gno }',${gno})">클레임</button>
	</c:when>
</c:choose>
</div>
<script>
function fn_Review2(url,data){
	var form = document.createElement("form");
	form.setAttribute("method", "get");
	form.setAttribute("action", url);
	var parentNOInput = document.createElement("input");
	parentNOInput.setAttribute("type","hidden");
	parentNOInput.setAttribute("value",data);
	parentNOInput.setAttribute("name","gclaim_no");
	
	form.appendChild(parentNOInput);
	document.body.appendChild(form);
	  
	console.log(form);
		
	form.submit();
}

function fn_Review(url,data){
	var form = document.createElement("form");
	form.setAttribute("method", "get");
	form.setAttribute("action", url);
	var parentNOInput = document.createElement("input");
	parentNOInput.setAttribute("type","hidden");
	parentNOInput.setAttribute("value",data);
	parentNOInput.setAttribute("name","gno");
	
	form.appendChild(parentNOInput);
	document.body.appendChild(form);
	  
	console.log(form);
		
	form.submit();
}
/*
function fn_Review3(url,data){
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
 */
</script>