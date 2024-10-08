<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="portfolio.JDBConnect"%>
<%
String username = (String) session.getAttribute("username");
String currentPassword = request.getParameter("password"); // 현재 비밀번호
String newEmail = request.getParameter("newEmail");
String newPassword = request.getParameter("newPassword");
String location = request.getParameter("location");

JDBConnect jdbc = new JDBConnect();
boolean passwordCorrect = false;

try {
    String sql = "SELECT PASSWORD FROM Users WHERE USERNAME = ?";
    PreparedStatement pstmt = jdbc.con.prepareStatement(sql);
    pstmt.setString(1, username);
    ResultSet rs = pstmt.executeQuery();

    if (rs.next()) {
        String dbPassword = rs.getString("PASSWORD");
        // 비밀번호 비교
        if (dbPassword.equals(currentPassword)) {
            passwordCorrect = true;
            // 비밀번호가 맞을 경우 이메일 및 비밀번호 업데이트
            String updateSql = "UPDATE Users SET EMAIL = ?, PASSWORD = ?, LOCATION = ? WHERE USERNAME = ?";
            PreparedStatement updatePstmt = jdbc.con.prepareStatement(updateSql);
            updatePstmt.setString(1, newEmail);
            updatePstmt.setString(2, newPassword); // 비밀번호를 평문으로 저장
            updatePstmt.setString(3, location);
            updatePstmt.setString(4, username);
            updatePstmt.executeUpdate();
%>
            <script>
                alert("회원정보 수정이 완료되었습니다.");
                window.location.href = "index.jsp"; // 성공적으로 업데이트 후 리다이렉트
            </script>
<%
        }
    }

    if (!passwordCorrect) {
%>
        <script>
            alert("비밀번호가 틀렸습니다.");
            window.location.href = "editProfile.jsp"; // 업데이트 페이지로 리다이렉트
        </script>
<%
    }
} catch (SQLException e) {
    out.println("데이터베이스 오류 발생: " + e.getMessage());
} finally {
    jdbc.close();
}
%>
