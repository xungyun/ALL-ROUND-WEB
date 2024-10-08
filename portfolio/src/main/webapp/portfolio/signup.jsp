<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <link rel="stylesheet" href="style.css">
    <style>
    body {
    	font-family: 'NEXONFootballGothicBA1';
    }
	</style>
</head>
<body>
    <div class="form-container">
        <h2>회원가입</h2>
        <form action="signupAction.jsp" method="post">
            <label for="username">사용자 이름:</label>
            <input type="text" id="username" name="username" required>

            <label for="password">비밀번호:</label>
            <input type="password" id="password" name="password" required>

            <label for="email">이메일:</label>
            <input type="email" id="email" name="email" required>

            <label for="location">지역:</label>
            <input type="text" id="location" name="location" required>

            <button type="submit">회원가입</button>
        </form>
        <p>이미 계정이 있으신가요? <a href="login.jsp">로그인</a></p>
        <a href="index.jsp" class="btn">홈으로</a> <!-- 홈으로 버튼 추가 -->
    </div>
</body>
</html>
