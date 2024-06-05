<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
    <title>Change Password</title>
    <style>
        .form-container{
            margin: 0 auto;
        }
        
        .form-group{
            margin-bottom: 10px;
        }
    </style>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<body>
    <div id="wrapper">
        <div class="common-container">
            <h2>비밀번호 변경</h2>

            <form action="<c:url value='/member/changePassword'/>" method="post" id="pwUpdateForm" name="pwUpdateForm">
                <input type="hidden" id="mem_id" name="mem_id" value="${mem_id}">
                <div class="form-container col-sm-8 col-sm-offset-2">
                    <div class="panel panel-default panel-margin-10">
                        <div class="panel-body panel-body-content text-center">
                            <p class="lead">변경하실 비밀번호를 입력해 주세요.</p>
                            <div class="form-group">
                                <input type="password" name="oldPassword" id="pwd" class="form-control form-control-inline text-center" placeholder="현재 비밀번호" />
                            </div>
                            <div class="form-group">
                                <input type="password" name="newPassword" class="form-control form-control-inline text-center" placeholder="새 비밀번호" />
                            </div>
                            <div class="form-group">
                                <input type="password" name="newPasswordConfirm" class="form-control form-control-inline text-center" placeholder="새 비밀번호 확인" />
                            </div>
                            <button type="submit" id="pwUpdate" name="pwUpdate" class="btn btn-primary">비밀번호 변경</button>
                            <a href="<c:url value='/member/memberUpdate'/>" class="btn btn-secondary">취소</a>
                        </div>
                    </div>
                </div>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            </form>
        </div>
    </div>
    
    <script>
    $(document).ready(function() {
        const token = $("meta[name='_csrf']").attr("content");
        const header = $("meta[name='_csrf_header']").attr("content");

        $("#pwUpdate").click(function(event) {
            event.preventDefault(); // 기본 이벤트 동작 방지

            var oldPassword = $("#pwd").val();
            var newPassword = $("input[name='newPassword']").val();
            var newPasswordConfirm = $("input[name='newPasswordConfirm']").val();

            // 비밀번호 확인
            if (newPassword !== newPasswordConfirm) {
                alert("새 비밀번호와 새 비밀번호 확인이 일치하지 않습니다.");
                return;
            }

            // 로딩 인디케이터 표시
            var loadingIndicator = $("<div>").text("Loading...");
            $("body").append(loadingIndicator);

            var formData = {
                mem_id: $("#mem_id").val(),
                oldPassword: $("input[name='oldPassword']").val(),
                newPassword: $("input[name='newPassword']").val()
            };
            
            $.ajax({
                type: "POST",
                url: "/member/changePassword",
                beforeSend: function(xhr) {
                    xhr.setRequestHeader(header, token);
                },
                data: formData,
                success: function(response) {
                    loadingIndicator.remove();
                    if (response === "success") {
                        alert("회원 정보가 성공적으로 수정되었습니다.");
                        location.href = '/member/memberUpdate';
                    } else {
                        alert("입력 정보를 다시 한 번 확인하세요.");
                        $("input[name='oldPassword']").val('');
                        $("input[name='newPassword']").val('');
                        $("input[name='newPasswordConfirm']").val('');
                    }
                },
                error: function(xhr, status, error) {
                    console.error("회원 정보 수정에 실패했습니다:", error);
                    alert("서버 오류가 발생했습니다.");
                    $("input[name='oldPassword']").val('');
                    $("input[name='newPassword']").val('');
                    $("input[name='newPasswordConfirm']").val('');
                }
            });
        });
    });
    </script>
</body>
</html>
