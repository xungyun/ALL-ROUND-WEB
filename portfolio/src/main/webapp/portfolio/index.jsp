<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ALL ROUND</title>
    <link rel="stylesheet" href="style.css">
    <style>
    body {
    	font-family: 'NEXONFootballGothicBA1';
    }
    .slideshow-container {
        position: relative;
        max-width: 100%;
        margin: auto;
    }
    .slide {
        display: none;
    }
    img {
        width: 100%;
        height: auto;
    }
    </style>
</head>
<body>
    <jsp:include page="header.jsp"></jsp:include>
    <section class="main-section">
        <div class="slideshow-container">
            <div class="slide">
                <img src="images/ground1.jpg" alt="ground-image-1">
            </div>
            <div class="slide">
                <img src="images/ground.jpg" alt="ground-image-2">
            </div>
            <div class="slide">
                <img src="images/ground2.jpg" alt="ground-image-3">
            </div>
        </div>
    </section>
    <jsp:include page="footer.jsp"></jsp:include>

    <script>
        let slideIndex = 0;
        showSlides();

        function showSlides() {
            let slides = document.getElementsByClassName("slide");
            for (let i = 0; i < slides.length; i++) {
                slides[i].style.display = "none";  
            }
            slideIndex++;
            if (slideIndex > slides.length) {slideIndex = 1}    
            slides[slideIndex - 1].style.display = "block";  
            setTimeout(showSlides, 5000); // 5초마다 슬라이드 변경
        }
    </script>
</body>
</html>