<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="portfolio.JDBConnect"%>
<%
String jobId = request.getParameter("jobId");
String type = request.getParameter("type");
String title = request.getParameter("title");
String description = request.getParameter("description");
String contact = request.getParameter("contact");

JDBConnect jdbc = new JDBConnect();
try {
    String sql = "UPDATE Jobs SET TYPE = ?, TITLE = ?, DESCRIPTION = ?, CONTACT = ? WHERE JOB_ID = ?";
    PreparedStatement pstmt = jdbc.con.prepareStatement(sql);
    pstmt.setString(1, type);
    pstmt.setString(2, title);
    pstmt.setString(3, description);
    pstmt.setString(4, contact);
    pstmt.setString(5, jobId);
    pstmt.executeUpdate();
    response.sendRedirect("allMatches.jsp"); // 수정 후 목록으로 리다이렉트
} catch (SQLException e) {
    out.println("데이터베이스 오류 발생: " + e.getMessage());
} finally {
    jdbc.close();
}
%>
