<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<body>
	
	<div class="admin_content_wrap">
		<div class="admin_content_subject">
			<span>상품 관리</span>
		</div>
	</div>



<script>
$(document).ready(function(){
    
	let eResult =  '<c:out value="${enroll_result}"/>';
    
    checkResult(eResult);

    function checkResult(result){
        if(result === ''){
            return;
        }
        
        alert("상품 '" + result + "'을 등록하였습니다."); 
    }
});


</script>
</body>
</html>