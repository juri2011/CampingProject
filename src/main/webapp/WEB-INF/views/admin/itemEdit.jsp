<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style type="text/css">
h1 {
	text-align: center;
}

/* 관리자 컨텐츠 메인 영역 */
.admin_content_main {
	width: 70%;
	margin: 0 auto;
}

.form_section {
	width: 95%;
	margin-left: 2%;
	margin-top: 20px;
	border: 1px solid #dbdde2;
	background-color: #efefef;
}

.form_section_title {
	padding: 20px 35px;
}

.form_section_title label {
	display: block;
	font-size: 20px;
	font-weight: 800;
}

.form_section_content {
	padding: 20px 35px;
	border-top: 1px solid #dbdde2;
}

.form_section_content input {
	width: 80%;
	height: 25px;
	font-size: 20px;
	padding: 5px 1%;
}

.form_section_content select {
	width: 98%;
	height: 35px;
	font-size: 20px;
	text-align-last: center;
}

/* 버튼 영역 */
.btn_section {
	text-align: center;
	margin: 80px 0;
}

.btn {
	min-width: 180px;
	padding: 4px 30px;
	font-size: 25px;
	font-weight: 600;
	line-height: 40px;
}

.update_btn {
	background-color: #dbdde2;
	margin-left: 15px;
}

#updateBtn:hover {
	background-color: #c9cbd0;
}

#result_card img {
	max-width: 100%;
	height: auto;
	display: block;
	padding: 5px;
	margin-top: 10px;
	margin: auto;
}

#result_card {
	position: relative;
}

.imgDeleteBtn {
	position: absolute;
	top: 0;
	right: 5%;
	background-color: #ef7d7d;
	color: wheat;
	font-weight: 900;
	width: 30px;
	height: 30px;
	border-radius: 50%;
	line-height: 26px;
	text-align: center;
	border: none;
	display: block;
	cursor: pointer;
}

/* 상품명 선택란 가로 크기 조정 */
.form_section_content input[name='item_name'] {
	width: 50%; /* 원하는 가로 크기로 조정하세요 */
}

/* 판매 카테고리 선택란 가로 크기 조정 */
.form_section_content select[name='category'] {
	width: 15%; /* 원하는 가로 크기로 조정하세요 */
}

/* 판매수량 선택란 가로 크기 조정 */
.form_section_content input[name='amount'] {
	width: 5%; /* 원하는 가로 크기로 조정하세요 */
}

/* 판매가격 선택란 가로 크기 조정 */
.form_section_content input[name='price'] {
	width: 10%; /* 원하는 가로 크기로 조정하세요 */
}

/* 판매상태 선택란 가로 크기 조정 */
.form_section_content select[name='status'] {
	width: 15%; /* 원하는 가로 크기로 조정하세요 */
}

