<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="http://code.jquery.com/jquery-1.7.js"></script>
<script src="<c:url value='/resources/js/common.js'/>" charset="utf-8"></script>
<script src="/resources/ckeditor2/ckeditor.js"></script>

<style>
@CHARSET "UTF-8";

a:link, a:visited {text-decoration: none; color: #656565;}

.board_list {width:100%;border-top:2px solid #252525;border-bottom:1px solid #ccc}
.board_list thead th:first-child{background-image:none}
.board_list thead th {border-bottom:1px solid #ccc;padding:12px 0 13px 0;color:#3b3a3a;vertical-align:middle}
.board_list tbody td {border-top:1px solid #ccc;padding:10px 0;text-align:center;vertical-align:middle}
.board_list tbody tr:first-child td {border:none}
.board_list tbody td.title {text-align:left; padding-left:20px}
.board_list tbody td a {display:inline-block}

.board_view {width:50%;border-top:2px solid #252525;border-bottom:1px solid #ccc}
.board_view tbody th {text-align:left;background:#f7f7f7;color:#3b3a3a}
.board_view tbody th.list_tit {font-size:13px;color:#000;letter-spacing:0.1px}
.board_view tbody .no_line_b th, .board_view tbody .no_line_b td {border-bottom:none}
.board_view tbody th, .board_view tbody td {padding:15px 0 16px 16px;border-bottom:1px solid #ccc}
.board_view tbody td.view_text {border-top:1px solid #ccc; border-bottom:1px solid #ccc;padding:45px 18px 45px 18px}
.board_view tbody th.th_file {padding:0 0 0 15px; vertical-align:middle}

a {
  text-decoration: none;
  color: #666;
}

h1 {
    text-align: center;
    padding: 50px 0;
    font-weight: normal;
    font-size: 2em;
    letter-spacing: 10px;
}  

.pad_5 {padding: 5px;}
.wdp_90 {width:90%}
.btn {border-radius:3px;padding:5px 11px;color:#fff !important; display:inline-block; background-color:#6b9ab8; border:1px solid #56819d;vertical-align:middle}

#listbutton {
	padding-bottom: 40px;
}

div.col-sm-6.col-lg-3.p-b-50 {
	padding-top: 20px;
}
</style>
</head>
<body>



<br><br>
<div align="center">
<h2>${title}</h2>
</div>

<br><br>
<div align="center">
	<form name="frm" id="frm" enctype="multipart/form-data" method="post">
		<table align="center" border="0">
			<tr>
				<th>제목 </th>
				<td>
					<input type="text" id="pname" name="title" placeholder="제목" size="40" 
					style="padding:10px;" value=<c:if test="${type eq 'modify'}">"${answer.title}"</c:if>>
				</td>
			</tr>
				
			<tr>
				<th>상세내용</th>
				<td>
					<textarea rows="30" cols="100" id="content" name="content">
					<c:if test="${type eq 'modify'}">${answer.content}</c:if>
					</textarea>
				</td>
			</tr>
			<tr>
				<th>프로세스 단계</th>
				<td>
					<select name="status">
						<option value="1">처리대기</option>
						<option value="2">처리중</option>
						<option value="3">처리완료</option>
					</select>
				</td>
			</tr>
			<input type="hidden" id="glno" name="glno" value="${glno}">
			<c:if test="${type eq 'modify' }"><input type="hidden" name="anscno" value="${answer.anscno }"></c:if>
		</table>
	
		<br>	
		<div align="center">
			<c:if test="${type eq 'write'}"><a href="#this" class="btn" id="write" onClick="fn_chk()">작성하기</a></c:if>
			<c:if test="${type eq 'modify'}"><a href="#this" class="btn" id="update" onClick="fn_chk()">수정하기</a></c:if>
			<a href="#" class="btn">이전화면</a>
		</div>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	</form>

</div>
<br><br><br>
<!-- commandForm  -->
<form id="commonForm" name="commonForm"></form>

<script type="text/javascript">
function addOption(){
	
	const input = $("#option");
	const inputVal = input.val();
	const option_list = $("#option_list");

	option_list.text(option_list.text() + inputVal + "\n");
	input.val("");
}

$(function(){
	CKEDITOR.replace('content',{
        width:'120%',
        height:'400px',
		filebrowserUploadUrl: "<c:url value="/fileupload.do?"/>${_csrf.parameterName}=${_csrf.token}"
	});
});

	var gfv_count = 1;

$(document).ready(function() {

	$("#write").on("click", function(e){ //작성하기 버튼
		e.preventDefault();
		fn_insertBoard();
	});

	$("#update").on("click", function(e){ //수정하기 버튼
		e.preventDefault();
		fn_updateGoods();	
	});

	const mainImageInput = document.querySelector("#mainImage");
	const previewContainer = document.getElementById("previewContainer");
	
	
	mainImageInput.addEventListener("change", (event) => {
        const file = event.target.files[0];
        
        if (file) {
            // FileReader 인스턴스 생성
            const reader = new FileReader();
			alert("성공");
            // 파일 읽기 성공 시 미리보기 생성
            reader.onload = (e) => {
                const imagePreview = document.createElement("img");
                alert("성공");
                imagePreview.src = e.target.result;
                imagePreview.style.maxWidth = "200px"; // 미리보기 이미지 크기 제한 (선택사항)
                previewContainer.innerHTML = ""; // 기존 미리보기 제거
                previewContainer.appendChild(imagePreview);
            };

            // 파일 읽기 시작
            reader.readAsDataURL(file);
        }
    });		
});

function fn_updateGoods(){
	var comSubmit = new ComSubmit("frm");
	comSubmit.setUrl("<c:url value='/admin/updatepro.do' />");
	let editorContent=CKEDITOR.instances.content.getData();
	let convertContent = editorContent.replace(/(<([^>]+)>)/ig, "");
	comSubmit.submit();
}

function fn_insertBoard() { // 유효성체크

	var comSubmit = new ComSubmit("frm"); // 객체생성
	comSubmit.setUrl("<c:url value='/admin/reganswer.do' />"); // url설정
	
	// 게시글 내용 필요
 	let editorContent=CKEDITOR.instances.content.getData();
    
 	if(!$("#pname").val()){
        alert("제목를 입력해주세요.");
        $("#pname").focus();
        return false;
    }
	
	if(editorContent =='' 
            || editorContent.length ==0){
        alert("내용을 입력해주세요.");
        $("#content").focus();
        return false;
    }
    
    let convertContent = editorContent.replace(/(<([^>]+)>)/ig, "");
    
    let result = confirm("답변을 등록하시겠습니까?");
    
    if(result){
    	alert("답변이 등록되었습니다.")
    } else {
    	return false;
    }
    
	comSubmit.submit();
}

function fn_chk() {
	
	
	var obj = $("[name=PICK]");
	var chkArray = new Array(); //배열 선언

	$('input:checkbox[name=PICK]:checked').each(function() { //체크된 값을 가져옴
		chkArray.push(this.value);
	});
	$('#GOODS_PICK').val(chkArray);

	//alert($('#GOODS_PICK').val());

	
	var obj1 = $("[name=SIZE]");
	var chkArray1 = new Array(); //배열 선언

	$('input:checkbox[name=SIZE]:checked').each(function() { //체크된 값을 가져옴
		chkArray1.push(this.value);
	});
	$('#GOODS_ATT_SIZE').val(chkArray1);

	//alert($('#GOODS_ATT_SIZE').val());
		
}

</script>

</body>
</html>