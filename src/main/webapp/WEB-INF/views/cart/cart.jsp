<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Cart Page</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
	<!-- 로고 -->
	<a href="${pageContext.request.contextPath}/home">
	    <img src="${pageContext.request.contextPath}/resources/images/캠핑가로고1.png" alt="Logo">
	</a>
	<h1>cart</h1>
	
	<form action="/cart" method="post">
		<table>
			<thead>
				<tr>
					<th>상품 이미지</th>
					<th>상품명</th>
					<th>가격</th>
					<th>수량</th>
					<th>삭제</th>
				</tr>
			</thead>
			<tbody id="listTbody">
				
			</tbody>
		</table>
		<button>구매</button>
		<button>전체 삭제</button>
	</form>
</body>
<script src="/resources/js/cart.js"></script>
<script>

	const member_id = '<c:out value="${user_id}"/>';
	const listTbody = $('#listTbody');
	
	
	
	
	$(document).ready(function(){
		showList();
		$('.cart-delete').on('click', function(e){
			e.preventDefault();
			const cart_no = $(this).parent().parent().data('no')
			console.log(cart_no);
			cartService.remove(cart_no, function(result){
				alert(result);
			});
		});
		function showList(){
			console.log(cartService);
			cartService.getList(member_id, function(list){
				console.log("cartCnt: "+cartCnt);
				console.log("list: "+list);
				
				let str = "";
				//댓글이 없으면 댓글창 비우기
				if(list == null || list.length == 0){
					listTbody.html("");
					
					return;
				}
				for(let i=0, len=list.length || 0; i<len; i++){
					str += "<tr class='cartItem' data-no='"+list[i].cart_no+"'>";
					str += "	<td><img src='"+list[i].item_img+"' alt='"+list[i].item_name+"'></td>"
					str += "	<td>"+list[i].item_name+"</td>";
					str += "	<td>"+list[i].price+"</td>";
					str += "	<td> <input type='number' name='quantity' ";
					str += "value='"+list[i].quantity+"' min='1' max='100'/></td>";
					str += "	<td><button class='cart-delete'>삭제</button></td></tr>";
				}
				console.log(str);
				listTbody.html(str);
			});//end function
		}//end showList
	});
</script>
</html>