<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="portfolio.JDBConnect"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>선수 조회</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>

<section class="main-section">
    <h2 style="text-align:center">선수 조회</h2><br>
    <table border="1">
        <tr>
            <th>선수번호</th>
            <th>성명</th>
            <th>포지션</th>
            <th>연령</th>
            <th>소속팀</th>
            <th>지역</th>
        </tr>
        <%
        JDBConnect jdbc = new JDBConnect();

        try {
            String sql = "SELECT * FROM Players";
            PreparedStatement pstmt = jdbc.con.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                String playerId = rs.getString("PLAYER_ID");
                String name = rs.getString("NAME");
                String position = rs.getString("POSITION");
                int age = rs.getInt("AGE");
                String team = rs.getString("TEAM");
                String location = rs.getString("LOCATION");

                out.println("<tr>");
                out.println("<td>" + playerId + "</td>");
                out.println("<td>" + name + "</td>");
                out.println("<td>" + position + "</td>");
                out.println("<td>" + age + "</td>");
                out.println("<td>" + team + "</td>");
                out.println("<td>" + location + "</td>");
                out.println("</tr>");
            }
        } catch (SQLException e) {
            out.println("데이터베이스 오류 발생: " + e.getMessage());
        } finally {
            jdbc.close();
        }
        %>
    </table>
</section>

<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
