<%@page import="java.sql.Statement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="portfolio.JDBConnect"%>
<%
    JDBConnect jdbc = new JDBConnect();
    int pageSize = 5; // 한 페이지에 보여줄 게시물 수
    int pageNumber = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
    String jobType = request.getParameter("type") != null ? request.getParameter("type") : null; // 기본값 없음
    int offset = (pageNumber - 1) * pageSize + 1; // OFFSET 계산
    int endOffset = offset + pageSize - 1; // 종료 OFFSET

    // 15분이 지난 게시물 삭제
    String deleteSql = "DELETE FROM Jobs WHERE CREATED_AT < SYSTIMESTAMP - INTERVAL '15' MINUTE";
    PreparedStatement deleteStmt = jdbc.con.prepareStatement(deleteSql);
    deleteStmt.executeUpdate();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>전체 매치</title>
    <link rel="stylesheet" href="style.css">
    <style>
    body {
    	font-family: 'NEXONFootballGothicBA1';
    }
    </style>
</head>
<body>
	<!-- <img src="images/player.jpg" alt="player-image"> -->
    <jsp:include page="header.jsp"></jsp:include>
    <section class="title"><br>
    	<p>초급/중급/상급 실력이 섞여 팀을 꾸릴 수 있습니다.</p>
    	<p>제목에 반드시 지역 + 풋살장 이름이 포함되어야합니다.</p>
    	<p>게시물은 15분뒤 자동삭제됩니다.</p>
    </section>

    <section class="main-section">
        <h2>목록 선택</h2>
        <div class="job-type-select">
            <br><a href="?type=구인&page=1">구인 목록</a>
            <a href="?type=구직&page=1">구직 목록</a>
        </div>

        <% if (jobType != null) { %>
            <h2><%= jobType %> 목록</h2>

            <div class="job-listing">
                <ul>
                    <%
                    try {
                        String sql = "SELECT * FROM (SELECT JOB_ID, TYPE, TITLE, DESCRIPTION, CONTACT, USERNAME, CREATED_AT, ROW_NUMBER() OVER (ORDER BY JOB_ID) AS rn FROM Jobs WHERE TYPE = ?) WHERE rn BETWEEN ? AND ?";
                        PreparedStatement pstmt = jdbc.con.prepareStatement(sql);
                        pstmt.setString(1, jobType);
                        pstmt.setInt(2, offset);
                        pstmt.setInt(3, endOffset);
                        ResultSet rs = pstmt.executeQuery();

                        while (rs.next()) {
                            String jobTitle = rs.getString("TITLE");
                            String jobDescription = rs.getString("DESCRIPTION");
                            String jobContact = rs.getString("CONTACT");
                            String jobUsername = rs.getString("USERNAME");
                            int jobId = rs.getInt("JOB_ID");
                            String createdAt = rs.getString("CREATED_AT");
                    %>
                            <li>
                                <h4><%= jobTitle %> (작성자: <%= jobUsername %>)</h4>
                                <p><%= jobDescription %> - 연락처: <%= jobContact %></p>
                                <p>작성일: <%= createdAt %></p>
                            </li>
                    <%
                        }
                    } catch (SQLException e) {
                        out.println("데이터베이스 오류 발생: " + e.getMessage());
                    }
                    %>
                </ul>
            </div>

            <div class="pagination">
                <%
                // 페이지 수 계산
                String countSql = "SELECT COUNT(*) FROM Jobs WHERE TYPE = ?";
                PreparedStatement countStmt = jdbc.con.prepareStatement(countSql);
                countStmt.setString(1, jobType);
                ResultSet countRs = countStmt.executeQuery();

                if (countRs.next()) {
                    int totalCount = countRs.getInt(1);
                    int totalPages = (int) Math.ceil(totalCount / (double) pageSize);
                %>
                    <p>
                        <% for (int i = 1; i <= totalPages; i++) { %>
                            <a href="?type=<%= jobType %>&page=<%= i %>"><%= i %></a>
                        <% } %>
                    </p>
                <%
                }
                %>
            </div>
        <% } %>

        <%
        // 로그인 체크
        String username = (String) session.getAttribute("username");
        if (username != null) {
        %>
            <div class="post-job"><p>-----------------------------------------</p><br><br>
                <h3>구인/구직 게시하기</h3>
                <form action="postJobAction.jsp" method="post">
                    <label for="type">유형:</label>
                    <select id="type" name="type" required>
                        <option value="구인" <% if ("구인".equals(jobType)) out.print("selected"); %>>구인</option>
                        <option value="구직" <% if ("구직".equals(jobType)) out.print("selected"); %>>구직</option>
                    </select>
                    <label for="title">제목:</label>
                    <input type="text" id="title" name="title" required>

                    <label for="description">설명:</label>
                    <textarea id="description" name="description" required></textarea>

                    <label for="contact">연락처:</label>
                    <input type="text" id="contact" name="contact" required>
                    <button type="submit">게시하기</button>
                </form>
            </div>
        <%
        } else {
        %>
            <br><br><p>게시물을 작성하려면 <a href="login.jsp"><b>로그인</b></a> 해주세요.</p>
        <%
        }
        %>
    </section>

    <jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
