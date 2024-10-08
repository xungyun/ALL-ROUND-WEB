<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
session.invalidate(); // 세션 무효화
response.sendRedirect("index.jsp"); // 로그아웃 후 메인 페이지로 리다이렉트
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
    body {
    	font-family: 'NEXONFootballGothicBA1';
    }
</style>
</head>
<body>

</body>
</html>