<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="portfolio.JDBConnect" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>검색 결과</title>
    <link rel="stylesheet" href="style.css">
    <style>
    body {
    	font-family: 'NEXONFootballGothicBA1';
    }
    </style>
</head>
<body>
    <jsp:include page="header.jsp"></jsp:include>
    <section class="main-section">
        <h2>검색 결과</h2>
        <div class="search-container">
            <form action="searchResults.jsp" method="get">
                <input type="text" name="query" placeholder="검색어를 입력하세요" required>
                <button type="submit">검색</button>
            </form>
        </div>
        <%
            String query = request.getParameter("query");
            if (query != null && !query.isEmpty()) {
                JDBConnect db = new JDBConnect(); // 기본 생성자 호출
                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;

                try {
                    conn = db.con; // DB 연결 가져오기

                    // 검색 쿼리 작성 (여러 테이블에서 검색)
                    String sqlUsers = "SELECT USERNAME FROM Users WHERE USERNAME LIKE ?";
                    String sqlJobs = "SELECT TITLE FROM Jobs WHERE TITLE LIKE ?";
                    String sqlTeams = "SELECT TEAM_NAME FROM Teams WHERE TEAM_NAME LIKE ?";
                    String sqlRecruitments = "SELECT TYPE FROM GuestRecruitments WHERE DESCRIPTION LIKE ?";

                    boolean found = false;

                    // 사용자 검색
                    stmt = conn.prepareStatement(sqlUsers);
                    stmt.setString(1, "%" + query + "%");
                    rs = stmt.executeQuery();

                    if (rs.next()) {
                        found = true;
                        out.println("<h3>사용자 검색 결과:</h3><ul>");
                        do {
                            out.println("<li>" + rs.getString("USERNAME") + "</li>");
                        } while (rs.next());
                        out.println("</ul>");
                    }

                    // 구인/구직 검색
                    stmt = conn.prepareStatement(sqlJobs);
                    stmt.setString(1, "%" + query + "%");
                    rs = stmt.executeQuery();

                    if (rs.next()) {
                        found = true;
                        out.println("<h3>구인/구직 검색 결과:</h3><ul>");
                        do {
                            out.println("<li>" + rs.getString("TITLE") + "</li>");
                        } while (rs.next());
                        out.println("</ul>");
                    }

                    // 팀 검색
                    stmt = conn.prepareStatement(sqlTeams);
                    stmt.setString(1, "%" + query + "%");
                    rs = stmt.executeQuery();

                    if (rs.next()) {
                        found = true;
                        out.println("<h3>팀 검색 결과:</h3><ul>");
                        do {
                            out.println("<li>" + rs.getString("TEAM_NAME") + "</li>");
                        } while (rs.next());
                        out.println("</ul>");
                    }

                    // 게스트 모집 검색
                    stmt = conn.prepareStatement(sqlRecruitments);
                    stmt.setString(1, "%" + query + "%");
                    rs = stmt.executeQuery();

                    if (rs.next()) {
                        found = true;
                        out.println("<h3>게스트 모집 검색 결과:</h3><ul>");
                        do {
                            out.println("<li>" + rs.getString("TYPE") + "</li>");
                        } while (rs.next());
                        out.println("</ul>");
                    }

                    if (!found) {
                        out.println("<p>검색 결과가 없습니다.</p>");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<p>검색 중 데이터베이스 오류가 발생했습니다.</p>");
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<p>검색 중 오류가 발생했습니다.</p>");
                } finally {
                    // 자원 해제
                    db.close(); // JDBConnect 클래스의 close 메서드 호출
                }
            } else {
                out.println("<p>검색어를 입력하세요.</p>");
            }
        %>
    </section>
    <jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
