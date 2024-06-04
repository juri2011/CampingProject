<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원가입</title>
<link href="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js" rel="stylesheet">

<style>

/* 기본 스타일 설정 */
body {
    font-family: Arial, sans-serif;
}

/* 레이아웃 설정 */
.wrapper {
    width: 80%;
    margin: 20px auto;
    padding: 20px;
    background: #f4f4f4;
    border: 1px solid #ccc;
    box-shadow: 0 0 10px #ccc;
}

.form-container {
    display: flex;
    flex-direction: column;
}

.form-group {
    margin-bottom: 15px;
}

.form-group label {
    display: block;
    margin-bottom: 5px;
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
    background-color: #4CAF50;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 16px;
}

.join_button:hover, .address_button:hover {
    background-color: #45a049;
}

.address_button {
    padding: 8px;
    margin-top: 5px;
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



</style>
</head>

<body>

	<div class="wrapper">
		<div class="common-container">
			<form id="join_form" method="post">
				<div class="wrap">
					<div class="subjecet">
						<h1>회원가입</h1>
					</div>
					<hr />
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
						<span class="pwck_input_re_1">비밀번호가 일치합니다.</span> <span
							class="pwck_input_re_2">비밀번호가 일치하지 않습니다.</span>
	
					</div>
					<div class="user_wrap">
						<div class="user_name">이름</div>
						<div class="user_input_box">
							<input class="user_input" name="name">
						</div>
					</div>
					<div class="birth_wrap">
						<div class="birth_name">생년월일</div>
						<div class="birth_input_box">
							<select class="birth_input" name="year">
								<option value="">년(YYYY)</option>
								<!-- 생년 옵션 -->
								<script>
	                for (var year = 2005; year >= 1900; year--) {
	                    document.write('<option value="' + year + '">' + year + '</option>');
	                }
	            </script>
							</select> <select class="birth_input" name="month">
								<option value="">월(MM)</option>
								<!-- 생월 옵션 -->
								<script>
	                for (var month = 1; month <= 12; month++) {
	                    var monthStr = month < 10 ? '0' + month : '' + month;
	                    document.write('<option value="' + monthStr + '">' + monthStr + '</option>');
	                }
	            </script>
							</select> <select class="birth_input" name="day">
								<option value=""><fmt:formatDate value="${member.birth}"
										pattern="dd" />일(DD)
								</option>
								<!-- 생일 옵션 -->
								<script>
	                for (var day = 1; day <= 31; day++) {
	                    var dayStr = day < 10 ? '0' + day : '' + day;
	                    document.write('<option value="' + dayStr + '">' + dayStr + '</option>');
	                }
	            </script>
							</select> <input type="hidden" name="birth" id="birthHidden">
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
									readonly="readonly" placeholder="우편번호">
							</div>
							<button type="button" class="address_button"
								onclick="execution_daum_address()">주소찾기</button>
							<div class="clearfix"></div>
						</div>
						<div class="address_input_2_wrap">
							<div class="address_input_2_box">
								<input class="address_input_2" name="userAddr"
									readonly="readonly" placeholder="기본 주소">
							</div>
						</div>
						<div class="address_input_3_wrap">
							<div class="address_input_3_box">
								<input class="address_input_3" name="userDaddr"
									placeholder="상세주소">
							</div>
						</div>
					</div>
	
					<div class="join_button_wrap">
						<input type="button" class="join_button" value="가입하기">
					</div>
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" />
				</div>
			</form>
		</div>
		
	</div>

	<!-- API 외부 스크립트 파일 연결 코드 -->
	<script
		src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

	<script>

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
				
		 // 연도, 월, 일 선택값 가져와서 yyyy-mm-dd 형식으로 합치기
	    function updateBirthHidden() {
	        var year = document.getElementsByName("year")[0].value;
	        var month = document.getElementsByName("month")[0].value;
	        var day = document.getElementsByName("day")[0].value;
	        if (year && month && day) {
	            var birth = year + "-" + month + "-" + day;
	            document.getElementById("birthHidden").value = birth;
	        }
	    }

	    // 연도, 월, 일 선택이 변경될 때마다 호출하여 hidden input 업데이트
	    document.querySelectorAll('.birth_input').forEach(item => {
	        item.addEventListener('change', updateBirthHidden);
	    });

	    // 페이지 로드 시에도 호출하여 초기화
	    window.onload = function() {
	        updateBirthHidden();
	    };		
				
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
		
		// 유효성 검사
	       $(document).ready(function() {
        $(".join_button").click(function(event) {
            event.preventDefault(); // 폼 자동 제출 방지

            // 아이디 입력 검증
            if ($(".id_input").val().trim() === "") {
                alert("아이디를 입력해주세요.");
                $(".id_input").focus();
                return; // 검증 종료
            }

            // 비밀번호 입력 검증
            if ($(".pw_input").val().trim() === "") {
                alert("비밀번호를 입력해주세요.");
                $(".pw_input").focus();
                return; // 검증 종료
            }

            // 비밀번호 확인 입력 검증
            if ($(".pwck_input").val().trim() === "") {
                alert("비밀번호 확인을 입력해주세요.");
                $(".pwck_input").focus();
                return; // 검증 종료
            }

            // 비밀번호 일치 검사
            if ($(".pw_input").val() !== $(".pwck_input").val()) {
                alert("입력한 비밀번호와 비밀번호 확인이 일치하지 않습니다.");
                $(".pwck_input").focus();
                return; // 검증 종료
            }

            // 이름 입력 검증
            if ($(".user_input").val().trim() === "") {
                alert("이름을 입력해주세요.");
                $(".user_input").focus();
                return; // 검증 종료
            }

            // 생년월일 입력 검증
            if ($(".birth_input[name='year']").val() === "" || 
                $(".birth_input[name='month']").val() === "" || 
                $(".birth_input[name='day']").val() === "") {
                alert("생년월일을 모두 선택해주세요.");
                $(".birth_input[name='year']").focus();  // 가장 먼저 선택되어야 하는 연도에 포커스
                return; // 검증 종료
            }

            // 전화번호 입력 검증
            if ($(".phone_input").val().trim() === "") {
                alert("전화번호를 입력해주세요.");
                $(".phone_input").focus();
                return; // 검증 종료
            }

            // 이메일 입력 검증
            if ($(".mail_input1").val().trim() === "") {
                alert("이메일을 입력해주세요.");
                $(".mail_input1").focus();
                return; // 검증 종료
            }

            // 주소 입력 검증
            if ($(".address_input_1").val().trim() === "" ||
                $(".address_input_2").val().trim() === "") {
                alert("주소를 입력해주세요.");
                $(".address_input_1").focus();
                return; // 검증 종료
            }

            // 모든 필드가 적절히 입력되었을 때
            $("#join_form").attr("action", "/member/join");
            $("#join_form").submit(); // 폼 제출
        });
    });


	
	</script>

</body>
</html>