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
        #result_card img{
			max-width: 100%;
		    height: auto;
		    display: block;
		    padding: 5px;
		    margin-top: 10px;
		    margin: auto;	
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
		
		/* 팝업창 기본 스타일 */
	  .popup-overlay {
	    position: fixed;
	    top: 0;
	    left: 0;
	    width: 100%;
	    height: 100%;
	    background: rgba(0, 0, 0, 0.5);
	    display: none;
	    justify-content: center;
	    align-items: center;
	  }
	  .popup-content {
	    background: #fff;
	    padding: 20px;
	    border-radius: 5px;
	    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
	  }
	  .close-btn {
	    cursor: pointer;
	    float: right;
	  }
    </style>
</head>
<body>
<p><a href="/main">홈</a> &gt; <a href="/item/list">전체상품</a> &gt; <a href="/item/list?pageNum=1&amount=12&category=<c:out value="${item.category}"/>"><c:out value="${item.category}"/></a></p>
    <form name="actionForm" action="item/list" method="get">
    	<input type="hidden" name="pageNum" value="<c:out value='${cri.pageNum}' />" />
    	<input type="hidden" name="amount" value="<c:out value='${cri.amount}' />" />
    	<input type="hidden" name="item_no" value="<c:out value='${item.item_no}' />" />
    	<input type="hidden" name="category" value="<c:out value='${item.category}' />" />
    </form>
    <form id="purchaseForm" name="purchaseForm" action="/order/purchase/direct" method="post">
    	<%-- <input type="hidden" name="item_img" value="<c:out value='${item.item_name}' />" /> --%>
    	<input type="hidden" name="quantity" value="1" />
    	<input type="hidden" name="status" value="<c:out value='${item.status}' />" />
    	<input type="hidden" name="price" value="<c:out value='${item.price}' />" />
    	<input type="hidden" name="item_no" value="<c:out value='${item.item_no}' />" />
    	<input type="hidden" name="item_name" value="<c:out value='${item.item_name}' />" />
    	<input type="hidden" name="member_id" value='<c:out value="${sessionScope.member.mem_id}" />' />
    </form>
    <div class="container">
    	
        <div class="form_section">
            <div class="form_section_content">
				<div id="uploadReslut"></div>
            </div>                    			        			
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
            수량 <input type="number" id="amount" name="amount" value="1" min="1" max="100"/>
            <div>
	      		<label class="total_price">총상품금액</label>
	     		 <div class="total_price" style="float:right;">원</div>
	      		<div class="totals-value" id="cart-total" style="float:right;">0</div>
            
            </div>
            <hr />
            <button id="add-cart">장바구니</button>
            <button id="direct-purchase">바로결제</button>
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
	        <p>별점 <input id="reviewScore" name="score" type="number" value="5" min="1" max="5" /></p>
	        <%-- 
	        	(시큐리티, 회원관리 가능하면 추가할예정 : 로그인했을 시 자신의 이름이 써지고 수정 불가-readOnly)
	        	<c:if test=""></c:if>
	        	
	        	그 전까진 아이디를 직접 쓰는걸로
	         --%>
	        <p><label for="writer">작성자</label><input type="text" name="writer" id="reviewWriter" placeholder="작성자를 입력해주세요"/></p>
	        <p><textarea name="content" id="reviewContent" cols="30" rows="10" placeholder="내용을 입력해주세요"></textarea><p/>
	        <!-- 비회원 상태에서 작성 가능 -->
	        <p id="inputBox">
		        <input id="rev_no" type="hidden" name="rev_no" value=""/>
		        <input class="addBtn" type="submit" value="작성"/>
		        <button class="modifyBtn" id="modify">수정</button>
		        <input class="addBtn" type="reset" value="초기화" />
		        <!-- submit하면 안되기 때문에 type을 button으로 지정했다 -->
		        <button class="modifyBtn" id="toList" type="button">목록으로</button>
	        </p>
        </form>
        
      </div>
    </div>
  </div>
  
	<div class="popup-overlay" id="popup">
	  <div class="popup-content">
	    <p>장바구니에 추가되었습니다.</p>
	    <button id="move-cart">이동하기</button>
	    <button class="close-btn" id="closePopup">닫기</button>
	  </div>
	</div>
