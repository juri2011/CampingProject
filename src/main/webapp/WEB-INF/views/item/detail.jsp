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
		
		.tab-content div {
		  display: none;
		}
		
		.tab-content div.active {
		  display: block;
		}
    </style>
</head>
<body>
<p><a href="/main">홈</a> > <a href="/item/list">전체상품</a> > <a href="/item/list?pageNum=1&amount=12&category=<c:out value="${item.category}"/>"><c:out value="${item.category}"/></a></p>
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
      <li class="active"><a href="#detail" data-tab="1">상품소개</a></li>
      <li><a href="#review" data-tab="2">리뷰</a></li>
      <li><a href="#write" data-tab="3">리뷰작성</a></li>
    </ul>
    <div class="tab-content">
      <div id="myTabContent1" class="active">
        <h2>메뉴1</h2>
            <h3>Description</h3>
            <p><c:out value="${item.content}" /></p>
      </div>
      <div id="myTabContent2">
        <h2>메뉴2</h2>
        <p>메뉴2 내용입니다.</p>
      </div>
      <div id="myTabContent3">
        <h2>메뉴3</h2>
        <p>메뉴3 내용입니다.</p>
      </div>
    </div>
  </div>
</body>
<script>
	$(document).ready(function(){
		//가져와서 출력
		const price = '<c:out value="${item.price}"/>';
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
			
			$('ul.tab-title li').removeClass('active');
		    $('.tab-content div').removeClass('active');
	
		    $(this).parent().addClass('active');
		    $("#myTabContent"+tab_id).addClass('active');
		});
		
		
	});
</script>
</html>