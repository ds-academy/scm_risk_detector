<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="com.scm.model.StockDAO" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SPAndTech</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="../css/Mainpage2.css">
</head>
<body>
    <nav class="navbar">
        <div class="logo">
            <i class="fas fa-leaf"></i> SPAndTech
        </div>
        <div class="nav-links">
   	        <a href="Mainpage2.html">홈</a>
    	    <a href="Mypage.html">마이페이지</a>
        	<a href="#">설정</a>
        	<a href="SecondPage.html">리스크</a>
        </div>
        <div class="search-bar">
            <input type="text" placeholder="종목명, 종목코드 검색">
        </div>
        <button class="btn-login">로그인</button>
    </nav>

    <main class="main-content">
        <section class="market-summary">
            <h2 class="section-title">실시간 시장 동향</h2>
            <div class="stock-grid">
                <div class="stock-card">
                    <div class="stock-name">코스피</div>
                    <div class="stock-price" id="kospi-price">2,658.35</div>
                </div>
                <div class="stock-card">
                    <div class="stock-name">코스닥</div>
                    <div class="stock-price" id="kosdaq-price">865.62</div>
                </div>
                <div class="stock-card">
                    <div class="stock-name">S&P 500</div>
                    <div class="stock-price" id="sp500-price">4,890.97</div>
                </div>
            </div>
        </section>
    </main>

    <script>
    $(document).ready(function() {
        fetchMarketData();
        setInterval(fetchMarketData, 10000); // 10초마다 업데이트
    });

    function fetchMarketData() {
        updatePrice('kospiClose', '#kospi-price');
        updatePrice('kosdaqClose', '#kosdaq-price');
        updatePrice('sp500Close', '#sp500-price');
    }

    function updatePrice(action, elementId) {
        var contextPath = '<%= request.getContextPath() %>';  // 컨텍스트 경로 가져오기
        var requestUrl = contextPath + '/stocks';

        console.log("Requesting URL:", requestUrl, "with action:", action);  // 디버깅용 로그 추가

        $.ajax({
            url: requestUrl,
            method: 'GET',
            data: { action: action },
            dataType: 'json',
            success: function(data) {
                $(elementId).text(data.toLocaleString());
            },
            error: function(xhr, status, error) {
                console.error(`데이터 가져오기 실패 (${action}):`, xhr.status, error);
            }
        });
    }

    </script>
</body>
</html>
