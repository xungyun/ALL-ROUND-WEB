<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="portfolio.JDBConnect"%>
<%
String username = (String) session.getAttribute("username");
String message = "";
boolean success = false;

if (username != null) {
    String type = request.getParameter("type");
    String title = request.getParameter("title");
    String description = request.getParameter("description");
    String contact = request.getParameter("contact");

    JDBConnect jdbc = new JDBConnect();
    try {
        // USERNAME 추가
        String sql = "INSERT INTO Jobs (TYPE, TITLE, DESCRIPTION, CONTACT, USERNAME) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement pstmt = jdbc.con.prepareStatement(sql);
        pstmt.setString(1, type);
        pstmt.setString(2, title);
        pstmt.setString(3, description);
        pstmt.setString(4, contact);
        pstmt.setString(5, username); // 작성자 이름 추가
        pstmt.executeUpdate();
        
        // 성공 메시지 설정
        message = "게시물이 성공적으로 게시되었습니다!";
        success = true;
    } catch (SQLException e) {
        message = "데이터베이스 오류 발생: " + e.getMessage();
    } finally {
        jdbc.close();
    }
} else {
    message = "로그인 후 게시할 수 있습니다.";
}
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시 결과</title>
    <link rel="stylesheet" href="style.css">
    <style>
        .notification {
            position: fixed;
            top: 10px;
            left: 50%;
            transform: translateX(-50%);
            background-color: #4CAF50;
            color: white;
            padding: 15px;
            z-index: 1000;
            display: <%=(success ? "block" : "none")%>;
        }
        .notification.error {
            background-color: #f44336; /* Red */
        }
    </style>
</head>
<body>
    <div class="notification <%=(success ? "" : "error")%>">
        <%= message %>
        <button onclick="window.location.href='allMatches.jsp'">확인</button>
    </div>
    <jsp:include page="header.jsp"></jsp:include>
    <jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
