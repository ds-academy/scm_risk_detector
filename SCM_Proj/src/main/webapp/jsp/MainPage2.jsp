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
    <link rel="stylesheet" href="../css/Mainpage2.css">
    
    <!-- jQuery와 Chart.js 라이브러리 로드 -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
            <div class="charts-container">
                <div class="chart-wrapper">
                    <canvas id="stockChart1" width="400" height="200"></canvas>
                </div>
                <div class="chart-wrapper">
                    <canvas id="stockChart2" width="400" height="200"></canvas>
                </div>
            </div>
        </section>
    </main>

    <script>
    $(document).ready(function() {
        fetchMarketData();
        setInterval(fetchMarketData, 10000); // 10초마다 업데이트

        initializeCharts();  // 차트 초기화
    });

    function fetchMarketData() {
        updatePrice('kospiClose', '#kospi-price');
        updatePrice('kosdaqClose', '#kosdaq-price');
        updatePrice('sp500Close', '#sp500-price');
    }

    function updatePrice(action, elementId) {
        var contextPath = '<%= request.getContextPath() %>';
        var requestUrl = contextPath + '/stocks';

        console.log("Requesting URL:", requestUrl, "with action:", action);

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

    function initializeCharts() {
        const ctx1 = document.getElementById('stockChart1').getContext('2d');
        new Chart(ctx1, {
            type: 'line',
            data: {
                labels: ['9:00', '10:00', '11:00', '12:00', '13:00', '14:00', '15:00'],
                datasets: [{
                    label: '코스피',
                    data: [2650, 2655, 2658, 2654, 2657, 2659, 2658],
                    borderColor: '#326CF9',
                    tension: 0.4,
                    borderWidth: 2,
                    pointRadius: 0,
                    fill: false
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false },
                    title: { display: true, text: '코스피 지수' }
                },
                scales: {
                    x: { grid: { display: false } },
                    y: { grid: { color: '#E5E8EB' } }
                }
            }
        });

        const ctx2 = document.getElementById('stockChart2').getContext('2d');
        new Chart(ctx2, {
            type: 'bar',
            data: {
                labels: ['9:00', '10:00', '11:00', '12:00', '13:00', '14:00', '15:00'],
                datasets: [{
                    label: '거래량',
                    data: [1200, 1500, 1300, 1400, 1600, 1450, 1350],
                    backgroundColor: 'rgba(50, 108, 249, 0.2)',
                    borderColor: '#326CF9',
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false },
                    title: { display: true, text: '거래량' }
                },
                scales: {
                    x: { grid: { display: false } },
                    y: { grid: { color: '#E5E8EB' } }
                }
            }
        });
    }
    </script>
</body>
</html>
