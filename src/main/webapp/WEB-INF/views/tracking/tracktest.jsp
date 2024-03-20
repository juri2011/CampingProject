<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<script>
$(document).ready(function(){
    var myKey = "1IpHWyVmFmT5fjba9CLngQ"; // sweet tracker에서 발급받은 자신의 키 넣는다.
    
        // 택배사 목록 조회 company-api
        $.ajax({
            type:"GET",
            dataType : "json",
            url:"http://info.sweettracker.co.kr/api/v1/companylist?t_key="+myKey,
            success:function(data){
                    
                    // 방법 1. JSON.parse 이용하기
                    var parseData = JSON.parse(JSON.stringify(data));
                     console.log(parseData.Company); // 그중 Json Array에 접근하기 위해 Array명 Company 입력
                    
                    // 방법 2. Json으로 가져온 데이터에 Array로 바로 접근하기
                    var CompanyArray = data.Company; // Json Array에 접근하기 위해 Array명 Company 입력
                    console.log(CompanyArray); 
                    
                    var myData="";
                    $.each(CompanyArray,function(key,value) {
                            myData += ('<option value='+value.Code+'>' +'key:'+key+', Code:'+value.Code+',Name:'+value.Name + '</option>');                        
                    });
                    $("#tekbeCompnayList").html(myData);
            }
        });
        // 배송정보와 배송추적 tracking-api
        $("#myButton1").click(function() {
            var t_code = $('#tekbeCompnayList option:selected').attr('value');
            var t_invoice = $('#invoiceNumberText').val();
            $.ajax({
                type:"GET",
                dataType : "json",
                url:"http://info.sweettracker.co.kr/api/v1/trackingInfo?t_key="+myKey+"&t_code="+t_code+"&t_invoice="+t_invoice,
                success:function(data){
                    console.log(data);
                    var myInvoiceData = "";
                    if(data.status == false){
                        myInvoiceData += ('<p>'+data.msg+'<p>');
                    }else{
                        myInvoiceData += ('<tr>');                
                        myInvoiceData += ('<th>'+"보내는사람"+'</td>');                     
                        myInvoiceData += ('<th>'+data.senderName+'</td>');                     
                        myInvoiceData += ('</tr>');     
                        myInvoiceData += ('<tr>');                
                        myInvoiceData += ('<th>'+"제품정보"+'</td>');                     
                        myInvoiceData += ('<th>'+data.itemName+'</td>');                     
                        myInvoiceData += ('</tr>');     
                        myInvoiceData += ('<tr>');                
                        myInvoiceData += ('<th>'+"송장번호"+'</td>');                     
                        myInvoiceData += ('<th>'+data.invoiceNo+'</td>');                     
                        myInvoiceData += ('</tr>');     
                        myInvoiceData += ('<tr>');                
                        myInvoiceData += ('<th>'+"송장번호"+'</td>');                     
                        myInvoiceData += ('<th>'+data.receiverAddr+'</td>');                     
                        myInvoiceData += ('</tr>');                                       
                    }
                    
                    
                    $("#myPtag").html(myInvoiceData)
                    
                    var trackingDetails = data.trackingDetails;
                    
                    
                    var myTracking="";
                    var header ="";
                    header += ('<tr>');                
                    header += ('<th>'+"시간"+'</th>');
                    header += ('<th>'+"장소"+'</th>');
                    header += ('<th>'+"유형"+'</th>');
                    header += ('<th>'+"전화번호"+'</th>');                     
                    header += ('</tr>');     
                    
                    $.each(trackingDetails,function(key,value) {
                        myTracking += ('<tr>');                
                        myTracking += ('<td>'+value.timeString+'</td>');
                        myTracking += ('<td>'+value.where+'</td>');
                        myTracking += ('<td>'+value.kind+'</td>');
                        myTracking += ('<td>'+value.telno+'</td>');                     
                        myTracking += ('</tr>');                                    
                    });
                    
                    $("#myPtag2").html(header+myTracking);
                    
                }
            });
        });
        
});
</script>
</head>
<body>

<div class="container">
  <h2>상품 리스트</h2>
  <c:if test="${!empty orderList}">
    <table class="table">
    <thead>
      <tr>
        <th></th>
        <th>유저</th>
        <th>가격</th>
        <th>등록일</th>
        <th>택배회사명</th>
        <th>송장</th>
      </tr>
    </thead>
    <tbody>
    <c:forEach var="good" items="${orderList}">
      <tr>
        <td></td>
        <td>${good.mem_id}</td>
        <td>${good.totprice}</td>
        <td>${good.regidate}</td>
        <td>	
        	<span id="tekbeCompnayName">택배회사명: </span>
			<select id="tekbeCompnayList" name="tekbeCompnayList">
			</select>
		</td>
        <td>        
        	<span id="invoiceNumber">운송장번호: </span>
			<input type="text" id="invoiceNumberText" name="invoiceNumberText"><br/><br/>
			<button id="myButton1">등록 </button>    
        </td>
      </tr>
    </c:forEach>
    </tbody>
  </table>
  </c:if>        

</div>

	<span id="tekbeCompnayName">택배회사명: </span>
	<select id="tekbeCompnayList" name="tekbeCompnayList">
	</select>
		
		<br/><br/>

	<span id="invoiceNumber">운송장번호: </span>
	<input type="text" id="invoiceNumberText" name="invoiceNumberText"><br/><br/>
	<button id="myButton1">택배 조회하기 </button>
	<br/>
	<br/>
	<div>
		<table id="myPtag"></table>
	</div>
	<br/>
	<div>
		<table id="myPtag2"></table>
	</div>
	
	
</body>
</html>