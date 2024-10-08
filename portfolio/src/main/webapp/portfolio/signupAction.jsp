<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="portfolio.JDBConnect"%>
<%
String username = request.getParameter("username");
String password = request.getParameter("password");
String email = request.getParameter("email");
String location = request.getParameter("location");

JDBConnect jdbc = new JDBConnect();
try {
    String sql = "INSERT INTO Users (USERNAME, PASSWORD, EMAIL, LOCATION) VALUES (?, ?, ?, ?)";
    PreparedStatement pstmt = jdbc.con.prepareStatement(sql);
    pstmt.setString(1, username);
    pstmt.setString(2, password);
    pstmt.setString(3, email);
    pstmt.setString(4, location);
    pstmt.executeUpdate();
    
} catch (SQLException e) {
    out.println("데이터베이스 오류 발생: " + e.getMessage());
} finally {
    jdbc.close();
}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입 완료</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="form-container">
        <h2>회원가입 완료</h2>
        <p>회원가입이 완료되었습니다!</p>
        <a href="index.jsp" class="btn">홈으로</a>
    </div>
</body>
</html>