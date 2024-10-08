<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="portfolio.JDBConnect" %>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return; // 로그인이 되어 있지 않으면 로그인 페이지로 리다이렉트
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원정보 수정</title>
    <link rel="stylesheet" href="style.css">
    <style>
    body {
    	font-family: 'NEXONFootballGothicBA1';
    }
	</style>
</head>
<body>
    <div class="form-container">
        <h2>회원정보 수정</h2>
        <form action="updateProfile.jsp" method="post">
            <label for="password">현재 비밀번호:</label>
            <input type="password" id="password" name="password" required>

            <label for="newEmail">새 이메일:</label>
            <input type="email" id="newEmail" name="newEmail" required>

            <label for="newPassword">새 비밀번호:</label>
            <input type="password" id="newPassword" name="newPassword">

            <label for="confirmPassword">비밀번호 확인:</label>
            <input type="password" id="confirmPassword" name="confirmPassword">

            <label for="location">사는 지역:</label>
            <input type="text" id="location" name="location">

            <button type="submit">정보 수정</button>
        </form>
        <a href="index.jsp" class="btn">홈으로</a> <!-- 홈으로 버튼 추가 -->
    </div>
</body>
</html>
