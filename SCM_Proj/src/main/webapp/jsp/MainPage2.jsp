<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Graph Test Page</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="../css/Mainpage2.css">
</head>
<body>
    <main class="main-content">
        <section class="market-summary">
            <h2 class="section-title">그래프 테스트</h2>
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
                    <canvas id="stockChart1"></canvas>
                </div>
                <div class="chart-wrapper">
                    <canvas id="stockChart2"></canvas>
                </div>
            </div>
        </section>
    </main>

    <script>
    $(document).ready(function() {
        fetchMarketData();
        /* setInterval(fetchMarketData, 10000); // 10초마다 업데이트 */
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

 // 📈 차트 초기화 (코스피 지수 및 거래량)
    function initializeCharts() {
        fetchKospiIndex();  // 코스피 지수 데이터 요청
        fetchKospiVolume(); // 코스피 거래량 데이터 요청
    }

    // 📌 코스피 지수 데이터 가져오기
    function fetchKospiIndex() {
        $.ajax({
            url: '<%= request.getContextPath() %>/stocks',
            method: 'GET',
            data: { action: 'kospiIndex' },
            dataType: 'json',
            success: function(data) {
                if (!data || data.length === 0) {
                    console.warn("🚨 코스피 지수 데이터 없음");
                    return;
                }

                const labels = data.map(item => new Date(item.DATE).toLocaleDateString());
                const closePrices = data.map(item => parseFloat(item.CLOSE));

                drawKospiChart(labels.reverse(), closePrices.reverse());
            },
            error: function(xhr, status, error) {
                console.error("❌ 코스피 지수 데이터 가져오기 실패:", xhr.status, error);
            }
        });
    }

    // 📊 코스피 거래량 데이터 가져오기
    function fetchKospiVolume() {
        $.ajax({
            url: '<%= request.getContextPath() %>/stocks',
            method: 'GET',
            data: { action: 'kospiVolume' },
            dataType: 'json',
            success: function(data) {
                if (!data || data.length === 0) {
                    console.warn("🚨 코스피 거래량 데이터 없음");
                    return;
                }

                const labels = data.map(item => new Date(item.DATE).toLocaleDateString());
                const volumes = data.map(item => parseInt(item.VOLUME));

                drawKospiVolumeChart(labels.reverse(), volumes.reverse());
            },
            error: function(xhr, status, error) {
                console.error("❌ 코스피 거래량 데이터 가져오기 실패:", xhr.status, error);
            }
        });
    }

    // 📈 코스피 지수 그래프 그리기
    function drawKospiChart(labels, dataPoints) {
        console.log("코스피 지수 데이터:", labels, dataPoints);

        const ctx1 = document.getElementById('stockChart1').getContext('2d');

        new Chart(ctx1, {
            type: 'line',
            data: {
                labels: labels,
                datasets: [{
                    label: '코스피 지수',
                    data: dataPoints,
                    borderColor: '#326CF9',
                    tension: 0.4,
                    borderWidth: 2,
                    pointRadius: 3,
                    fill: false
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false },
                    title: { display: true, text: '코스피 지수 (최근 7일)' }
                },
                scales: {
                    x: { grid: { display: false }, title: { display: true, text: '날짜' }},
                    y: { grid: { color: '#E5E8EB' }, title: { display: true, text: '지수' }}
                }
            }
        });
    }

    // 📊 코스피 거래량 그래프 그리기
    function drawKospiVolumeChart(labels, volumes) {
        console.log("코스피 거래량 데이터:", labels, volumes);

        const ctx2 = document.getElementById('stockChart2').getContext('2d');

        new Chart(ctx2, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [{
                    label: '코스피 거래량',
                    data: volumes,
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
                    title: { display: true, text: '코스피 거래량 (최근 7일)' }
                },
                scales: {
                    x: { grid: { display: false }, title: { display: true, text: '날짜' }},
                    y: { grid: { color: '#E5E8EB' }, title: { display: true, text: '거래량' }}
                }
            }
        });
    }
    </script>
</body>
</html>
