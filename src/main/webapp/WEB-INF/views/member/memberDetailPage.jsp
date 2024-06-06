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
.join_button, .address_button {
    padding: 10px 20px;
    color: white;
    background-color: #005555;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 16px;
}

.join_button:hover, .address_button:hover {
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
				<button type="submit" class="join_button">정보 수정</button>
			</form>
		</div>
	</div>
	<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
	<script>
    function execution_daum_address() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = '';
                var extraAddr = '';

                if (data.userSelectedType === 'R') {
                    addr = data.roadAddress;
                } else {
                    addr = data.jibunAddress;
                }

                if (data.userSelectedType === 'R') {
                    if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                        extraAddr += data.bname;
                    }
                    if (data.buildingName !== '' && data.apartment === 'Y') {
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    if (extraAddr !== '') {
                        extraAddr = ' (' + extraAddr + ')';
                    }
                }

                document.getElementsByName('userStnum')[0].value = data.zonecode;
                document.getElementsByName("userAddr")[0].value = addr + extraAddr;
                document.getElementsByName("userDaddr")[0].focus();
            }
        }).open();
    }
	</script>

</body>
</html>
