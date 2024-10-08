<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="portfolio.JDBConnect" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>아이디/비밀번호 찾기 결과</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="form-container">
        <h2>아이디/비밀번호 찾기 결과</h2>
        <%
            String email = request.getParameter("email");
            String username = null;
            String password = null;

            JDBConnect jdbc = new JDBConnect(); // JDBConnect 객체 생성
            Connection conn = null; // 연결 객체
            PreparedStatement pstmt = null; // PreparedStatement 객체
            ResultSet rs = null; // ResultSet 객체

            try {
                // 데이터베이스 연결
                conn = jdbc.con; // 기존 연결 방식 사용

                // SQL 쿼리 작성
                String sql = "SELECT USERNAME, PASSWORD FROM Users WHERE EMAIL = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, email);
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    username = rs.getString("USERNAME");
                    password = rs.getString("PASSWORD");
                } else {
                    out.println("<p>등록된 이메일이 아닙니다.</p>");
                }
            } catch (SQLException e) {
                out.println("<p>오류가 발생했습니다. 다시 시도해 주세요.</p>");
                e.printStackTrace(); // 오류 로그 출력
            } finally {
                // 자원 해제
                if (rs != null) try { rs.close(); } catch (SQLException e) { }
                if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { }
                if (conn != null) try { conn.close(); } catch (SQLException e) { } // 연결 해제
                jdbc.close(); // JDBConnect에서 닫기
            }

            if (username != null && password != null) {
                out.println("<p>아이디: " + username + "</p>");
                out.println("<p>비밀번호: " + password + "</p>");
            }
        %>
        <a href="login.jsp" class="btn">로그인 페이지로 돌아가기</a>
    </div>
</body>
</html>
