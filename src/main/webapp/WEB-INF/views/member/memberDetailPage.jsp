<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>	
<head>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token}"/>
	<meta name="_csrf_header" content="${_csrf.headerName}"/>
<title>회원 정보 수정</title>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style>
/* 중복아이디 존재하지 않는경우 */
.id_input_re_1 {
	color: green;
	display: none;
}
/* 중복아이디 존재하는 경우 */
.id_input_re_2 {
	color: red;
	display: none;
}

/* 비밀번호 확인 일치 유효성검사 */
.pwck_input_re_1 {
	color: green;
	display: none;
}

.pwck_input_re_2 {
	color: red;
	display: none;
}
</style>
<body>

<div class="wrapper">
	<form id="modify_form" method="post">
		<div class="wrap">
			<div class="subject">
				<span>회원정보 수정</span>
			</div>
			<div class="id_wrap">
				<div class="id_name">아이디</div>
				<div class="id_input_box">
					<input class="id_input" name="mem_id" value="${member.mem_id}" readonly>
				</div>
			</div>
			<span class="id_input_re_1">사용 가능한 아이디입니다.</span> <span
				class="id_input_re_2">이미 존재하는 아이디입니다.</span>
			<%-- 
			<div class="pw_wrap">
				<div class="pw_name">비밀번호</div>
				<div class="pw_input_box">
					<input class="pw_input" name="pwd" type="password" value="${member.pwd}" autocomplete="current-password" readonly>
				</div>
			</div>
			 --%>
			<div class="user_wrap">
				<div class="user_name">이름</div>
				<div class="user_input_box">
					<input class="user_input" name="name" value="${member.name}">
				</div>
			</div>
   <div class="birth_wrap">
    <div class="birth_name">생년월일</div>
    <div class="birth_input_box">
        <select class="birth_input" name="year" id="birthYear">
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
        <select class="birth_input" name="month" id="birthMonth">
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
           <select class="birth_input" name="day" id="birthDay">
            <option value=""><fmt:formatDate value="${member.birth}" pattern="dd"/></option>
							<!-- 생일 옵션 -->
         <script>
                for (var day = 1; day <= 31; day++) {
                    var dayStr = day < 10 ? '0' + day : '' + day;
                    document.write('<option value="' + dayStr + '">' + dayStr + '</option>');
                }
            </script>
        </select>
        <input type="hidden" name="birth" id="birthHidden">
    </div>
</div>


			<div class="phone_wrap">
				<div class="phone_name">전화번호(번호 사이에"-"필수)</div>
				<div class="phone_input_box">
					<input class="phone_input" name="phone" value="${member.phone}">
				</div>
			</div>
			<div class="gender_wrap">
				 <div class="gender_name">성별</div>
				    <div class="gender_input_box">
				        <label><input type="radio" class="gender_input" name="gender" value="남성" ${member.gender == '남성' ? 'checked' : ''}> 남성</label>
				        <label><input type="radio" class="gender_input" name="gender" value="여성" ${member.gender == '여성' ? 'checked' : ''}> 여성</label>
				    </div>
			</div>
			<div class="mail_wrap">
				<div class="mail_name">이메일</div>
				<div class="mail_input_box">
					<input class="mail_input1" name="email" value="${member.email}">
				</div>

			</div>
			<div class="address_wrap">
				<div class="address_name">주소</div>
				<div class="address_input_1_wrap">
					<div class="address_input_1_box">
						<input class="address_input_1" name="userStnum" readonly="readonly" value="${member.userStnum}">
					</div>
					<div class="address_button" onclick="execution_daum_address()">
						<span>주소찾기</span>
					</div>
					<div class="clearfix"></div>
				</div>
				<div class="address_input_2_wrap">
					<div class="address_input_2_box">
						<input class="address_input_2" name="userAddr" readonly="readonly" value="${member.userAddr}">
					</div>
				</div>
				<div class="address_input_3_wrap">
					<div class="address_input_3_box">
						<input class="address_input_3" name="userDaddr" readonly="readonly" value="${member.userDaddr}" placeholder="상세주소">
					</div>
				</div>

			</div>
			<div class="join_button_wrap">
				<input type="button" class="modify_button" value="수정하기">
			</div>
		</div>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		
	</form>
</div>

<!-- API 외부 스크립트 파일 연결 코드 -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
const token = $("meta[name='_csrf']").attr("content");
const header = $("meta[name='_csrf_header']").attr("content");
$(document).ready(function() {
    // 수정하기 버튼 클릭 시 회원 정보 수정 요청
    $(".modify_button").click(function() {
        // 선택된 연도, 월 및 일 가져오기
        var year = $("#birthYear").val();
        var month = $("#birthMonth").val();
        var day = $("#birthDay").val();
        
        // 연도, 월, 일을 결합하여 birth 문자열 생성
        var birth = year + "-" + month + "-" + day;
        
        // 숨겨진 입력 필드에 값을 설정
        $("#birthHidden").val(birth);
        
        var formData = $("#modify_form").serialize(); // 폼 데이터 직렬화
        $.ajax({
            type: "POST",
            url: "/member/updateMemberInfo", // 회원 정보 수정 엔드포인트
            beforeSend: function(xhr) {
	            xhr.setRequestHeader(header, token);
	        },
            data: formData,
            success: function(response) {
                alert("회원 정보가 성공적으로 수정되었습니다.");
                // 수정 성공 시 페이지 이동
                window.location.href = "/member/memberUpdate";
            },
            error: function(xhr, status, error) {
                console.error("회원 정보 수정에 실패했습니다:", error);
                alert("회원 정보 수정에 실패했습니다. 다시 시도해주세요.");
            }
        });
    });
});

</script>



</body>
</html>
