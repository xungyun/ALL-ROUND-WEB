<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<header>
    <nav class="sidebar">
        <div class="menu">
            <button class="menu-toggle">☰</button>
            <div class="submenu">
                <a href="index.jsp">Home</a>
                <a href="memberList.jsp">Search</a>
                <a href="addMember.jsp">Add</a>
                <a href="allMatches.jsp">전체 구인/구직</a>
                <a href="beginner.jsp">초급 구인/구직</a>
                <a href="middleclass.jsp">중급 구인/구직</a> 
                <a href="advanced.jsp">상급 구인/구직</a> 
                <a href="soccer.jsp">축구 구인/구직 및 매치</a>
                <a href="fourVsFour.jsp">4 vs 4 매치</a>
                <a href="indoor.jsp">실내 풋살장 매치</a>
                <a href="outdoor.jsp">야외 풋살장 매치</a>
                <a href="team.jsp">팀</a>
                <a href="guestRecruitment.jsp">게스트모집</a>
                <a href="map.jsp">지도</a>
            </div>
        </div>
    </nav>
    <div class="logo">
    <a href="index.jsp"><h1>ALL ROUND⚽</h1></a>
</div>

<div class="header-container">
    <div class="search-container">
        <form action="searchResults.jsp" class="search-container" method="get">
            <input class="inputt" type="text" name="query" placeholder="검색어를 입력하세요" required>
            <button type="submit">검색</button>
        </form>
    </div>
</div>

<div class="auth-buttons">
    <%
    String username = (String) session.getAttribute("username");
    if (username != null) {
    %>
        <span>Welcome, <%= username %>!</span>
        <a href="logout.jsp">Logout</a>
        <a href="editProfile.jsp">Update</a>
    <%
    } else {
    %>
        <a href="login.jsp">Login</a>
        <a href="signup.jsp">Sign Up</a>
    <%
    }
    %>
</div>
</header>

<!-- 모달 -->
<div id="myModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <!-- <h2>메뉴</h2> -->
        <div class="match-section">
        	<div class="left-content">
            <h3>Matching</h3>
            <ul>
                <li><a href="allMatches.jsp">ALL 구인/구직</a></li> <!-- 전체 매치 링크 추가 -->
                <li><a href="beginner.jsp">초급</a></li>
                <li><a href="middleclass.jsp">중급</a></li>
                <li><a href="advanced.jsp">고급</a></li>
                <li><a href="soccer.jsp">축구</a></li>
                <li><a href="fourVsFour.jsp">4vs4</a></li>
                <li><a href="indoor.jsp">실내</a></li>
                <li><a href="outdoor.jsp">야외</a></li>
            </ul>
        	</div>
        </div>
        <div class="team-section">
        <div class="right-content">
            <h3>Team</h3>
            <ul>
                <li><a href="team.jsp">팀</a></li>
                <li><a href="guestRecruitment.jsp">게스트 모집</a></li>
            </ul>
        </div>
        </div>
        <div class="map-section">
        	<h3>Map</h3>
        	<ul>
        		<li><a href="map.jsp">지도</a></li>
        	</ul>
        </div>
    </div>
</div>

<script>
    var modal = document.getElementById("myModal");
    var btn = document.querySelector(".menu-toggle");
    var span = document.getElementsByClassName("close")[0];

    btn.onclick = function() {
        modal.style.display = "block"; // 모달 보여주기
    }

    span.onclick = function() {
        modal.style.display = "none"; // 모달 닫기
    }

    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none"; // 모달 외부 클릭 시 닫기
        }
    }

    // 링크 클릭 시 모달 닫고 이동하도록 설정
    const links = document.querySelectorAll('.submenu a, .match-section a, .team-section a');
    links.forEach(link => {
        link.addEventListener('click', function() {
            modal.style.display = "none"; // 모달 닫기
        });
    });
</script>

