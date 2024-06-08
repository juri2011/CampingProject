<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style>
/* 기본 스타일 설정 */
body {
    font-family: Arial, sans-serif;
}

/* 레이아웃 설정 */
.wrapper {
    width: 1280px;
    margin: 20px auto;
    padding: 20px;
    border: 1px solid #ccc;
    box-shadow: 0 0 10px #ccc;
}

.form-container {
    display: flex;
    flex-direction: column;
}

h1{
	font-size:800;
}

.form-group {
    margin-bottom: 15px;
}

.form-group label {
    display: block;
}

/* 입력 필드 스타일 */
.form-control {
    width: 100%;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 4px;
}

input[readonly] {
    background-color: #eee; /* Light grey background for readonly inputs */
}

/* 버튼 스타일 */
.modify-button, .address_button {
    padding: 10px 20px;
    color: white;
    background-color: #005555;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 16px;
}

.modify-button:hover, .address_button:hover {
    background-color: #004040;
}

.birth_input_box {
    display: flex;
    flex-direction: row;
    gap: 10px; /* 선택 요소들 사이에 여백 추가 */
}

.birth_input {
    width: 100px; /* 선택박스의 너비를 동일하게 설정 */
}

.address_input_1_wrap {
    display: flex;
    align-items: center; /* 버튼을 입력 필드와 수직으로 가운데 정렬 */
    width:500px;
}

.address_button {
    margin-left: 10px;
}

/* 주소 입력 필드 스타일 */
.address_wrap {
    margin: 20px 0;
    padding: 10px;
    background-color: #f8f8f8;
    border: 1px solid #ccc;
}

.address_input_1_wrap, .address_input_2_wrap, .address_input_3_wrap {
    margin-bottom: 10px;
}

.mail_input1{
	width: 230px;
}

/* 우편번호 입력란 너비 */
.address_input_1 {
    width: 220px; /* 원하는 너비로 조정 */
}

/* 기본주소 입력란 너비 */
.address_input_2 {
    width: 500px; /* 원하는 너비로 조정 */
}

/* 상세주소 입력란 너비 */
.address_input_3 {
    width: 500px; /* 원하는 너비로 조정 */
}

.address_input_1_box, .address_input_2_box, .address_input_3_box {
    margin-right: 5px;
    display: inline-block;
}


/* 유효성 검사 메시지 스타일 */
.help-block, .id_input_re_1, .id_input_re_2, .pwck_input_re_1, .pwck_input_re_2 {
    display: none; /* Initially hide all help blocks */
    color: red;
}

.id_input_re_1, .pwck_input_re_1 {
    color: green;
}

.gender_input_box label {
    font-size: 18px;
}

/* 입력값 넣는 태그들 간격 설정 */
.id_input_box,
.pw_input_box,
.pwck_input_box,
.user_input_box,
.birth_input_box,
.phone_input_box,
.gender_input_box,
.mail_input_box,
.address_input_2_wrap,
.address_input_3_wrap {
	width: 200px;
    margin-bottom: 20px;
}

