<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <link rel="stylesheet" href="style.css">
    <script>
        function showAlert(message) {
            alert(message);
            window.location.href = "login.jsp"; // 로그인 페이지로 돌아가기
        }

        function toggleFindModal() {
            const modal = document.getElementById('findModal');
            modal.style.display = modal.style.display === 'block' ? 'none' : 'block';
        }

        function findIdPw() {
            var email = document.getElementById('email').value;
            // 여기에 실제 이메일 확인 로직을 추가해야 합니다.
            // 예시로 고정된 아이디와 비밀번호를 출력합니다.
            if (email === "example@example.com") { // 이메일 확인 예시
                document.getElementById('result').innerHTML = "아이디: exampleID, 비밀번호: examplePW";
            } else {
                document.getElementById('result').innerHTML = "등록된 이메일이 아닙니다.";
            }
            return false; // 폼 제출 방지
        }
        function findIdPw() {
            var email = document.getElementById('email').value;
            window.location.href = "findUser.jsp?email=" + encodeURIComponent(email);
            return false; // 폼 제출 방지
        }

    </script>
    
<style>
    body {
    	font-family: 'NEXONFootballGothicBA1';
    }
</style>
</head>
<body>
    <div class="form-container">
        <h2>로그인</h2>
        <form action="loginAction.jsp" method="post">
            <label for="username">사용자 이름:</label>
            <input type="text" id="username" name="username" required>

            <label for="password">비밀번호:</label>
            <input type="password" id="password" name="password" required>

            <button type="submit">로그인</button>
        </form>
        <p>아직 계정이 없으신가요? <a href="signup.jsp">회원가입</a></p>
        <a href="index.jsp" class="btn">홈으로</a> <!-- 홈으로 버튼 추가 -->
        <a href="#" onclick="toggleFindModal()" class="btn">아이디/비밀번호 찾기</a> <!-- 찾기 링크 추가 -->

        <%
            // 로그인 실패 메시지 확인
            String errorMessage = request.getParameter("error");
            if (errorMessage != null) {
        %>
            <script>
                showAlert("로그인 실패: <%= errorMessage %>");
            </script>
        <%
            }
        %>
    </div>

    <!-- 아이디/비밀번호 찾기 모달 -->
    <div id="findModal" class="modal" style="display: none;">
        <div class="modal-content">
            <span class="close" onclick="toggleFindModal()">&times;</span>
            <h2>아이디/비밀번호 찾기</h2>
            <form id="findForm" onsubmit="return findIdPw();">
                <label for="email">이메일:</label>
                <input type="email" id="email" required>
                <button type="submit">확인</button>
            </form>
            <div id="result"></div>
        </div>
    </div>
</body>
</html>
