<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="com.scm.model.NewsDAO" %>
<%@ page import="com.scm.model.StockDAO" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SPAndTech</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chartjs-adapter-date-fns"></script>
    <link rel="stylesheet" href="../css/SecondPage.css">
</head>
<body>
    <nav class="navbar">
        <div class="logo">
            <i class="fas fa-leaf"></i> SPAndTech
        </div>
        <div class="nav-links">
            <a href="#">홈</a>
            <a href="#">마이페이지</a>
            <a href="#">설정</a>
            <a href="#">리스크</a>
        </div>
        <div class="search-bar">
            <input type="text" placeholder="종목명, 종목코드 검색">
        </div>
        <button class="btn-login">로그인</button>
    </nav>

    <main class="main-content">
        <section class="chart-section">
            <div class="stock-info">
                <select id="stockSelector" class="stock-selector">
                	<option value="004370">농심 (004370)</option>
                    <option value="005930">삼성전자 (005930)</option>
                    <option value="005380">현대자동차 (005380)</option>
                    <option value="034220">LG디스플레이 (034220)</option>
                    <option value="051900">LG생활건강(051900)</option>
                    <option value="051910">LG화학 (051910)</option>
                    <option value="073240">금호타이어 (073240)</option>
                    <option value="267260">HD현대일렉트릭 (267260)</option>
                </select>
                <div class="stock-price">주가: 72,300원</div>
            </div>
            <div class="chart-wrapper">
                <canvas id="stockChart"></canvas>
            </div>
        </section>

        <section class="risk-section">
            <div class="stock-info">
                <select id="riskSelector" class="stock-selector">
                	<option value="004370">농심 (004370)</option>
                    <option value="005930">삼성전자 (005930)</option>
                    <option value="005380">현대자동차 (005380)</option>
                    <option value="034220">LG디스플레이 (034220)</option>
                    <option value="051900">LG생활건강(051900)</option>
                    <option value="051910">LG화학 (051910)</option>
                    <option value="073240">금호타이어 (073240)</option>
                    <option value="267260">HD현대일렉트릭 (267260)</option>
                </select>
                <div class="risk-score">위험도: 65%</div>
            </div>
            <div class="chart-wrapper">
                <canvas id="riskChart"></canvas>
            </div>
        </section>
    </main>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script>
    let stockChart = null;
    let riskChart = null;

    $(document).ready(function() {
        createStockChart('005930');
        createRiskChart('005930');

        $('#stockSelector').change(function() {
            createStockChart($(this).val());
        });

        $('#riskSelector').change(function() {
            createRiskChart($(this).val());
        });
    });

    /** 📌 주가 차트 생성 (최근 8개만 사용) **/
    function createStockChart(companyCode) {
        $.ajax({
            url: '/com.SCM_Pro.proj/stocks',
            method: 'GET',
            data: { companyCode },
            dataType: 'json',
            success: function(data) {
                if (!data || data.length === 0) {
                    console.warn("🚨 주가 데이터 없음");
                    document.querySelector('.stock-price').textContent = '주가 데이터 없음';
                    return;
                }

                const ctx = document.getElementById('stockChart').getContext('2d');

                // 최근 8개 데이터만 가져오기
                const stockPricesLimited = data.slice(-8).map(item => parseFloat(item.CLOSE));
                const labels = data.slice(-8).map(item => new Date(item.DATE));

                // 평균 주가 계산
                const averagePrice = Math.round(stockPricesLimited.reduce((sum, price) => sum + price, 0) / stockPricesLimited.length);

                // 기존 차트 삭제
                if (stockChart) {
                    stockChart.destroy();
                }

                stockChart = new Chart(ctx, {
                    type: 'line',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: '주가',
                            data: stockPricesLimited,
                            borderColor: '#326CF9',
                            backgroundColor: 'rgba(50, 108, 249, 0.1)',
                            tension: 0.4,
                            fill: true
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: { display: false },
                            title: { display: true, text: `평균 주가: ${averagePrice.toLocaleString()}원` }
                        },
                        scales: {
                            x: {
                                type: 'time',
                                time: { unit: 'day', tooltipFormat: 'yyyy-MM-dd' },
                                grid: { display: false }
                            },
                            y: {
                                beginAtZero: false,
                                ticks: { callback: value => value.toLocaleString() + '원' }
                            }
                        }
                    }
                });

                document.querySelector('.stock-price').textContent = `평균 주가: ${averagePrice.toLocaleString()}원`;
            },
            error: function(xhr, status, error) {
                console.error("❌ 주가 데이터 요청 실패:", error);
            }
        });
    }

    /** 📌 리스크 차트 생성 (최근 6개만 사용) **/
    function createRiskChart(companyCode) {
        $.ajax({
            url: '/com.SCM_Pro.proj/risk',
            method: 'GET',
            data: { companyCode },
            dataType: 'json',
            success: function(data) {
                if (!data || data.length === 0) {
                    console.warn("🚨 리스크 데이터 없음");
                    document.querySelector('.risk-score').textContent = '리스크 데이터 없음';
                    return;
                }

                const ctx = document.getElementById('riskChart').getContext('2d');

                // 최근 6개 데이터만 가져오기
                const riskScoresLimited = data.slice(-6).map(item => parseFloat(item.RISK_SCORE));
                const labels = data.slice(-6).map(item => new Date(item.PREDICT_DATE));

                // 평균 위험도 계산
                const averageRisk = (riskScoresLimited.reduce((sum, score) => sum + score, 0) / riskScoresLimited.length).toFixed(2);

                // 기존 차트 삭제
                if (riskChart) {
                    riskChart.destroy();
                }

                riskChart = new Chart(ctx, {
                    type: 'line',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: '리스크 점수',
                            data: riskScoresLimited,
                            borderColor: '#FF3B30',
                            backgroundColor: 'rgba(255, 59, 48, 0.1)',
                            tension: 0.4,
                            fill: true
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: { display: false },
                            title: { display: true, text: `평균 위험도: ${averageRisk}%` }
                        },
                        scales: {
                            x: {
                                type: 'time',
                                time: { unit: 'day', tooltipFormat: 'yyyy-MM-dd' },
                                grid: { display: false }
                            },
                            y: {
                                beginAtZero: false,
                                ticks: { callback: value => value.toFixed(2) + '%' }
                            }
                        }
                    }
                });

                document.querySelector('.risk-score').textContent = `평균 위험도: ${averageRisk}%`;
            },
            error: function(xhr, status, error) {
                console.error("❌ 리스크 데이터 요청 실패:", error);
            }
        });
    }
 
    </script>
</body>
</html>
