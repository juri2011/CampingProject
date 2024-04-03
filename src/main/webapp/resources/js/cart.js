const cartService = (function(){
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

    return{
        remove: remove
    };
})();