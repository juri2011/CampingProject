<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<head>
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
</head>
<style>
.title {
	font-size: 35px;
}

input {
	display: inline-block;
	border: 1px solid black;
	width: 300px;
}

#mainImage {
	border: none;
}

#subImages {
	border: none;
}

.all {
	margin-top: 1em;
	position: relative;
}

.all p {
	margin-right: 0;
	display: inline-block;
}

#pname input {
	width: 400px;
}

#main {
	height: auto;
	/* margin-left: 100px; */
	text-align: center;
}

.image {
	
}

.sub {
	
}
#main2{

	

}
.v-line {
	border-left: thick solid #32a1ce;
	display: inline-block;
	height: 50px;
}

#uploadResult {
	display: inline-block;
}

#real {
	/* display: inline-block;
 */
	
}

#real input {
	width: 200px;
}

#price {
	display: inline-block;
}

#stock {
	display: inline-block;
}

p {
	display: inline-block;
}

.image-wrap {
	display: inline-block;
}
</style>
<div id="main">
	<div id="main2">
		<p class="title">상품 등록</p>
		<div>
			<p>카테고리</p>
			<select name="category"  class="category">
				<option value="skincare">skincare</option>
				<option value="base">base</option>
				<option value="lib">lib</option>
				<option value="eye">eye</option>
				<option value="cheek">cheek</option>
			</select>
		</div>
		<div>
			<p>피부타입</p>
			<select name="skintype" class="skintype">
				<option value="oily">지성</option>
				<option value="middle">복합성</option>
				<option value="dry">건성</option>
			</select>
		</div>
		<div id="pname" class="all">
			<p>상품이름</p>
			<input type="text" name="pname" id="pnameReal">
		</div>
		<div id="real">
			<div id="price" class="all">
				<p>상품가격</p>
				<input type="text" name="sellPrice" id="priceReal" pattern="[0-9]+">
			</div>
	
			<div id="stock" class="all">
				<p>상품수량</p>
				<input type="number" name="stock" placeholder="0" id="stockReal">
	
				<div class="result"></div>
			</div>
		</div>
	
		<div class="image">
			<div class="image-wrap">
				<p>메인이미지</p>
				<br> <input type="file" name="uploadFile" id="mainImage" enc="multipart-formdata">
			</div>
	
			<div class='v-line'></div>
			<div id="previewContainer" style="width: 30%;"></div>
		</div>
		<div class="sub">
			<div class="image-wrap">
				<p>서브이미지</p>
				<br> <input type="file" name="uploadSubFile" id="subImages" multiple>
			</div>
			<div class='v-line'></div>
			<div id="uploadSubResult" style="width: 30%;">
				<ul>
				
				</ul>
			</div>
		</div>
	</div>


	<button id="uploadBtn" onClick="submitData()">제출</button>
	<button id="resetBtn">취소</button>
</div>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

function submitData(){
	var pname = $("#pnameReal").val();
	var price = $("#priceReal").val();
	var stock = $('#stockReal').val();
	var category = $('.category').val();
	var skintype = $('.skintype').val();
	var uploadBtn = $("#uploadBtn");
	
	console.log(pname);
	console.log(price);
	console.log(stock);
	console.log(category);
	console.log(skintype);

	if (join()){
		$.ajax({
			url:"/registerGoods",		// servlet 
			type: "post",
			dataType: 'json',
			data: {"sellPrice" : price, "pname": pname, "stock": stock, "skintype": skintype, "category": category},
			beforeSend: function(xhr) { //XMLHttpRequest (XHR)은 AJAX 요청을 생성하는 JavaScript API이다. XHR의 메서드로 브라우저와 서버간의 네트워크 요청을 전송할 수 있다.
				xhr.setRequestHeader(header, token); //csrf 전송하지 않으면 아예 ajax가 되지 않는 문제가 생김.
			},
			success:function(data){
				console.log("성공" + data);
				console.log(data);
		//		loadImage(data);
				loadSubImage(data);
//				location.href = '/registerGoods'
			},
			error:function(){
				alert("error");
			}
		});
	}	
/*	
	$.ajax({
			url: '/registerGoods',
			processData: false,
			contentType: false,  //이것때문에 오류. contentType: "application/json",파일보낼 때 이렇게 씀
			data: {"price": price},
			type: 'post',
			dataType: 'json',
			beforeSend: function(xhr) { //XMLHttpRequest (XHR)은 AJAX 요청을 생성하는 JavaScript API이다. XHR의 메서드로 브라우저와 서버간의 네트워크 요청을 전송할 수 있다.
				xhr.setRequestHeader(header, token); //csrf 전송하지 않으면 아예 ajax가 되지 않는 문제가 생김.
			},
			success: function(result){
				console.log(result);
				alert('upload');
				
				showUploadedFile(result);
				$(".uploadDiv").html(cloneObj.html());
			},
			error: function(error){
				console.log(error);
			}
		});*/
}

