<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="portfolio.JDBConnect" %>
<%
    // 데이터베이스 연결
    JDBConnect jdbc = new JDBConnect();
    
    // 폼에서 전달된 데이터 받기
    String type = request.getParameter("type");
    String region = request.getParameter("region");
    String description = request.getParameter("description");

    // SQL 쿼리 준비
    String insertSql = "INSERT INTO GuestRecruitments (TYPE, REGION, DESCRIPTION, CREATED_AT) VALUES (?, ?, ?, CURRENT_TIMESTAMP)";
    
    try {
        PreparedStatement pstmt = jdbc.con.prepareStatement(insertSql);
        pstmt.setString(1, type);
        pstmt.setString(2, region);
        pstmt.setString(3, description);
        
        // 데이터 삽입 실행
        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
            // 성공 메시지
            out.println("<script>alert('모집글이 성공적으로 작성되었습니다.'); window.location.href='guestRecruitment.jsp';</script>");
        } else {
            // 실패 메시지
            out.println("<script>alert('모집글 작성에 실패했습니다. 다시 시도해 주세요.'); window.location.href='guestRecruitment.jsp';</script>");
        }
    } catch (SQLException e) {
        out.println("<script>alert('데이터베이스 오류: " + e.getMessage() + "'); window.location.href='guestRecruitment.jsp';</script>");
    } finally {
        // 자원 해제
        try {
            jdbc.con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
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