/* 상품 이미지명 선택란 가로 크기 조정 */
.form_section_content input[name='img_name'] {
	width: 15%; /* 원하는 가로 크기로 조정하세요 */
}
</style>
</head>
<body>
	<div class="admin_content_main">
		<h1>상품정보 수정페이지</h1>
		<form action="/admin/itemEdit" method="post" id="editForm">
			<div class="form_section">
				<div class="form_section_title">
					<label>상품명</label>
				</div>
				<div class="form_section_content">
					<input name="item_name" value="<c:out value='${item.item_name}' />">
				</div>
			</div>
			<div class="form_section">
				<div class="form_section_title">
					<label>카테고리</label>
				</div>
				<div class="form_section_content">
					<select name="category">
						<option value="">선택하세요</option>
						<c:forEach items="${categories}" var="category">
							<option value="${category}"
								<c:if test="${category eq item.category}">selected</c:if>>${category}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="form_section">
				<div class="form_section_title">
					<label>상품수량</label>
				</div>
				<div class="form_section_content">
					<input type="number" id="amount" name="amount"
						value="<c:out value='${item.amount}'/>" min="1" max="100" />
				</div>
			</div>
			<div class="form_section">
				<div class="form_section_title">
					<label>판매상태</label>
				</div>
				<div class="form_section_content">
					<select name="status">
						<option value="">선택하세요</option>
						<option value="1"
							<c:if test="${item.status eq '1'}">selected</c:if>>판매중</option>
						<option value="2"
							<c:if test="${item.status eq '2'}">selected</c:if>>판매중단(품절)</option>
					</select>
				</div>
			</div>
			<div class="form_section">
				<div class="form_section_title">
					<label>상품 가격</label>
				</div>
				<div class="form_section_content">
					<input type="text" id="price" name="price"
						value="<c:out value='${item.price}' />">
				</div>
			</div>
			<input type="hidden" name="item_no"
				value="<c:out value='${item.item_no}' />">
			<div class="form_section">
				<div class="form_section_title">
					<label>상품 이미지</label>
				</div>
				<div class="form_section_content">
					<input type="file" id="fileItem" name='uploadFile'
						style="height: 30px;">
					<div id="uploadResult"></div>

				</div>
				<div class="form_section">
					<div class="form_section_title">
						<label>저장된 이미지명</label>
					</div>
					<div class="form_section_content">
						<input type="text" id="currentImageName"
							value="<c:out value='${item.imageList[0].fileName}' />" readonly>
					</div>
				</div>
			</div>
			<div class="form_section">
				<div class="form_section_title">
					<label>상품 소개</label>
				</div>
				<div class="form_section_content">
					<input name="content" value="<c:out value='${item.content}' />">
				</div>
			</div>
			<input type="hidden" name="modDate" value="<%=new java.util.Date()%>">
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" />

		</form>
		<div class="btn_section">
			<button id="cancelBtn" class="btn">취 소</button>
			<button id="updateBtn" class="btn update_btn">수 정</button>
		</div>
	</div>
	<script>
        let editForm = $("#editForm")

        /* 취소 버튼 */
        $("#cancelBtn").click(function() {
            location.href = "/admin/itemManager"
        });

        /* 상품 수정 버튼 */
        $("#updateBtn").on("click", function(e) {
            e.preventDefault();

            // 상품 가격 값을 가져와서 숫자로 변환
            let priceInput = document.getElementById('price');
            let priceValue = parseInt(priceInput.value.replace(/,/g, ''), 10); // 쉼표(,) 제거 후 숫자로 변환

            // 변환된 값을 다시 입력란에 설정
            priceInput.value = priceValue;
            

            // 폼 제출
            editForm.submit();
        });

        /* 판매 상태 미선택시 */
        $(document).ready(function() {
            $("form").submit(function(event) {
                const selectedStatus = $("select[name='status']").val();
                if (selectedStatus === "") {
                    alert("판매상태를 선택해주세요.");
                    event.preventDefault(); // 폼 제출을 취소합니다.
                }
            });
        });

        /* 이미지 업로드 */
        $("input[type='file']").on("change", function(e) {
            /* 이미지 존재시 삭제 */
            if ($(".imgDeleteBtn").length > 0) {
                deleteFile();
            }

            //FormData객체를 생성하여 첨부파일을 FormData에 저장을 하고 FormData 자체를 서버로 전송
            let formData = new FormData();
            let fileInput = $('input[name="uploadFile"]');
            let fileList = fileInput[0].files;
            let fileObj = fileList[0];

            if (!fileCheck(fileObj.name, fileObj.size)) {
                return false;
            }
            //FormData 객체에 데이터를 추가
            formData.append("uploadFile", fileObj);

            $.ajax({
                url : '/admin/uploadAjaxAction',
                beforeSend: function(xhr) {
                    xhr.setRequestHeader(header, token);
                },
                processData : false,
                contentType : false,
                data : formData,
                type : 'POST',
                dataType : 'json',
                success : function(result) {
                    console.log(result);
                    showUploadImage(result);
                },
                error : function(result) {
                    alert("이미지 파일이 아닙니다.");
                }
            });

        });

        /* 파일 체크 */
        let regex = new RegExp("(.*?)\.(jpg|png|JPG|PNG)$");
        let maxSize = 1048576; //1MB    

        function fileCheck(fileName, fileSize) {

            if (fileSize >= maxSize) {
                alert("파일 사이즈 초과");
                return false;
            }

            if (!regex.test(fileName)) {
                alert("해당 종류의 파일은 업로드할 수 없습니다.");
                return false;
            }

            return true;

        }

        /* 이미지 출력 */
        function showUploadImage(uploadResultArr) {
            /* 전달받은 데이터 검증 */
            if (!uploadResultArr || uploadResultArr.length == 0) {
                return
            }

            let uploadResult = $("#uploadResult");
            let obj = uploadResultArr[0];
            let str = "";
            let fileCallPath = encodeURIComponent(obj.uploadPath.replace(/\\/g,
                    '/')
                    + "/thumbs_" + obj.uuid + "_" + obj.fileName);

            str += "<input type='hidden' name='imageList[0].fileName' value='"+ obj.fileName +"'>";
            str += "<input type='hidden' name='imageList[0].uuid' value='"+ obj.uuid +"'>";
            str += "<input type='hidden' name='imageList[0].uploadPath' value='"+ obj.uploadPath +"'>";

            str += "<div id='result_card'>";
            str += "<img src='/display?fileName=" + fileCallPath + "'>";
            str += "<div class='imgDeleteBtn' data-file='" + fileCallPath + "'>x</div>";
            str += "</div>";

            uploadResult.append(str);
        }

        /* 이미지 삭제 버튼 동작 */
        $("#uploadResult").on("click", ".imgDeleteBtn", function(e) {
            deleteFile();
        });

        /* 파일 삭제 메서드 */
        function deleteFile() {
        
            $("#result_card").remove();
        }
    </script>
</body>
</html>