function showImage(fileCallPath){
	//alert(fileCallPath);
	
	$(".bigPictureWrapper").css("display", "flex").show();
	
	$(".bigPicture")
	.html("<img src='/display?fileName=" + encodeURI(fileCallPath) + "'>")
	.animate({width: '100%', height: '100%'}, 1000);
}

$(".bigPictureWrapper").on("click", function(e){
	$(".bigPicture").animate({width: '0%', height: '0%'}, 1000);
	setTimeout(() => {
		$(this).hide();	
	},1000);
})

function loadImage(Data){
		var formData = new FormData();
		var inputFile = $("input[name='uploadFile']");
		var files = inputFile[0].files;
		// Add File Data to formData
		for(var i = 0; i < files.length; i++){
			if(!checkExtension(files[i].name, files[i].size)){
				return false;
			}
			
			formData.append("uploadFile", files[i]);
		}
		console.log('냐냐냐냐');
		console.log(Data);
		formData.append("gno", Data.gno);
		$.ajax({
			url: '/uploadAjaxAction',
			processData: false,
			contentType: false,
			data: formData,
			type: 'POST',
			dataType: 'json',
			beforeSend: function(xhr) { //XMLHttpRequest (XHR)은 AJAX 요청을 생성하는 JavaScript API이다. XHR의 메서드로 브라우저와 서버간의 네트워크 요청을 전송할 수 있다.
				xhr.setRequestHeader(header, token); //csrf 전송하지 않으면 아예 ajax가 되지 않는 문제가 생김.
			},
			success: function(result){
				//console.log(result);
				//console.log(formData);
				showUploadedFile(result);
				$(".uploadDiv").html(cloneObj.html());
			}
		});  //$.ajax
	}; 

	function loadSubImage(Data){
		var formData = new FormData();
		var inputFile = $("input[name='uploadSubFile']");
		var files = inputFile[0].files;

		// Add File Data to formData
		for(var i = 0; i < files.length; i++){
			if(!checkExtension(files[i].name, files[i].size)){
				return false;
			}
			
			formData.append("uploadFile", files[i]);
		}
	
		formData.append("gno", Data.gno);
		console.log(formData);
		console.log(files);


		$.ajax({
			url: '/uploadAjaxActionSub',
			processData: false,
			contentType: false,
			data: formData,
			type: 'POST',
			dataType: 'json',
			beforeSend: function(xhr) { //XMLHttpRequest (XHR)은 AJAX 요청을 생성하는 JavaScript API이다. XHR의 메서드로 브라우저와 서버간의 네트워크 요청을 전송할 수 있다.
				xhr.setRequestHeader(header, token); //csrf 전송하지 않으면 아예 ajax가 되지 않는 문제가 생김.
			},
			success: function(result){
//				console.log(result);
//				console.log(formData);
				showUploadedFile(result);
				$(".uploadDiv").html(cloneObj.html());
			}
		});  //$.ajax
	}; 
	
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	var maxSize = 5242880;  //5MB
	function checkExtension(fileName, fileSize){
		
		if(fileSize >= maxSize){
			alert('파일 사이즈 초과');
			return false;
		}
		
		if(regex.test(fileName)){
			alert("해당 종류의 파일은 업로드할 수 없습니다.");
			return false;
		}
		return true;
	}
	
	
	
	function join() {
		
		const name = document.querySelector("#pnameReal");
		const price =document.querySelector("#priceReal");
		const stock = document.querySelector("#stockReal");
		const main = document.querySelector("#mainImage");
		const sub = document.querySelector("#subImages");
		
		
		if (!name.value) {
			alert("상품명을 입력해주세요.");
			name.focus();
			return false;
		}
		if (!price.value || price < 0) {
			alert("가격을 입력해주세요.");
			price.focus();
			return false;
		}
		if (!stock.value) {
			alert("재고를 입력해주세요.");
			stock.focus();
			return false;
		}


		if (!main.value) {
			alert("메인 이미지를 삽입해 주세요.");
			return false;
		}

		if (!sub.value) {
			alert("서브 이미지를 삽입해주세요.");
			return false;
		}
		return true;
		
	}
