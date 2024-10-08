<%@ page import="java.sql.Statement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="portfolio.JDBConnect"%>
<%
    JDBConnect jdbc = new JDBConnect();
    int pageSize = 5; // 한 페이지에 보여줄 게시물 수
    int pageNumber = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
    int offset = (pageNumber - 1) * pageSize + 1; // OFFSET 계산
    int endOffset = offset + pageSize - 1; // 종료 OFFSET

    // 15분이 지난 게시물 삭제
    String deleteSql = "DELETE FROM MiddleClassMatches WHERE CREATED_AT < SYSTIMESTAMP - INTERVAL '15' MINUTE";
    PreparedStatement deleteStmt = jdbc.con.prepareStatement(deleteSql);
    deleteStmt.executeUpdate();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>중급 매치</title>
    <link rel="stylesheet" href="style.css">
    <style>
    body {
    	font-family: 'NEXONFootballGothicBA1';
    }
    </style>
</head>
<body>
    <jsp:include page="header.jsp"></jsp:include>
    <section class="title"><br>
        <p>중급 실력을 가지신 분들이 팀을 꾸릴 수 있습니다.</p>
        <p>제목에 반드시 지역 + 풋살장 이름이 포함되어야합니다.</p>
        <p>실력을 속이신 분들은 10일 동안 매치 및 구인구직 밴입니다.</p>
        <p>실력을 속인 문제는 관리자들이 판단하여 제재합니다.</p>
        <p>게시물은 15분뒤 자동삭제됩니다.</p>
    </section>
    
    <section class="main-section">
        <h2>중급 매치 목록</h2>
        
        <div class="match-listing">
            <ul>
                <%
                try {
                    String sql = "SELECT * FROM (SELECT MATCH_ID, TITLE, DESCRIPTION, CONTACT, USERNAME, CREATED_AT, ROW_NUMBER() OVER (ORDER BY MATCH_ID) AS rn FROM MiddleClassMatches) WHERE rn BETWEEN ? AND ?";
                    PreparedStatement pstmt = jdbc.con.prepareStatement(sql);
                    pstmt.setInt(1, offset);
                    pstmt.setInt(2, endOffset);
                    ResultSet rs = pstmt.executeQuery();

                    while (rs.next()) {
                        String matchTitle = rs.getString("TITLE");
                        String matchDescription = rs.getString("DESCRIPTION");
                        String matchContact = rs.getString("CONTACT");
                        String matchUsername = rs.getString("USERNAME");
                        String createdAt = rs.getString("CREATED_AT");
                %>
                        <li>
                            <h4><%= matchTitle %> (작성자: <%= matchUsername %>)</h4>
                            <p><%= matchDescription %> - 연락처: <%= matchContact %></p>
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
            String countSql = "SELECT COUNT(*) FROM MiddleClassMatches";
            Statement countStmt = jdbc.con.createStatement();
            ResultSet countRs = countStmt.executeQuery(countSql);
            countRs.next();
            int totalCount = countRs.getInt(1);
            int totalPages = (int) Math.ceil(totalCount / (double) pageSize);
            %>
            <p>
                <% for (int i = 1; i <= totalPages; i++) { %>
                    <a href="?page=<%= i %>"><%= i %></a>
                <% } %>
            </p>
        </div>

        <%
        // 로그인 체크
        String username = (String) session.getAttribute("username");
        if (username != null) {
        %>
            <div class="post-match">
                <h3>매치 게시하기</h3>
                <form action="postMiddleMatchAction.jsp" method="post">
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