/* 입력값 제목들 크기 조절 */
.id_name,
.pw_name,
.pwck_name,
.user_name,
.birth_name,
.phone_name,
.gender_name,
.mail_name,
.address_name {
    font-size: 18px;
}
</style>
<body>

	<div class="wrapper">
		<div class="common-container">
			<form id="modify_form" method="post">
				<div class="wrap">
					<div class="subject">
						<h2>회원정보 수정</h2>
					</div>
					<hr>
					<div class="id_wrap">
						<div class="id_name">아이디</div>
						<div class="id_input_box">
							<input class="id_input form-control" name="mem_id"
								value="${member.mem_id}" readonly>
						</div>
					</div>
					<div class="user_wrap">
						<div class="user_name">이름</div>
						<div class="user_input_box">
							<input class="user_input form-control" name="name"
								value="${member.name}">
						</div>
					</div>
					<div class="birth_wrap">
						<div class="birth_name">생년월일</div>
						<div class="birth_input_box col-auto">
							<select class="birth_input form-select" name="year"
								id="birthYear" aria-describedby="passwordHelpInline">
								<option value="">년(YYYY)</option>
								<!-- 생년 옵션 -->
								<script>
					                var currentYear = new Date().getFullYear();
					                for (var year = currentYear; year >= 1900; year--) {
					                    var selected = year === ${member.birth.year + 1900} ? 'selected' : '';
					                    document.write('<option value="' + year + '"' + selected + '>' + year + '</option>');
					                }
					            </script>
							</select>
							 <select class="birth_input form-select col-auto" name="month"
								id="birthMonth" aria-describedby="passwordHelpInline">
								<option value="">월(MM)</option>
								<!-- 생월 옵션 -->
								<script>
					                for (var month = 1; month <= 12; month++) {
					                    var monthStr = month < 10 ? '0' + month : '' + month;
					                    var selected = month === ${member.birth.month + 1} ? 'selected' : '';
					                    document.write('<option value="' + monthStr + '"' + selected + '>' + monthStr + '</option>');
					                }
					            </script>
							</select>
							 <select class="birth_input form-select col-auto" name="day"
								id="birthDay" aria-describedby="passwordHelpInline">
								<option value="">일(DD)</option>
								<!-- 생일 옵션 -->
								<script>
					                for (var day = 1; day <= 31; day++) {
					                    var dayStr = day < 10 ? '0' + day : '' + day;
					                    var selected = day === ${member.birth.date} ? 'selected' : '';
					                    document.write('<option value="' + dayStr + '"' + selected + '>' + dayStr + '</option>');
					                }
					            </script>
							</select> 
							<input type="hidden" name="birth" id="birthHidden">
						</div>
					</div>


					<div class="phone_wrap">
						<div class="phone_name">전화번호(번호 사이에"-"필수)</div>
						<div class="phone_input_box">
							<input class="phone_input form-control" name="phone"
								value="${member.phone}">
						</div>
					</div>
					<div class="gender_wrap">
						<div class="gender_name">성별</div>
						<div class="gender_input_box">
							<label><input type="radio"
								class="gender_input form-check-input" name="gender" value="남성"
								${member.gender == '남성' ? 'checked' : ''}> 남성</label> <label><input
								type="radio" class="gender_input form-check-input" name="gender"
								value="여성" ${member.gender == '여성' ? 'checked' : ''}> 여성</label>
						</div>
					</div>
					<div class="mail_wrap">
						<div class="mail_name">이메일</div>
						<div class="mail_input_box">
							<input class="mail_input1 form-control" name="email"
								value="${member.email}">
						</div>

					</div>
					<div class="address_wrap">
						<div class="address_name">주소</div>
						<div class="address_input_1_wrap">
							<div class="address_input_1_box">
								<input class="address_input_1 form-control" name="userStnum"
									readonly="readonly" value="${member.userStnum}">
							</div>
							<button type="button" class="address_button"
								onclick="execution_daum_address()">주소찾기</button>
						</div>
						<div class="clearfix"></div>
						
						<div class="address_input_2_wrap">
							<div class="address_input_2_box">
								<input class="address_input_2 form-control" name="userAddr"
									readonly="readonly" value="${member.userAddr}">
							</div>
						</div>
						<div class="clearfix"></div>

						<div class="address_input_3_wrap">
							<div class="address_input_3_box">
								<input class="address_input_3 form-control" name="userDaddr"
									value="${member.userDaddr}">
							</div>
						</div>
					</div>
				</div>
				<button type="submit" class="modify-button">정보 수정</button>
			</form>
		</div>
	</div>
	<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script>
	$(document).ready(function() {
	    // CSRF 토큰 설정
	    var token = $("meta[name='_csrf']").attr("content");
	    var header = $("meta[name='_csrf_header']").attr("content");

	    // 수정하기 버튼 클릭 시 회원 정보 수정 요청
	    $(".modify-button").click(function(event) { 
	        event.preventDefault(); // 폼 제출 기본 동작 방지

	        // 이름 입력 검증 (2~20자)
	        let userInput = $(".user_input").val().trim();
	        if (userInput === "" || userInput.length < 2 || userInput.length > 20) {
	            alert("이름은 2자 이상 20자 이하로 입력해주세요.");
	            $(".user_input").focus();
	            return; // 검증 종료
	        }

	        // 생년월일 입력 검증
	        var year = $("#birthYear").val();
	        var month = $("#birthMonth").val();
	        var day = $("#birthDay").val();
	        if (!year || !month || !day) {
	            alert("생년월일을 모두 선택해 주세요.");
	            return; // 검증 종료
	        }
	        
	        // 연도, 월, 일을 결합하여 birth 문자열 생성
	        var birth = year + "-" + month + "-" + day;
	        
	        // 숨겨진 입력 필드에 값을 설정
	        $("#birthHidden").val(birth);

	        // 전화번호 입력 검증 (xxx-xxxx-xxxx 형식)
	        let phoneInput = $(".phone_input").val().trim();
	        let phonePattern = /^\d{3}-\d{4}-\d{4}$/;
	        if (!phoneInput.match(phonePattern)) {
	            alert("전화번호는 xxx-xxxx-xxxx 형식으로 입력해주세요.");
	            $(".phone_input").focus();
	            return; // 검증 종료
	        }

	        // 이메일 입력 검증
	        let emailInput = $(".mail_input1").val().trim();
	        let emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
	        if (emailInput === "" || !emailInput.match(emailPattern)) {
	            alert("올바른 이메일 형식을 입력해주세요.");
	            $(".mail_input1").focus();
	            return; // 검증 종료
	        }

	        // 상세주소 입력 검증
	        if ($(".address_input_3").val().trim() === "") {
	            alert("상세주소를 입력해주세요.");
	            $(".address_input_3").focus();
	            return; // 검증 종료
	        }

	        // 모든 필드가 적절히 입력되었을 때
	        var formData = $("#modify_form").serialize(); // 폼 데이터 직렬화
	        $.ajax({
	            type: "POST",
	            url: "/member/updateMemberInfo", // 회원 정보 수정 엔드포인트
	            beforeSend: function(xhr) {
	                xhr.setRequestHeader(header, token); // CSRF 토큰을 헤더에 설정
	            },
	            data: formData,
	            success: function(response) {
	                if(response === "success") {
	                    alert("회원 정보가 성공적으로 수정되었습니다.");
	                    window.location.href = "/member/memberUpdate";
	                } else {
	                    alert("회원 정보 수정에 실패했습니다. 다시 시도해주세요.");
	                }
	            },
	            error: function(xhr, status, error) {
	                console.error("회원 정보 수정에 실패했습니다:", error);
	                alert("회원 정보 수정에 실패했습니다. 다시 시도해주세요.");
	            }
	        });
	    });
	});

	
	/* 다음 주소 연동 */
	function execution_daum_address() {

		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.

						// 각 주소의 노출 규칙에 따라 주소를 조합한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var addr = ''; // 주소 변수
						var extraAddr = ''; // 참고항목 변수

						//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
						if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
							addr = data.roadAddress;
						} else { // 사용자가 지번 주소를 선택했을 경우(J)
							addr = data.jibunAddress;
						}

						// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
						if (data.userSelectedType === 'R') {
							// 법정동명이 있을 경우 추가한다. (법정리는 제외)
							// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
							if (data.bname !== ''
									&& /[동|로|가]$/g.test(data.bname)) {
								extraAddr += data.bname;
							}
							// 건물명이 있고, 공동주택일 경우 추가한다.
							if (data.buildingName !== ''
									&& data.apartment === 'Y') {
								extraAddr += (extraAddr !== '' ? ', '
										+ data.buildingName
										: data.buildingName);
							}
							// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
							if (extraAddr !== '') {
								extraAddr = ' (' + extraAddr + ')';
							}
							// 주소변수 문자열과 참고항목 문자열 합치기
							addr += extraAddr;

						} else {
							addr += ' ';
						}

						$(".address_input_1").val(data.zonecode);
						//$("[name=memberAddr1]").val(data.zonecode);    // 대체가능
						$(".address_input_2").val(addr);
						//$("[name=memberAddr2]").val(addr);            // 대체가능
						// 커서를 상세주소 필드로 이동한다.
						$(".address_input_3").attr("readonly", false);
						$(".address_input_3").focus();

					}
				}).open();

	}
</script>

</body>
</html>