</body>
<script src="/resources/js/cart.js"></script>
<script src="/resources/js/review.js"></script>
<script>

	let item_no = '<c:out value="${item.item_no}"/>';
	let uploadReslut = $("#uploadReslut");	

	$(document).ready(function(){
    /* 이미지 정보 호출 */
    $.getJSON("/item/getAttachList", {item_no : item_no}, function(arr){	
        //이미지가 없는 경우
        if(arr.length === 0){		
            let str = "";
            str += "<div id='result_card'>";
            str += "<img src='/resources/img/itemNoImage.png'>";
            str += "</div>";
            uploadReslut.html(str);	
            return;
        }

        let str = "";
        let obj = arr[0];	
        
        let fileCallPath = encodeURIComponent(obj.uploadPath + "/thumbs_" + obj.uuid + "_" + obj.fileName);
        str += "<div id='result_card'";
        str += "data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "'";
        str += ">";
        str += "<img src='/display?fileName=" + fileCallPath +"'>";
        str += "</div>";		
        
        uploadReslut.html(str);						
    	}); // 이 부분의 중괄호가 올바르게 닫혀있어야 합니다.
	}); // $(document).ready() 함수의 중괄호도 제대로 닫혀있습니다.
	
	//가져와서 출력
	let mode = 'add';
	const price = '<c:out value="${item.price}"/>';
	//var item_no = '<c:out value="${item.item_no}"/>';
	const listTbody = $('#listTbody');
	const reviewPageFooter = $('.panel-footer');
	const reviewForm = $('#reviewForm');
	
	const reviewNo = $('#rev_no'); //리뷰 번호 input
	const reviewWriter = $('#reviewWriter'); //작성자 input
	const reviewContent = $('#reviewContent'); //내용 textarea
	const reviewScore = $('#reviewScore'); //점수 input
	
	const copyFormTab = $('#myTabContent3>form').html();

	let pageNum = 1;
	const userID = $('input[name=member_id]').val();
	console.log(userID);
	
	//동적으로 리뷰 리스트를 생성하기 전에 함수를 선언한다.
	//$(document).ready() 안에 들어가게 되면
	//리스트 안의 버튼이 이 함수를 실행하지 못한다.
	if(userID != null || userID != ''){
		$('#reviewWriter').attr('readonly','true');
		$('#reviewWriter').attr('value',userID);
	}

	//리뷰 수정(하기 전에 데이터 가져오기)
	function reviewUpdate(rno){
		//get에 전달해줄 리뷰 번호
		const rev_no = rno;
		//리뷰에서 가져오기
		reviewService.get(rno, function(review){
			//userID가 있으면(회원이라면)
			if(userID != null && userID != ''){
				//작성자 아이디를 input태그에 넣는다
				reviewWriter.val(userID);
			}
			//작성 내용을 input태그에 넣는다
			reviewContent.val(review.content);
			//평점을 input태그에 넣는다
			reviewScore.val(review.score);
			//input에 리뷰 번호 적기
			reviewNo.val(rno);
			//수정모드로 변경하고 화면 구조 변경
			changeMode('modify');
			//3번째 탭으로 이동
			showTabMenu(3,true);
		});
	}
	
	//모드 변경(탭 3번의 화면 구성 및 기능 변경)
	function changeMode(m){
		const tab = $('#myTabContent3');
		if(m === 'add'){
			mode = 'add';
			//탭메뉴 타이틀 변경
			$('#myTabTitle3>a').html('리뷰작성');
			//탭메뉴 제목 변경
			tab.find('h2').html('리뷰 작성');
			reviewScore.val(5);
			reviewWriter.val(userID);
			reviewContent.val('');
			reviewNo.val('');
			//수정에 들어가는 버튼 숨기기
			$('.modifyBtn').hide();
			//작성에 들어가는 버튼 살리기
			$('.addBtn').show();
			
		}else if(m === 'modify'){
			mode = 'modify';
			//탭메뉴 타이틀 변경
			$('#myTabTitle3>a').html('리뷰수정');
			//탭메뉴 제목 변경
			tab.find('h2').html('리뷰 수정');
			//작성에 들어가는 버튼은 숨기기
			$('.addBtn').hide();
			//수정에 들어가는 버튼 보여주기
			$('.modifyBtn').show();
		}
	}
	
	function reviewDelete(rno){
		const rev_no = rno;
		if(confirm('정말 삭제하시겠습니까?')){
			reviewService.remove(rev_no, function(result){
				showList(pageNum);
			});
		};
	}
	
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
				if(list[i].writerID === userID){
					str += "<td><button class='review-update' onclick='reviewUpdate("+list[i].rev_no+")'>수정</button>";
					str += "<button class='review-delete' onclick='reviewDelete("+list[i].rev_no+")'>삭제</button></td>";
				}
				
				str += "</tr>";
			}
			
			listTbody.html(str);
			showReviewPage(reviewCnt);
		});//end function
	}//end showList
	

	function showTabMenu(tab_id, isModify){
		
		if(isModify){
			changeMode('modify');
		}else{
			changeMode('add');
		}
		
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
	
	
	function addReview(){
		const review = {
			item_no: item_no,
			writer: reviewWriter.val(),
			content: reviewContent.val(),
			score: reviewScore.val()
		};
		reviewService.add(review, function(result){

			alert(result);
			showList(1);
			showTabMenu(2);
		});
	}
	
	//리뷰 수정(리뷰 번호를 받아서)
	function modifyReview(){
		const review = {
			rev_no: reviewNo.val(),
			content: reviewContent.val(),
			score: reviewScore.val()
		};
		console.log(review);
		reviewService.update(review ,function(result){
			alert(result);
			changeMode("add");
			showList(1);
			showTabMenu(2);
		});
	};
	
	$(document).ready(function(){
		
		//초기 설정을 '작성모드'로 한다.
		changeMode('add');
		//리뷰 출력
		showList(1);
		
		listTbody.html("<tr><td>테스트</td><td>테스트2</td></tr>");
		$('#cart-total').html(Number(price).toLocaleString());
		//수량 바꾸면 총상품금액도 변경
		$('#amount').on('change',function(){
		
			const amount = Number($(this).val());
			console.log('changing');
			console.log(price , amount);
			$('input[name=quantity]').val(amount.toString());
			$('#cart-total').html((price * amount).toLocaleString());
			console.log('change end');
		});
		
		//탭메뉴
		$('.tab-menu ul li a').on('click',function(e){
			e.preventDefault();
			const tab_id = $(this).attr('data-tab');
			showTabMenu(tab_id);
		});
		
		
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
				if(mode === "add") addReview();
				else if(mode === "modify") modifyReview();
			}
		});
		
		$('#add-cart').on('click',function(){
			//장바구니 추가
			const amount = Number($('#amount').val());
			const cart = {member_id: userID, item_no: item_no, quantity: amount};
			cartService.add(cart, function(result){
				console.log(result);
				$('#popup').css('display','flex');
			});
		});
		
		$('#closePopup').on('click',function(){
			$('#popup').css('display','none');
		})
		
		$("#move-cart").on('click',function(){
			$('#popup').css('display','none');
			showTabMenu(1);
			self.location="/cart/list";
		});
		
		$('#toList').on('click',function(){
			showList(pageNum);
			showTabMenu(2);
			
		});
		
		$('#direct-purchase').on('click',function(){
			$('#purchaseForm').submit();
		});
	});
</script>
</html>