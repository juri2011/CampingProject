<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
  .list-table {
    width: 100%;
}

.list-table tr {
    display: flex;
    flex-wrap: wrap; /* 항목이 다음 줄로 넘어가도록 허용 */
    gap: 40px;
}
   
   .item-img{
      display: flex;
      width: 200px;
      height: 200px;
      margin: 0 auto;
      justify-content: center;
      align-items: center;
   }
   
   .item-img>img{
      display: block;
      width: 200px;
   }
   
.card {
    margin: 10px 0;
    padding: 15px;
    width: calc(25% - 40px);
    min-height: 200px;
    text-align: center;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}
   .card-title{
      font-size: 18px;
      white-space: nowrap;
      overflow:hidden;
      text-overflow: ellipsis;
   }
   
   .list-select{
      width: auto;
   }
</style>
</head>
<body>
<div id="wrapper">
   <div class="common-container">
      <!-- 검색기준 form 태그 -->
   <form id="actionForm" action="/item/list" method="get">
      <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}" />
      <input type="hidden" name="amount" value="${pageMaker.cri.amount}" />
      <input type="hidden" name="category" value='<c:out value="${pageMaker.cri.category}"/>'/>
      <input type="hidden" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"/>'/>
   </form>
   
   <!-- 상품카테고리 선택 -->
   <!-- 임의.location.href에 값을 설정하면 해당 값으로 페이지가 이동(리다이렉트).브라우저으이 현재 위치를 가져오거나 설정할 떄 사용. -->
   <select name="category" id="category" class="form-select list-select">
      <!-- 키워드 검색으로 들어왔을 때만 생성 -->
      <c:if test="${pageMaker.cri.keyword != ''}">
         <option value="검색결과" selected>검색결과</option>
      </c:if>
      <option value=""
         <c:out value="${pageMaker.cri.category == 'null'?'selected':''}" />
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
      >침낭</option>
      <option value="매트"
         <c:out value="${pageMaker.cri.category == '매트'?'selected':''}" />
      >매트</option>
      <option value="난로"
         <c:out value="${pageMaker.cri.category == '난로'?'selected':''}" />
      >난로</option>
   </select>
   <table class="list-table">
   <!-- varStatus="loop"는 for문에서 i에 해당 -->
      <c:forEach var="item" items="${itemList}" varStatus="loop">
         <!-- 새로운 행이 시작되었다면 tr태그 생성 -->
          <c:if test="${loop.index % 4 == 0}">
              <tr>
          </c:if>
          <!-- 데이터 들어가는 부분 -->
          <td class="card">
              <a class="item-img" href="<c:out value='${item.item_no}'/>">
                 <img src="/resources/img/${item.fileName}"/>
              </a>
              <p class="card-title"><c:out value="${item.item_name}" /></p>
              <p class="card-price">
                 <fmt:formatNumber value="${item.price}" pattern="#,###원" />
              </p>
          </td>
          <!-- 행이 끝났거나 마지막 데이터라면 tr태그 close -->
          <c:if test="${(loop.index + 1) % 4 == 0 || loop.last}">
              </tr>
          </c:if>
      </c:forEach>
   </table>
   
   <!-- 페이지네이션 처리 -->
   <div class='pull-right'>
      <ul class="pagination">
         <!-- 이전 블록이 있다면 : prev 표시(이전 블록의 마지막 페이지로 이동) -->
         <c:if test="${pageMaker.prev}">
            <li class="page-item"><a class="page-link" href="${pageMaker.startPage-1}">Previous</a></li>
         </c:if>
         <c:forEach begin="${pageMaker.startPage}"
                  end="${pageMaker.endPage}"
                  var="num">
            <!-- 현재 페이지 번호에는 active 클래스 부여 -->
            <li class="page-item ${pageMaker.cri.pageNum == num ? 'active':'' }">
               <!-- href는 preventDefault로 실제 작동되지 않고 속성값을 이용하여 form 태그의 input 값으로 삽입 -->
               <a class="page-link" href="${num}">${num}</a>
            </li>
         </c:forEach>
         <!-- 다음 블록이 있다면 : next 표시(이전 블록의 첫번째 페이지로 이동) -->
         <c:if test="${pageMaker.next}">
            <li class="page-item"><a class="page-link" href="${pageMaker.endPage+1}">Next</a></li>
         </c:if>
      </ul>
   </div>
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
   //카테고리 선택 시 카테고리로 리스트 출력
   $("#category").on("input", function(e){
      //select에서 선택된 값이 들어옴
      const selectedCategory = $(this).val();
      
      //카테고리 input에 선택한 항목 들어감
      actionForm.find("input[name='category']").val(selectedCategory);
      //항상 첫번째 페이지로 이동
      actionForm.find("input[name='pageNum']").val(1);
      actionForm.find("input[name='keyword']").val('');
      actionForm.submit();
   });
   
   $(".item-img").on('click',function(e){
      e.preventDefault();
      self.location = "/item/detail?item_no=" + $(this).attr('href');
      //criteria, paging 정보 포함해서 넘기는 작업은 4/2일 구현 예정
   });

   
</script>
</html>