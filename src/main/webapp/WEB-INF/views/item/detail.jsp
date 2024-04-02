<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Detail</title>
	<!-- jQuery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f0f0f0;
        }
        .container {
        	display: flex;
            max-width: 800px;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .product-image {
        	width: 300px;
        	height: 300px;
        	background-color: yellow;
            text-align: center;
        }
        .product-image img {
            max-width: 100%;
            height: auto;
        }
        .product-info {
        	width: 100%;
        	height: 300px;
            margin-left: 20px;
            padding: 10px;
            border: 1px solid black;
        }
        .product-info h2 {
            font-size: 24px;
            color: #333;
        }
        .product-info p {
            font-size: 16px;
            color: #666;
        }
        .product-info p.product-price {
            margin-top: 10px;
        	font-size: 42px;
        	font-weight: 600;
            color: #e67e22;
        }
        .product-info p.product-no {
            font-size: 12px;
        }
        .product-description {
            margin-top: 20px;
        }
        
		
		/* 탭 메뉴 */
		.tab-menu {
		  border: 1px solid #ddd;
		  max-width: 800px;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
		}
		
		.tab-menu ul {
		  list-style: none;
		  padding: 0;
		  margin: 0;
		}
		
		.tab-menu ul li {
		  display: inline-block;
		  padding: 10px;
		  border-right: 1px solid #ddd;
		}
		
		.tab-menu ul li a {
		  text-decoration: none;
		  color: #333;
		}
		
		.tab-menu ul li.active a {
		  color: #fff;
		  background-color: #333;
		}
		
		/* 탭 내용 */
		.tab-content {
		  border: 1px solid #ddd;
		  padding: 20px;
		}
		
		.tab-content>div {
		  display: none;
		}
		
		.tab-content>div.active {
		  display: block;
		}
    </style>
</head>
<body>
<p><a href="/main">홈</a> &gt; <a href="/item/list">전체상품</a> &gt; <a href="/item/list?pageNum=1&amount=12&category=<c:out value="${item.category}"/>"><c:out value="${item.category}"/></a></p>
    <form name="actionForm" action="item/list" method="get">
    	<input type="hidden" name="pageNum" value="<c:out value='${cri.pageNum}' />" />
    	<input type="hidden" name="amount" value="<c:out value='${cri.amount}' />" />
    	<input type="hidden" name="item_no" value="<c:out value='${item_no}' />" />
    	<input type="hidden" name="category" value="<c:out value='${cri.category}' />" />
    </form>
    <div class="container">
    	
        <div class="product-image">
            <img src="product_image.jpg" alt="Product Image">
        </div>
        <div class="product-info">
            <h2><c:out value="${item.item_name}" /></h2>
            <hr />
            <!-- fmt적용 -->
            <p class="product-price"><fmt:formatNumber value="${item.price}" pattern="#,###" />원</p>
            <p class="product-no"><c:out value="${item.item_no}" />(상품번호)</p>
            
            <!--
            	재고수량이 있는 경우 동적으로 max 추가
            	min 아래로 떨어지면 alert
            	수량 변경과 동시에 가격도 변경
             -->
            <hr />
            수량 <input type="number" id="amount" name="amount" value="1" min="1" max="10"/>
            <div>
	      		<label class="total_price">총상품금액</label>
	     		 <div class="total_price" style="float:right;">원</div>
	      		<div class="totals-value" id="cart-total" style="float:right;">0</div>
            
            </div>
            <hr />
            <button>장바구니</button>
            <button>바로결제</button>
        </div>
    </div>
    
    <div class="tab-menu">
    <ul class="tab-title">
      <li id="myTabTitle1" class="active"><a href="#detail" data-tab="1">상품소개</a></li>
      <li id="myTabTitle2"><a href="#review" data-tab="2">리뷰</a></li>
      <li id="myTabTitle3"><a href="#write" data-tab="3">리뷰작성</a></li>
    </ul>
    <div class="tab-content">
      <div id="myTabContent1" class="active">
        <h2>상품 소개</h2>
            <h3>Description</h3>
            <p><c:out value="${item.content}" /></p>
      </div>
      <div id="myTabContent2">
        <h2>리뷰 리스트</h2>
        <table>
        	<thead>
        	<tr>
        		<th>글번호</th>
        		<th>작성자</th>
        		<th>내용</th>
        		<th>평점</th>
        		<th>작성일</th>        	
        	</tr>
        	</thead>
        	<tbody id="listTbody">
        	</tbody>
        </table>
        <div class="panel-footer">
        </div>
      </div>
      <div id="myTabContent3">
        <h2>리뷰 작성</h2>
        <form id="reviewForm" action="/review/write">
	        <p>별점 <input id="reviewScore" type="number" value="5" min="1" max="5" /></p>
	        <%-- 
	        	(시큐리티, 회원관리 가능하면 추가할예정 : 로그인했을 시 자신의 이름이 써지고 수정 불가-readOnly)
	        	<c:if test=""></c:if>
	        	
	        	그 전까진 아이디를 직접 쓰는걸로
	         --%>
	        <p><label for="writer">작성자</label><input type="text" name="writer" id="reviewWriter" placeholder="작성자를 입력해주세요"/></p>
	        <p><textarea name="reviewContent" id="reviewContent" cols="30" rows="10" placeholder="내용을 입력해주세요"></textarea><p/>
	        <!-- 비회원 상태에서 작성 가능 -->
	        <input type="submit" value="작성"/>
	        <input type="reset" value="초기화" />
        </form>
        
      </div>
    </div>
  </div>
</body>
<script src="/resources/js/review.js"></script>
<script>
	$(document).ready(function(){
		//가져와서 출력
		const price = '<c:out value="${item.price}"/>';
		var item_no = '<c:out value="${item.item_no}"/>';
		const listTbody = $('#listTbody');
		const reviewPageFooter = $('.panel-footer');
		const reviewForm = $('#reviewForm');
		
		const reviewWriter = $('#reviewWriter'); //작성자 input
		const reviewContent = $('#reviewContent'); //내용 textarea
		const reviewScore = $('#reviewScore'); //점수 input
		//리뷰 출력
		showList(1);
		let pageNum = 1;
		
		listTbody.html("<tr><td>테스트</td><td>테스트2</td></tr>");
		$('#cart-total').html(Number(price).toLocaleString());
		
		//수량 바꾸면 총상품금액도 변경
		$('#amount').on('change',function(){
			const amount = $(this).val();
			$('#cart-total').html((price * amount).toLocaleString());
		});
		
		//탭메뉴
		$('.tab-menu ul li a').on('click',function(e){
			e.preventDefault();
			const tab_id = $(this).attr('data-tab');
			showTabMenu(tab_id);
		});
		
		function showTabMenu(tab_id){
			$('ul.tab-title li').removeClass('active');
		    $('.tab-content div').removeClass('active');
	
		    $("#myTabTitle"+tab_id).addClass('active');
		    $("#myTabContent"+tab_id).addClass('active');
		}
		
		function showReviewPage(reviewCnt){
			let endNum = Math.ceil(pageNum/10.0) * 10; // 한 블록 끝페이지
			const startNum = endNum - 9;// 한 블록 시작 페이지
			
			let prev = startNum != 1; //startNum이 1이면 prev없음, 그 외 존재
			let next = false;
			
			if(endNum * 10 >= reviewCnt){//한 블록 끝페이지 마지막 게시물 번호가 실제 게시물 번호보다 크다면
				endNum = Math.ceil(reviewCnt/5.0);//실제 마지막 게시물 번호로 맞춘다.
			}
			
			if(endNum * 10 < reviewCnt){//마지막 블록이 아니라면 next 존재
				next = true;
			}
			
			console.log(startNum, endNum, prev, next);
			
			let str = "<ul class='pagination pull-right'>";
			if(prev){//이전 블록이 있다면
				str += "<li class='page-item'><a class='page-link' href='"+(startNum -1)+"'>Previous</a></li>"
			}
			
			for(let i=startNum; i<=endNum; i++){
				var active = pageNum == i? "page-active":"";
				
				//현재 페이지면 active 해제, 나머지 active
				str+="<li class='page-item "+active+"'><a class='page-link' href='"+i+"'>"+i+"</a></li>";
			}
			if(next){//이전 블록이 있다면
				str += "<li class='page-item'><a class='page-link' href='"+(endNum+1)+"'>Next</a></li>"
			}
			
			str+="</ul>"
			
			console.log(str);
			
			reviewPageFooter.html(str);
		}
		reviewPageFooter.on("click","li a", function(e){
			e.preventDefault();
			console.log("page click");
			var targetPageNum = $(this).attr("href");
			console.log("targetPageNum: " + targetPageNum);
			pageNum = targetPageNum;
			showList(pageNum);
		})
		
		function showList(page){
			reviewService.getList({item_no:item_no, page: page||1}, function(reviewCnt, list){
				console.log("reviewCnt: "+reviewCnt);
				console.log("list: "+list);
				
				//페이지 번호가 -1이면 마지막페이지를 호출
				if(page == -1){
					pageNum = Math.ceil(reviewCnt/5.0); //5개씩 한 페이지
					showList(pageNum);
					return;
				}
				let str = "";
				//댓글이 없으면 댓글창 비우기
				if(list == null || list.length == 0){
					listTbody.html("");
					
					return;
				}
				for(let i=0, len=list.length || 0; i<len; i++){
					str += "<tr><td>"+list[i].rownum+"</td>";
					str += 		"<td>"+list[i].writer+"</td>";
					str += 		"<td>"+list[i].content+"</td>";
					str += 		"<td>"+list[i].score+"</td>";
					str += 		"<td>"+reviewService.displayTime(list[i].regdate)+"</td>";
					str += "</tr>";
				}
				
				listTbody.html(str);
				showReviewPage(reviewCnt);
			});//end function
		}//end showList
		
		function addReview(){
			const review = {
				item_no: item_no,
				writer: reviewWriter.val(),
				content: reviewContent.val(),
				score: reviewScore.val()
			};
			reviewService.add(review, function(result){
				alert(result);
				reviewScore.val(5);
				reviewWriter.val('');
				reviewContent.val('');
				showList(-1);
				showTabMenu(2);
			});
		}
		reviewForm.on('submit', function(e){
			e.preventDefault();
			//유효성 검사
			if(reviewWriter.val() == null || reviewWriter.val() == ''){
				alert('작성자를 입력해주세요.');
				reviewWriter.focus();
			}
			else if(reviewContent.val() == null || reviewContent.val() == ''){
				alert('내용을 입력해주세요.');
				reviewContent.focus();
			}
			else{
				addReview();
			}
		});
	});
</script>
</html>