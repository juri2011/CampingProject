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
	<style>
		img {
			width: 100px;
			height: 100px;
		}
		#listTbody .btn{
		  	margin: 0 5px;
		  	padding: 5px 10px;
	  	}
	  	.cart-container{
	  		max-width: 800px;
	  		margin: 20px auto;
	  		
	  	}
	  	
	  	.cart-table{
	  		min-width: 800px;
	  		border-spacing: 10px;
	  		border-collapse: separate;
	  	}
	  	.td-image{
	  		max-width: 110px;
	  	}
	  	.td-delete{
	  		min-width: 65px;
	  	}
	</style>
</head>
<body>
	<div id="wrapper">
		<div class="cart-container">
			<h1>cart</h1>
			<table class="cart-table">
				<thead>
					<tr>
						<!-- <th>전체선택<input id="selectAll" type="checkbox" checked/></th> -->
						<th>상품 이미지</th>
						<th>상품명</th>
						<th>가격</th>
						<th>수량</th>
					</tr>
				</thead>
				<tbody id="listTbody">
					
				</tbody>
			</table>
			<button class="btn btn-primary" id="purchase">구매</button>
			<button class="btn btn-danger" id="deleteAll">전체 삭제</button>
				
			<!-- 결제 페이지로 이동 -->
			<form id="goToPurchase" action="/order/purchase" method="post">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			</form>
		</div>
		
	</div>
	
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
				//str += "<td><input class='product-checkbox' type='checkbox' value='"+list[i].cart_no+"' checked/></td>"
				//img src에 list[i].item_img를 넣으려니 405에러 발생(이미지가 아직 없기 때문에)
				str += "<td class='td-image'><img src='/resources/img/" + list[i].fileName + "' alt='" + list[i].item_name + "'></td>";
				str += "	<td>"+list[i].item_name+"</td>";
				str += "	<td>"+list[i].price.toLocaleString()+"원</td>";
				str += "	<td> <input type='number' name='quantity' ";
				str += "value='"+list[i].quantity+"' min='1' max='100'/></td>";
				str += "	<td class='td-delete'><button class='btn btn-danger' onclick='cartDelete("+list[i].cart_no+")'>삭제</button></td></tr>";
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
					beforeSend: function(xhr) {
			            xhr.setRequestHeader(header, token);
			        },
					success:function(deleteResult, status, xhr){
						showList();
					},
					error:function(xhr, status, er){
						console.log("장바구니 목록을 비우는 중 에러 발생");
						if(error){
							error(er);
						}
					}
				});				
			}
		});// end of deleteAll
		
		//클릭하면 장바구니 수량 수정하고 구매페이지로 이동
		$('#purchase').on('click', function(){
			// 선택된 체크박스만 필터링
		    /*
			const selectedCarts = $('.product-checkbox:checked').map(function() {
		        return $(this).val(); // 체크박스의 value (cart_no)를 가져옴
		    }).get(); // jQuery 객체를 일반 배열로 변환
		    
		    if(selectedCarts.length === 0){
		        alert('구매할 상품을 선택해주세요.');
		        return;
		    }
		    */
			//장바구니 DB로부터 장바구니 리스트를 가져옴
			cartService.getList(member_id, function(cartCnt, list){
				console.log("cartCnt: "+cartCnt);
				
				//리스트가 없으면 종료
				if(list == null || list.length == 0){
					return;
				}
				
				//list = list.filter(item => selectedCarts.includes(item.cart_no.toString())); // 선택된 cart_no만 포함하는 항목으로 필터링
				console.log("========================",list);
				//순서대로 cart 객체에 담음
				for(let i=0, len=list.length || 0; i<len; i++){
					//페이지로부터 수량 가져옴
					const quantity = $('#cart-'+list[i].cart_no).find("input[name='quantity']").val();
					//전달할 cart 객체
					const cart = {cart_no: list[i].cart_no,
								quantity: quantity};
					//품절된 상품을 구매하려고 하면 구매페이지 이동 불가
					if(list[i].status === '2'){
						alert('품절된 상품이 포함되어 있습니다.');
						return;
					}
					//위의 조건문 통과했으면 장바구니 DB에서 구매수량 수정
					cartService.update(cart, function(result){
						//콘솔에 출력 
						console.log('cart_no: ',list[i].cart_no , result);
						//self.location="/order/purchase";
						$("#goToPurchase").submit();
					});
				}//end for
				
				//수정 완료했으면 구매 테이블에 삽입(비동기로)
				//이때, list를 보내준다
				/*$.ajax({
					type: 'post',
					url: '/order/addBill',
					contentType: 'application/json',
				    data: JSON.stringify(list),
					success:function(result, status, xhr){
						//purchase로 이동
						
					},
					error:function(xhr, status, er){
						if(error){
							error(er);
						}
					}
				});*/
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