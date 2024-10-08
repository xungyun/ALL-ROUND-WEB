<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="portfolio.JDBConnect" %>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    JDBConnect jdbc = new JDBConnect();

    boolean loginSuccess = false;

    try {
        // 로그인 검증 로직
        String sql = "SELECT * FROM Users WHERE username = ? AND password = ?";
        PreparedStatement pstmt = jdbc.con.prepareStatement(sql);
        pstmt.setString(1, username);
        pstmt.setString(2, password);
        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            loginSuccess = true;
            session.setAttribute("username", username);
            response.sendRedirect("index.jsp"); // 로그인 성공 시 홈으로 리다이렉트
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    if (!loginSuccess) {
        String errorMessage = "잘못된 사용자 이름이나 비밀번호입니다.";
        response.sendRedirect("login.jsp?error=" + java.net.URLEncoder.encode(errorMessage, "UTF-8"));
    }
%>
