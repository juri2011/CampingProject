<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<title>Welcome CampingGa</title>
<style>
   .main-wrapper{
      max-width: 1200px;
      margin: 20px auto;
   }
   
   h2{
      font-weight:800;
   }
   
   .card{
      margin: 10px 0;
      padding: 15px;
      width: calc(25% - 40px); /* Each card takes up 25% of the container width */
      min-height: 200px;
      text-align: center;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
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
   
   .card-container{
      display: flex;
      flex-wrap: wrap; /* Items wrap to the next line when there's not enough space */
      gap: 40px;
   }
   
   .card-title{
      font-size: 18px;
   }
</style>
</head>

<body>

   <div class="main-wrapper">
   
   <!-- 최신 4개 -->
   <hr />
   <h2>최신 상품</h2>
   <div class="card-container">
      <c:forEach var="item" items="${newItem}">
         <div class="card" data-no="<c:out value='${item.item_no}' />">
               <a class="item-img" href="<c:out value='${item.item_no}'/>">
                    <img src="/resources/img/${item.fileName}"/>
                 </a>
              <div class="card-details">
                  <div class="card-title"><c:out value="${item.item_name}" /></div>
                  <div class="card-price"><fmt:formatNumber value="${item.price}" pattern="#,###원" /></div>
              </div>
          </div>
      </c:forEach>
   </div>
   
   </div>
   <script>
      var token = $("meta[name='_csrf']").attr("content");
      var header = $("meta[name='_csrf_header']").attr("content");
      /* 상품 목록 클릭하면 상세페이지로 이동 */
      $(document).ready(function(){
         
         $('.card').click(function(){
            const item_no = $(this).data("no");
            location.href="/item/detail?item_no="+item_no;
         });
         
         
         $(".item-img").on('click',function(e){
            e.preventDefault();
            self.location = "/item/detail?item_no=" + $(this).attr('href');
         });
      });
   </script>
</body>
</html>