<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="portfolio.JDBConnect"%>
<%
String jobId = request.getParameter("jobId");
JDBConnect jdbc = new JDBConnect();
String title = "";
String description = "";
String contact = "";
String type = "";

try {
    String sql = "SELECT * FROM Jobs WHERE JOB_ID = ?";
    PreparedStatement pstmt = jdbc.con.prepareStatement(sql);
    pstmt.setString(1, jobId);
    ResultSet rs = pstmt.executeQuery();
    if (rs.next()) {
        title = rs.getString("TITLE");
        description = rs.getString("DESCRIPTION");
        contact = rs.getString("CONTACT");
        type = rs.getString("TYPE");
    }
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
    <title>게시물 수정</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="form-container">
        <h2>게시물 수정</h2>
        <form action="editJobAction.jsp" method="post">
            <input type="hidden" name="jobId" value="<%= jobId %>">
            <label for="type">유형:</label>
            <select id="type" name="type" required>
                <option value="구인" <%= type.equals("구인") ? "selected" : "" %>>구인</option>
                <option value="구직" <%= type.equals("구직") ? "selected" : "" %>>구직</option>
            </select>
            <label for="title">제목:</label>
            <input type="text" id="title" name="title" value="<%= title %>" required>
            
            <label for="description">설명:</label>
            <textarea id="description" name="description" required><%= description %></textarea>
            
            <label for="contact">연락처:</label>
            <input type="text" id="contact" name="contact" value="<%= contact %>" required>
            <button type="submit">수정하기</button>
        </form>
        <a href="allMatches.jsp" class="btn">취소</a>
    </div>
</body>
</html>
