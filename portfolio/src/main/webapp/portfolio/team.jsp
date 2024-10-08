<%@ page import="java.sql.Statement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="portfolio.JDBConnect"%>
<%
    JDBConnect jdbc = new JDBConnect();
    
    // 매월 1일에 팀 삭제
    String deleteSql = "DELETE FROM Teams WHERE CREATED_AT < TRUNC(SYSDATE, 'MM') - INTERVAL '1' DAY";
    try {
        Statement stmt = jdbc.con.createStatement();
        stmt.executeUpdate(deleteSql);
    } catch (SQLException e) {
        out.println("팀 삭제 오류: " + e.getMessage());
    }

    String sportType = request.getParameter("type"); // 기본값: 없음
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>팀 목록 선택</title>
    <link rel="stylesheet" href="style.css">
    <script>
        function confirmRegistration() {
            const confirmation = confirm("팀 등록을 정말 하시겠습니까?");
            if (confirmation) {
                alert("등록이 완료되었습니다.");
                document.getElementById("teamForm").submit();
            }
        }
    </script>
    <style>
        .team-listing ul {
            list-style-type: none; /* 점 제거 */
            padding: 0; /* 기본 패딩 제거 */
            margin: 0; /* 기본 마진 제거 */
        }
        .team-listing li {
            margin-bottom: 10px; /* 항목 간 간격 조정 (필요시) */
        }
       
   		 body {
   	 		font-family: 'NEXONFootballGothicBA1';
  		 }
    </style>
</head>
<body>
    <jsp:include page="header.jsp"></jsp:include>
    
    <section class="main-section">
        <h2>팀 목록</h2>
        
        <p>타 지역 대회를 참여하고 싶으신 팀들은 타지역으로 이동하셔야 합니다.</p>
        <p>리그 참여 신청 후 불참하시면 패널티가 주어집니다.</p>
        <p>---------------------------------------------------------------------------</p>
        <p>팀 목록은 갱신하기위해 한달마다 자동 삭제됩니다.</p>
        <p>삭제 된 후 재등록을 통해 갱신 부탁드립니다. 감사합니다.</p>
        <p>---------------------------------------------------------------------------</p>
        <p>설명란에 연락처도 함께 작성해주시길 바랍니다.</p>
        <div class="team-type-select">
            <br><a href="?type=풋살" <%= sportType != null && sportType.equals("풋살") ? "class='active'" : "" %>>풋살 팀</a>
            <a href="?type=축구" <%= sportType != null && sportType.equals("축구") ? "class='active'" : "" %>>축구 팀</a>
        </div>

        <div class="team-listing">
            <ul>
                <%
                if (sportType != null) { // sportType이 선택되었을 때만 실행
                    try {
                        String sql = "SELECT * FROM Teams WHERE TYPE = ?";
                        PreparedStatement pstmt = jdbc.con.prepareStatement(sql);
                        pstmt.setString(1, sportType);
                        ResultSet rs = pstmt.executeQuery();

                        while (rs.next()) {
                            String teamName = rs.getString("TEAM_NAME");
                            String teamDescription = rs.getString("DESCRIPTION");
                %>
                            <li>
                                <h4><%= teamName %></h4>
                                <p><%= teamDescription %></p>
                            </li>
                <%
                        }
                    } catch (SQLException e) {
                        out.println("데이터베이스 오류 발생: " + e.getMessage());
                    }
                } 
                %>
            </ul>
        </div>

        <%-- 팀 등록 폼 추가 --%>
        <div class="team-registration">
            <p>-----------------------------------------</p><br><br>
            <h3>팀 등록하기</h3>
            <%
            // 로그인 체크
            String username = (String) session.getAttribute("username");
            if (username != null) {
            %>
                <form id="teamForm" action="registerTeamAction.jsp" method="post" onsubmit="event.preventDefault(); confirmRegistration();">
                    <label for="type">유형:</label>
                    <select id="type" name="type" required>
                        <option value="풋살">풋살</option>
                        <option value="축구">축구</option>
                    </select>
                    <label for="teamName">팀 이름:</label>
                    <input type="text" id="teamName" name="teamName" required>
                    <label for="description">설명:</label>
                    <textarea id="description" name="description" required></textarea>
                    <label for="region">지역:</label>
                    <input type="text" id="region" name="region" required placeholder="지역 입력">
               
                    <button type="submit">등록하기</button>
                </form>
            <%
            } else {
            %>
                <p>게시물을 작성하려면 <a href="login.jsp"><b>로그인</b></a> 해주세요.</p>
            <%
            }
            %>
        </div>

    </section>
    
    <jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
