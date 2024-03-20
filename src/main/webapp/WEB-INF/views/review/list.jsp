<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


	<!-- 상품평 -->
<div class="review" style="width: 70%">
	<p class="desc">상품의 사용후기를 적어주세요.</p>
	<ul>
		<c:forEach var="item" items="${reviewList}" varStatus="stat">							
			<li>
		        <div>
		   			<fieldset>
		   				<c:forEach var="num" begin="1" end="5">
		   					<c:choose>
		   						<c:when test="${num <= item.score}">
								    <input type="radio" name="score" value="${num}" id="rate${stat.count}_${num}"  checked readonly><label for="rate${stat.count}_${num}" class="active">⭐</label>
							    </c:when>
							    <c:otherwise>
									<input type="radio" name="score" value="${num}" id="rate${stat.count}_${num}"  readonly><label for="rate${stat.count}_${num}" readonly>⭐</label>
							    </c:otherwise>
						    </c:choose>
						</c:forEach>
					 </fieldset>
		            <span>${item.memId} ${item.regiDateStr} </span>
		        </div>
		        <h3>${item.title}</h3>
			    ${item.content}
				
		    </li>
	    </c:forEach>
	</ul>
</div> 	
		
<div id="PAGE_NAVI"></div>
<input type="hidden" id="PAGE_INDEX" name="PAGE_INDEX" />

<script>	
	 function fn_Review(url,data){
		var form = document.createElement("form");
		form.setAttribute("method", "get");
		form.setAttribute("action", url);
	    var parentNOInput = document.createElement("input");
	    parentNOInput.setAttribute("type","hidden");
	    parentNOInput.setAttribute("value",data);
	    parentNOInput.setAttribute("name","gno");

	    form.appendChild(parentNOInput);
	 	document.body.appendChild(form);
		    
		 console.log(form);
		 	
		form.submit();
	 }
</script>
	
    
    
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
    <script src="https://kit.fontawesome.com/20962f3e4b.js" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>