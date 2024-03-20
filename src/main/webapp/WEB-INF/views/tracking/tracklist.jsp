<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
.fURIKx {
	margin-top: 14px;
	padding: 22px 0px 17px;
	border: 1px solid rgb(204, 204, 204);
	color: rgb(51, 51, 51);
	background-color: rgb(238, 238, 238);
	text-align: center;
}

.dWyxZy {
    margin-top: 20px;
    border-bottom: 1px solid rgb(204, 204, 204);
}

.invoice {
	width:100%;
}


.invoice tbody td {
    padding: 6px 0px 6px 30px;
    font-size: 14px;
}
.invoice thead {
	border-bottom: 1px solid
}

.invoice thead th {
    padding-left: 30px;
    font-size: 12px;
    color: rgb(136, 136, 136);
}


.DataArea{
	padding-top: 30px;

}


.fvQHKU {
    width: 100%;
    table-layout: fixed;
}
.invoiceArea{
	padding-top: 30px;
	
}

</style>

<body class="animsition">
	<!-- Product -->
	<section class="bg0 p-t-23 p-b-140">
		<div class="container">
			<div class="p-b-10">
				<h3 class="ltext-103 cl5">배송 정보</h3>
			</div>
			<div class=" fURIKx">
				<div class=" iTIHRg">${info.parcelDate}(${info.weekDay}) ${info.dstatusStr}</div>
				<c:choose>
					<c:when test="${info.dstatus eq '2'}">
						<div class=" kgoUts">고객님이 주문하신 상품이 출고완료 되었습니다.</div>
					</c:when>
					<c:when test="${info.dstatus eq '3'}">
						<div class=" kgoUts">고객님이 주문하신 상품이 배숭중입니다.</div>
					</c:when>

					<c:when test="${info.dstatus eq '4'}">
						<div class=" kgoUts">고객님이 주문하신 상품이 배송완료 되었습니다.</div>
					</c:when>
					<c:otherwise>
						<div class=" kgoUts">고객님이 주문하신 상품이 배송전 입니다.</div>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="DataArea">
				<div class=" bAsSRC"></div>
				<table class=" VdXn">
					<tbody></tbody>
				</table>
				<table class=" fvQHKU">
					<tbody>
						<tr>
							<td class="">
							</td>
							<td class="">
								<table class=" ">
									<tbody>
										<tr>
											<td class="kwBduq">송장번호</td>
											<td class="czgemR">${info.waybill_num}</td>
										</tr>
										<tr>
											<td colspan="2" class="sc-tqnaev-12 kwBduq">
												<span class=blSkIB">
												</span>
												배송업무 중 연락을 받을 수 없습니다.
											</td>
										</tr>
									</tbody>
								</table>
							</td>
							<td class=" lOPTz"><table
									class=" jnfYsZ">
									<tbody>
										<tr>
											<td class=" kwBduq">받는사람</td>
											<td class="czgemR">${info.name}</td>
										</tr>
										<tr>
											<td class=" kwBduq">받는주소</td>
											<td class=" czgemR">${info.addr1} ${info.addr2}</td>
											<td class=" sc-tqnaev-18 czgemR kPbPYa"></td>
										</tr>
										<tr>
											<td class=" kwBduq">배송요청사항</td>
											<td class=" czgemR">${info.memo}</td>
											<td class=" sc-tqnaev-18 czgemR kPbPYa"></td>
										</tr>
									</tbody>
								</table>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="invoiceArea">
				<table id="myPtag2" class="invoice">
					<colgroup>
						<col width="30%">
						<col width="30%">				
						<col width="20%">				
						<col width="20%">				
					</colgroup>
				</table>
			</div>
		</div>
	</section>
	<input type="hidden" id="conpanyCd" value="${info.parcel_cd}">
	<input type="hidden" id="invoiceNumberText" value="${info.waybill_num}">
	
</body>
<script>
// 배송정보와 배송추적 tracking-api
$(document).ready(function(){
    var myKey = "1IpHWyVmFmT5fjba9CLngQ"; // sweet tracker에서 발급받은 자신의 키 넣는다.

	var t_code = $('#conpanyCd').val();
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
	            
	            
	            var myTracking="<tbody>";
	            var header ="";
	            header += ('<thead>');                
	            header += ('<tr>');                
	            header += ('<th>'+"시간"+'</th>');
	            header += ('<th>'+"현재위치"+'</th>');
	            header += ('<th>'+"전화번호"+'</th>');         
	            header += ('<th>'+"배송상태"+'</th>');
	            header += ('</tr>');
	            header += ('</thead>');
	            
	            $.each(trackingDetails,function(key,value) {
	            	myTracking += ('<tr>');
	                myTracking += ('<td>'+value.timeString+'</td>');
	                myTracking += ('<td>'+value.where+'</td>');
	                myTracking += ('<td>'+value.telno+'</td>');                     
	                myTracking += ('<td>'+value.kind+'</td>');
	                myTracking += ('</tr>');                                    

	            });
                myTracking += ('</tbody>');
	            
	            $("#myPtag2").html(header+myTracking);
	            
	        },
			error: function (data) {
				alert("접속 도중 오류가 발생했습니다.");
				console.log(data);
			}

	    
	    });
});


</script>

