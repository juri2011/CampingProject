<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
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
		<form id="join_form" method="post">
			<div class="wrap">
				<div class="subjecet">
					<span>회원가입</span>
				</div>
				<div class="id_wrap">
					<div class="id_name">아이디</div>
					<div class="id_input_box">
						<input class="id_input" name="mem_id">
					</div>
				</div>
				<span class="id_input_re_1">사용 가능한 아이디입니다.</span> <span
					class="id_input_re_2">이미 존재하는 아이디입니다.</span>
				<div class="pw_wrap">
					<div class="pw_name">비밀번호</div>
					<div class="pw_input_box">
						<input class="pw_input" name="pwd" type="password"
							autocomplete="current-password">
					</div>
				</div>
				<div class="pwck_wrap">
					<div class="pwck_name">비밀번호 확인</div>
					<div class="pwck_input_box">
						<input class="pwck_input" type="password"
							autocomplete="current-password">
					</div>
					<span class="pwck_input_re_1">비밀번호가 일치합니다.</span>
				    <span class="pwck_input_re_2">비밀번호가 일치하지 않습니다.</span>
						
				</div>
				<div class="user_wrap">
					<div class="user_name">이름</div>
					<div class="user_input_box">
						<input class="user_input" name="name">
					</div>
				</div>
				<div class="birth_wrap">
					<div class="birth_name">생년월일(예시 : 2005-08-20)</div>
					<div class="birth_input_box">
						<input class="birth_input" name="birth">
					</div>
				</div>
				<div class="phone_wrap">
					<div class="phone_name">전화번호(번호 사이에"-"필수)</div>
					<div class="phone_input_box">
						<input class="phone_input" name="phone">
					</div>
				</div>
				<div class="gender_wrap">
					<div class="gender_name">성별</div>
					<div class="gender_input_box">
						<label><input type="radio" class="gender_input"
							name="gender" value="남성"> 남성</label> <label><input
							type="radio" class="gender_input" name="gender" value="여성">
							여성</label>
					</div>
				</div>
				<div class="mail_wrap">
					<div class="mail_name">이메일</div>
					<div class="mail_input_box">
						<input class="mail_input1" name="email">
					</div>

				</div>
				<div class="address_wrap">
					<div class="address_name">주소</div>
					<div class="address_input_1_wrap">
						<div class="address_input_1_box">
							<input class="address_input_1" name="userStnum"
								readonly="readonly">
						</div>
						<div class="address_button" onclick="execution_daum_address()">
							<span>주소찾기</span>
						</div>
						<div class="clearfix"></div>
					</div>
					<div class="address_input_2_wrap">
						<div class="address_input_2_box">
							<input class="address_input_2" name="userAddr"
								readonly="readonly">
						</div>
					</div>
					<div class="address_input_3_wrap">
						<div class="address_input_3_box">
							<input class="address_input_3" name="userDaddr"
								readonly="readonly" placeholder="상세주소">
						</div>
					</div>

				</div>
				<div class="join_button_wrap">
					<input type="button" class="join_button" value="가입하기">
				</div>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			</div>
		</form>
	</div>

	<!-- API 외부 스크립트 파일 연결 코드 -->
	<script
		src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

	<script>
		$(document).ready(function() {
			//회원가입 버튼(회원가입 기능 작동)
			$(".join_button").click(function() {
				$("#join_form").attr("action", "/member/join");
				$("#join_form").submit();
			});
		});

		//아이디 중복검사
		$('.id_input').on(
				"propertychange change keyup paste input",
				function() {

					let mem_id = $('.id_input').val(); // .id_input에 입력되는 값
					let data = {
						mem_id : mem_id
					} // '컨트롤에 넘길 데이터 이름' : '데이터(.id_input에 입력되는 값)'

					$.ajax({
						type : "post",
						url : "/member/memberIdChk",
						data : data,
						success : function(result) {
							//console.log("성공 여부" + result);
							if (result != 'fail') {
								$('.id_input_re_1').css("display",
										"inline-block");
								$('.id_input_re_2').css("display", "none");
							} else {
								$('.id_input_re_2').css("display",
										"inline-block");
								$('.id_input_re_1').css("display", "none");
							}
						}// success 종료
					}); // ajax 종료	

				});// function 종료


		/* 비밀번호 확인 일치 유효성 검사 */
		$('.pwck_input').on("propertychange change keyup paste input", function() {
		    let pw = $('.pw_input').val().trim(); // 비밀번호 입력란의 값
		    let pwck = $(this).val().trim(); // 비밀번호 확인 입력란의 값
		    if (pw === "" || pwck === "") {
		        // 입력값이 없을 때는 결과와 메시지를 숨깁니다.
		        $('.pwck_input_re_1, .pwck_input_re_2').css('display', 'none');
		        $('.pwck_ck').css('display', 'block').text('비밀번호를 입력해주세요.');
		    } else {
		        // 입력값이 있을 때는 결과를 보여줍니다.
		        if (pw === pwck) {
		            $('.pwck_input_re_1').css('display', 'block');
		            $('.pwck_input_re_2').css('display', 'none');
		            pwckcorCheck = true;
		        } else {
		            $('.pwck_input_re_1').css('display', 'none');
		            $('.pwck_input_re_2').css('display', 'block').text('비밀번호가 일치하지 않습니다.');
		            pwckcorCheck = false;
		        }
		    }
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