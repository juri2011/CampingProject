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
	
		<table>
			<thead>
				<tr>
					<th>상품 이미지</th>
					<th>상품명</th>
					<th>가격</th>
					<th>수량</th>
				</tr>
			</thead>
			<tbody id="listTbody">
				
			</tbody>
		</table>
		<button id="purchase">구매</button>
		<button id="deleteAll">전체 삭제</button>
</body>
<script src="/resources/js/cart.js"></script>
<script>

	const member_id = '<c:out value="${userId}"/>';
	console.log(member_id);
	const listTbody = $('#listTbody');
	
	function cartDelete(cno){
		const cart_no = cno;
		console.log('cart_no',cart_no);
		cartService.remove(cart_no, function(result){
			alert(result);
			showList();
		});
	}
	
	function showList(){
		cartService.getList(member_id, function(cartCnt, list){
			console.log("cartCnt: "+cartCnt);
			console.log("list: "+list);
			
			let str = "";
			//댓글이 없으면 댓글창 비우기
			if(list == null || list.length == 0){
				listTbody.html("");
				
				return;
			}
			for(let i=0, len=list.length || 0; i<len; i++){
				str += "<tr class='cartItem' id='cart-"+list[i].cart_no+"'>";
				//img src에 list[i].item_img를 넣으려니 405에러 발생(이미지가 아직 없기 때문에)
				str += "	<td><img src='' alt='"+list[i].item_name+"'></td>";
				str += "	<td>"+list[i].item_name+"</td>";
				str += "	<td>"+list[i].price.toLocaleString()+"원</td>";
				str += "	<td> <input type='number' name='quantity' ";
				str += "value='"+list[i].quantity+"' min='1' max='100'/></td>";
				str += "	<td><button onclick='cartDelete("+list[i].cart_no+")'>삭제</button></td></tr>";
			}
			console.log('결과 : ',str);
			listTbody.html(str);
		});//end function
	}//end showList
	
	$(document).ready(function(){
		showList();
		
		$('#deleteAll').on('click', function(){
			if(confirm('장바구니 목록을 비우시겠습니까?')){
				$.ajax({
					type: 'delete',
					url: '/cart/deleteAll/'+member_id,
					success:function(deleteResult, status, xhr){
						showList();
					},
					error:function(xhr, status, er){
						if(error){
							error(er);
						}
					}
				});				
			}
		});// end of deleteAll
		
		$('#purchase').on('click', function(){
			// 선택된 체크박스만 필터링
		    
			cartService.getList(member_id, function(cartCnt, list){
				console.log("cartCnt: "+cartCnt);
				
				
				if(list == null || list.length == 0){
					return;
				}
				for(let i=0, len=list.length || 0; i<len; i++){
					const quantity = $('#cart-'+list[i].cart_no).find("input[name='quantity']").val();
					const cart = {cart_no: list[i].cart_no,
								quantity: quantity};
					if(list[i].status === '2'){
						alert('품절된 상품이 포함되어 있습니다.');
						return;
					}
					cartService.update(cart, function(result){
						console.log('cart_no: ',list[i].cart_no , result);
						//purchase로 이동
						self.location="/order/purchase";
					});
					
				}
			});//get
		});
		
		// '#selectAll' 체크박스를 클릭했을 때 실행될 함수
	    $('#selectAll').click(function() {
	        // '#selectAll' 체크박스의 체크 상태에 따라
	        if ($(this).is(':checked')) {
	            // 모든 '.product-checkbox' 체크박스를 체크 상태로 만듦
	            $('.product-checkbox').prop('checked', true);
	        } else {
	            // 모든 '.product-checkbox' 체크박스의 체크를 해제함
	            $('.product-checkbox').prop('checked', false);
	        }
	    });
	});
</script>
</html>