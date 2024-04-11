<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>상품관리 페이지</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <style>
        h2 {
            text-align: center;
        }

        table {
            width: 100%;
        }

        td {
            text-align: center;
        }

        #outter {
            display: block;
            width: 60%;
            margin: auto;
        }

        a {
            text-decoration: none;
        }

        .admin_content_wrap {
            display: flex;
            justify-content: flex-end;
            padding-top: 5px;
        }
        
        img{
        	width: 150px;
        	height: 150px;
        }
    </style>
</head>
<body>
    <h2>상품관리</h2>

    <div id="outter">
        <div style="float: right;">
            <select id="cntPerPage" name="sel" onchange="selChange()">
                <option value="5" <c:if test="${paging.cntPerPage == 5}">selected</c:if>>5줄 보기</option>
                <option value="10" <c:if test="${paging.cntPerPage == 10}">selected</c:if>>10줄 보기</option>
                <option value="15" <c:if test="${paging.cntPerPage == 15}">selected</c:if>>15줄 보기</option>
                <option value="20" <c:if test="${paging.cntPerPage == 20}">selected</c:if>>20줄 보기</option>
            </select>
        </div>
        <!-- 옵션선택 끝 -->
        <table border="1">
            <thead>
                <tr>
                    <th>상품번호</th>
                    <th>상품 이미지</th>
                    <th>상품명</th>
                    <th>수량</th>
                    <th>판매가격</th>
                    <th>등록일</th>
                    <th>카테고리</th>
                    <th>수정</th>
                    <th>삭제</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${viewAll}" var="item">
                    <tr>
                        <td>${item.item_no}</td>
                        <td><img src="/resources/img/${item.fileName}" alt="상품이미지" /></td>
                        <td>${item.item_name}</td>
                        <td>${item.amount}</td>
                        <td><fmt:formatNumber value="${item.price}" type="number" /></td>
                        <td><fmt:formatDate value="${item.regdate}" pattern="yyyy.MM.dd" /></td>
                        <td>${item.category}</td>
                        <td><button class="modify_btn" data-item_no="${item.item_no}">수정</button></td>
                        <td><button class="delete_btn" data-item-no="${item.item_no}">삭제</button></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <div class="admin_content_wrap">
            <div class="admin_content_subject">
                <button id="itemEnroll" class="enroll_btn">상품등록</button>
            </div>
        </div>
		<!-- 페이징 처리 -->
        <div style="display: block; text-align: center;">
            <c:if test="${paging.startPage != 1}">
                <a href="/admin/itemManager?nowPage=${paging.startPage - 1}&cntPerPage=${paging.cntPerPage}">&lt;</a>
            </c:if>
            <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p">
                <c:choose>
                    <c:when test="${p == paging.nowPage}">
                        <b>${p}</b>
                    </c:when>
                    <c:otherwise>
                        <a href="/admin/itemManager?nowPage=${p}&cntPerPage=${paging.cntPerPage}">${p}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <c:if test="${paging.endPage != paging.lastPage}">
                <a href="/admin/itemManager?nowPage=${paging.endPage + 1}&cntPerPage=${paging.cntPerPage}">&gt;</a>
            </c:if>
        </div>
    </div>

    <script>
        function selChange() {
            var sel = document.getElementById('cntPerPage').value;
            location.href = "/admin/itemManager?nowPage=1&cntPerPage=" + sel; // 현재 페이지를 1페이지로 리셋
        }

        $(document).ready(function() {
            let eResult = '<c:out value="${enroll_result}"/>';
            checkResult(eResult);

            function checkResult(result) {
                if (result === '') {
                    return;
                }
                alert("상품 '" + result + "'을 등록하였습니다.");
            }

            // 상품 등록 버튼 클릭 시 페이지 이동
            $('#itemEnroll').on('click', function() {
                window.location.href = 'http://localhost:8092/admin/itemEnroll';
            });

            // 수정 버튼 클릭 시 해당 상품 정보를 가져와서 수정 페이지로 이동
            $('.modify_btn').on('click', function() {
                var itemId = $(this).data('item_no'); // data-item_no 속성을 통해 상품 번호 가져오기
                window.location.href = 'http://localhost:8092/admin/itemEdit?item_no=' + itemId; // 가져온 상품 번호를 URL에 추가하여 이동
            });
            
            // 삭제 버튼 클릭 시 해당 상품을 정말 삭제할건지 재차 묻고 삭제 진행
            $(".delete_btn").click(function() {
                // 해당 상품의 번호를 가져옵니다.
                var item_no = $(this).data("item-no");
                
                // 확인 다이얼로그를 표시합니다.
                var confirmDelete = confirm("정말로 삭제하시겠습니까?");
                
                if (confirmDelete) {
                    // AJAX 요청을 보냅니다.
                    $.ajax({
                        type: "POST",
                        url: "/admin/deleteItem",
                        beforeSend: function(xhr) {
        		            xhr.setRequestHeader(header, token);
        		        },
                        data: {
                            item_no: item_no
                        },
                        success: function(response) {
                            // 삭제 성공 시 페이지를 새로고침합니다.
                            location.reload();
                            alert("해당 상품을 삭제했습니다.")
                        },
                        error: function(xhr, status, error) {
                            // 오류 발생 시 콘솔에 오류 메시지를 출력합니다.
                            console.error(xhr.responseText);
                        }
                    });
                }
            });

        });
    </script>

</body>
</html>
