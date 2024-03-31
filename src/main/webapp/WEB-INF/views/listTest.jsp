<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>List</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/editMember.css">
<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- 임시 스타일 -->
<style>
	td{border: 1px solid black; width: 300px; height: 300px;}
	.item-img{display: block; width:200px; height: 200px; background-color: yellow;}
</style>
</head>
<body>
<div id="wrap">
	<form id="actionForm" action="/item/list" method="get">
		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}" />
		<input type="hidden" name="amount" value="${pageMaker.cri.amount}" />
		<input type="hidden" name="category" value='<c:out value="${pageMaker.cri.category}"/>'/>
	</form>
	<!-- 로고 -->
	<a href="${pageContext.request.contextPath}/home">
	    <img src="${pageContext.request.contextPath}/resources/images/캠핑가로고1.png" alt="Logo">
	</a>
	
	<!-- 상품카테고리 선택 -->
	<!-- 임의.location.href에 값을 설정하면 해당 값으로 페이지가 이동(리다이렉트).브라우저으이 현재 위치를 가져오거나 설정할 떄 사용. -->
	<select name="category" id="category">
		<option value=""
			<c:out value="${pageMaker.cri.category == null?'selected':''}" />
		>전체상품</option>
		<option value="캠핑가구"
			<c:out value="${pageMaker.cri.category == '캠핑가구'?'selected':''}" />
		>캠핑가구</option>
		<option value="조리도구"
			<c:out value="${pageMaker.cri.category == '조리도구'?'selected':''}" />
		>조리도구</option>
		<option value="랜턴"
			<c:out value="${pageMaker.cri.category == '랜턴'?'selected':''}" />
		>조명/랜턴</option>
		<option value="전자제품"
			<c:out value="${pageMaker.cri.category == '전자제품'?'selected':''}" />
		>전자기기</option>
		<option value="텐트"
			<c:out value="${pageMaker.cri.category == '텐트'?'selected':''}" />
		>텐트</option>
		<option value="침낭"
			<c:out value="${pageMaker.cri.category == '침낭'?'selected':''}" />
		>칭남</option>
		<option value="매트"
			<c:out value="${pageMaker.cri.category == '매트'?'selected':''}" />
		>매트</option>
		<option value="난로"
			<c:out value="${pageMaker.cri.category == '난로'?'selected':''}" />
		>난로</option>
	</select>
	<table>
	<!-- varStatus="loop"는 for문에서 i에 해당 -->
	   <c:forEach var="item" items="${itemList}" varStatus="loop">
	   	<!-- 새로운 행이 시작되었다면 tr태그 생성 -->
	       <c:if test="${loop.index % 4 == 0}">
	           <tr>
	       </c:if>
	       <!-- 데이터 들어가는 부분 -->
	       <td>
	           <a class="item-img" href="#">item_img: (추가예정)</a>
	           <p><c:out value="${item.item_name}" /></p>
	           <p><c:out value="${item.price}" /></p>
	       </td>
	       <!-- 행이 끝났거나 마지막 데이터라면 tr태그 close -->
	       <c:if test="${(loop.index + 1) % 4 == 0 || loop.last}">
	           </tr>
	       </c:if>
	   </c:forEach>
	</table>
	<div class='pull-right'>
		<ul class="pagination">
			<c:if test="${pageMaker.prev}">
				<!-- bootstrap 버전이 달라서 교재와 class가 다를 수 있음 -->
				<li class="page-item"><a class="page-link" href="${pageMaker.startPage-1}">Previous</a></li>
			</c:if>
			<c:forEach begin="${pageMaker.startPage}"
						end="${pageMaker.endPage}"
						var="num">
				<li class="page-item ${pageMaker.cri.pageNum == num ? 'active':'' }">
					<a class="page-link" href="${num}">${num}</a>
				</li>
			</c:forEach>
			<c:if test="${pageMaker.next}">
				<li class="page-item"><a class="page-link" href="${pageMaker.endPage+1}">Next</a></li>
			</c:if>
		</ul>
	</div>
</div>
</body>
<script>
	const actionForm = $('#actionForm');
	//페이지네이션
	$(".page-link").on("click",function(e){
		e.preventDefault();
		//$("input[name='bno']").remove();
		//href는 preventDefault에 의해 실제로 작동하지 않고 속성값이 form으로 이용됨
		const targetPage = $(this).attr('href');
		console.log(targetPage);
		
		//pageNum에 href로 들어간 속성값이 들어간다.(페이지 넘버) 
		actionForm.find("input[name='pageNum']").val(targetPage);
		actionForm.attr('action','/item/list');
		actionForm.submit();
	});
	$("#category").on("change", function(e){
		const selectedCategory = $(this).val();
		console.log(selectedCategory);
		actionForm.find("input[name='category']").val(selectedCategory);
		actionForm.find("input[name='pageNum']").val(1);
		actionForm.submit();
	});

	
</script>
</html>