$(document).ready(function(){

	

	const mainImageInput = document.querySelector("#mainImage");
	const previewContainer = document.getElementById("previewContainer");
	
	
	mainImageInput.addEventListener("change", (event) => {
        const file = event.target.files[0];
        
        if (file) {
            // FileReader 인스턴스 생성
            const reader = new FileReader();

            // 파일 읽기 성공 시 미리보기 생성
            reader.onload = (e) => {
                const imagePreview = document.createElement("img");
                imagePreview.src = e.target.result;
                imagePreview.style.maxWidth = "200px"; // 미리보기 이미지 크기 제한 (선택사항)
                previewContainer.innerHTML = ""; // 기존 미리보기 제거
                previewContainer.appendChild(imagePreview);
            };

            // 파일 읽기 시작
            reader.readAsDataURL(file);
        }
    });
	

	
	var cloneObj = $(".uploadDiv").clone();
	
/* 	$('#uploadBtn').on("click", function(e){
		var formData = new FormData();
		var inputFile = $("input[name='uploadFile']");
		var files = inputFile[0].files;
		console.log(files);
		// Add File Data to formData
		for(var i = 0; i < files.length; i++){
			if(!checkExtension(files[i].name, files[i].size)){
				return false;
			}
			
			formData.append("uploadFile", files[i]);
		}
		$.ajax({
			url: '/uploadAjaxAction',
			processData: false,
			contentType: false,
			data: formData,
			type: 'POST',
			dataType: 'json',
			beforeSend: function(xhr) { //XMLHttpRequest (XHR)은 AJAX 요청을 생성하는 JavaScript API이다. XHR의 메서드로 브라우저와 서버간의 네트워크 요청을 전송할 수 있다.
				xhr.setRequestHeader(header, token); //csrf 전송하지 않으면 아예 ajax가 되지 않는 문제가 생김.
			},
			success: function(result){
				console.log(result);
				alert('upload');
				
				showUploadedFile(result);
				$(".uploadDiv").html(cloneObj.html());
			}
		});  //$.ajax
	}); 
	*/
	var uploadResult = $(".uploadResult ul");
	
	function showUploadedFile(uploadResultArr){
		
		var str = "";
		
		$(uploadResultArr).each(
				function(i, obj){
					
					if(!obj.image){
						
						var fileCallPath = encodeURIComponent( obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
						
						var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
						
						str += "<li><div><a href='/download?fileName=" + fileCallPath + "'>" + "<img src='/resources/img/attach.png'>" + obj.fileName + "</a>"
								+ "<span data-file=\'" + fileCallPath + "\' data-type='file'> x </span>"
								+ "</div></li>";
					}else{
						//str += "<li>" + obj.fileName + "</li>";
						
						var fileCallPath = encodeURIComponent( obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
						
						var originPath = obj.uploadPath + "\\" + obj.uuid + "_" + obj.fileName;
						
						originPath = originPath.replace(new RegExp(/\\/g),"/");
						
						str += "<li><a href=\"javascript:showImage(\'" + originPath + "\')\">" + 
						"<img src='display?fileName=" + fileCallPath + "'></a>"
								+ "<span data-file=\'" + fileCallPath + "\' data-type='image'> x </span>" + "</li>";
					}
		});
			
		uploadResult.append(str);
	}
	
	$(".uploadResult").on("click", "span", function(e){
		
		var targetFile = $(this).data("file");
		var type = $(this).data("type");
		console.log(targetFile);
		
		$.ajax({
			
			url: '/deleteFile',
			data: {fileName: targetFile, type: type},
			dataType: 'text',
			type: 'POST',
			success: function(result){
				alert(result);
			}
		});  //$.ajax
	});
	
});  
</script>
