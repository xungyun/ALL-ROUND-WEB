<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page import="java.sql.Statement" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="portfolio.JDBConnect" %>
<%
    JDBConnect jdbc = new JDBConnect();

    // 일주일 지난 모집글 삭제
    String deleteSql = "DELETE FROM GuestRecruitments WHERE CREATED_AT < SYSDATE - INTERVAL '7' DAY";
    try {
        Statement stmt = jdbc.con.createStatement();
        stmt.executeUpdate(deleteSql);
    } catch (SQLException e) {
        out.println("모집글 삭제 오류: " + e.getMessage());
    }

    // 페이지 처리
    int pageSize = 7; // 한 페이지에 표시할 게시글 수
    int pageNum = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
    int offset = (pageNum - 1) * pageSize;

    // 모집글 목록 가져오기
    List<String[]> recruitmentList = new ArrayList<>();
    try {
        String sql = "SELECT * FROM GuestRecruitments ORDER BY CREATED_AT DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        PreparedStatement pstmt = jdbc.con.prepareStatement(sql);
        pstmt.setInt(1, offset);
        pstmt.setInt(2, pageSize);
        ResultSet rs = pstmt.executeQuery();

        while (rs.next()) {
            String recruitmentType = rs.getString("TYPE");
            String recruitmentRegion = rs.getString("REGION");
            String recruitmentDescription = rs.getString("DESCRIPTION");
            String createdAt = rs.getString("CREATED_AT");
            recruitmentList.add(new String[]{recruitmentType, recruitmentRegion, recruitmentDescription, createdAt});
        }
    } catch (SQLException e) {
        out.println("데이터베이스 오류 발생: " + e.getMessage());
    }

    // 전체 모집글 수 가져오기
    int totalRecords = 0;
    try {
        String countSql = "SELECT COUNT(*) FROM GuestRecruitments";
        Statement countStmt = jdbc.con.createStatement();
        ResultSet countRs = countStmt.executeQuery(countSql);
        if (countRs.next()) {
            totalRecords = countRs.getInt(1);
        }
    } catch (SQLException e) {
        out.println("데이터베이스 오류 발생: " + e.getMessage());
    }

    int totalPages = (int) Math.ceil((double) totalRecords / pageSize); // 총 페이지 수
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게스트 모집</title>
    <link rel="stylesheet" href="style.css">
    <style>
    body {
    	font-family: 'NEXONFootballGothicBA1';
    }
	</style>
    <script>
        function confirmRecruitment() {
            const confirmation = confirm("모집글 작성을 정말 하시겠습니까?");
            if (confirmation) {
                alert("모집글이 작성되었습니다.");
                document.getElementById("recruitmentForm").submit();
            }
        }
    </script>
    <style>
        .recruitment-list ul {
            list-style-type: none; /* 점 제거 */
            padding: 0; /* 기본 패딩 제거 */
            margin: 0; /* 기본 마진 제거 */
        }
        .recruitment-list li {
            margin-bottom: 10px; /* 항목 간 간격 조정 (필요시) */
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp"></jsp:include>
    
    <section class="main-section">
        <h2>게스트 모집</h2>
        <p>팀에 입단하기 전, 경험해보고 싶으신 분들을 모집합니다.</p>
        <p>제목에 반드시 지역 + 팀 이름이 포함되어야합니다.</p>
        <p>모집 게시글은 작성일 기준 일주일 뒤 삭제됩니다.</p>
        <p>설명란에 연락처도 함께 작성해주시길 바랍니다.</p>
        <p>---------------------------------------------------------------------------</p>
		<br><br>	        
        <div class="recruitment-form">
            <h3>모집글 작성하기</h3>
            <%
            // 로그인 체크
            String username = (String) session.getAttribute("username");
            if (username != null) {
            %>
                <form id="recruitmentForm" action="submitRecruitmentAction.jsp" method="post" onsubmit="event.preventDefault(); confirmRecruitment();">
                    <label for="type">유형:</label>
                    <select id="type" name="type" required>
                        <option value="풋살">풋살</option>
                        <option value="축구">축구</option>
                    </select>

                    <label for="region">지역:</label>
                    <input type="text" id="region" name="region" required placeholder="지역 입력">

                    <label for="description">모집 설명:</label>
                    <textarea id="description" name="description" required placeholder="모집 설명 입력"></textarea>
                    
                    <button type="submit">작성하기</button>
                </form>
            <%
            } else {
            %>
                <p>모집글을 작성하려면 <a href="login.jsp"><b>로그인</b></a> 해주세요.</p>
            <%
            }
            %>
        </div>

        <div class="recruitment-list"><br><br>
            <p>---------------------------------------------------------------------------</p>
            <h3>모집글 목록</h3>
            <ul>
                <%
                for (String[] recruitment : recruitmentList) {
                    String recruitmentType = recruitment[0];
                    String recruitmentRegion = recruitment[1];
                    String recruitmentDescription = recruitment[2];
                    String createdAt = recruitment[3];
                %>
                    <li>
                        <h4><%= recruitmentType %> (지역: <%= recruitmentRegion %>)</h4>
                        <p><%= recruitmentDescription %></p>
                        <p>작성일: <%= createdAt %></p>
                    </li>
                <%
                }
                %>
            </ul>
        </div>

        <div class="pagination">
            <%
            if (totalPages > 1) {
                for (int i = 1; i <= totalPages; i++) {
                    if (i == pageNum) {
            %>
                        <strong><%= i %></strong>
            <%
                    } else {
            %>
                        <a href="?page=<%= i %>"><%= i %></a>
            <%
                    }
                }
            }
            %>
        </div>
    </section>
    
    <jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
