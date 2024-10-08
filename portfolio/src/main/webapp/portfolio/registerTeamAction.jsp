<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="portfolio.JDBConnect"%>
<%
    JDBConnect jdbc = new JDBConnect();
    String type = request.getParameter("type");
    String teamName = request.getParameter("teamName");
    String description = request.getParameter("description");

    String insertSql = "INSERT INTO Teams (TYPE, TEAM_NAME, DESCRIPTION, CREATED_AT) VALUES (?, ?, ?, CURRENT_TIMESTAMP)";
    try {
        PreparedStatement pstmt = jdbc.con.prepareStatement(insertSql);
        pstmt.setString(1, type);
        pstmt.setString(2, teamName);
        pstmt.setString(3, description);
        pstmt.executeUpdate();

        // 등록 후 team.jsp로 리다이렉션
        response.sendRedirect("team.jsp");
    } catch (SQLException e) {
        out.println("등록 오류: " + e.getMessage());
    } finally {
        jdbc.con.close();
    }
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>