const cartService = (function(){

    function getList(mid, callback, error){
		const member_id = mid;
		
		//getJSON : JSON 목록 호출(json 형태가 필요하므로 URL확장자 .json)
		$.getJSON("/cart/cartList/" + member_id + ".json", //파라미터 1: url
			function(data){ // 파라미터2: 성공
				if(callback){//callback 함수가 있으면
					//callback(data); 댓글 목록만 가져옴
					callback(data.cartCnt, data.cartList);//리뷰 숫자와 목록을 가져옴
				}
			}).fail(function(xhr, status, err){ //파라미터3 : 실패
				if(error){ // error함수가 있으면
					error();
				}
			});
	}

    function remove(cart_no, callback, error){
        $.ajax({
			type: 'delete',
			url: '/cart/'+cart_no,
			success:function(deleteResult, status, xhr){
				if(callback){
					callback(deleteResult);
				}
			},
			error:function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		});
    }

    function update(cart, callback, error){
		console.log("cart_no: "+cart.cart_no);
		$.ajax({
			type: 'put',
			url:'/cart/'+cart.cart_no,
			data: JSON.stringify(cart),
			contentType: "application/json; charset=utf-8",
			success: function(result, status, xhr){
				if(callback) callback(result);
			},
			error: function(xhr, status, er){
				if(error) error(er);
			}
		});
	}

    return{
        remove: remove,
        getList: getList,
        update: update
    };
})();