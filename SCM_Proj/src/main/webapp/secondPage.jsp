<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.scm.model.StockDAO, com.scm.db.MyBatisConnectionFactory" %>
<%@ page import="java.util.List, java.util.Map, com.google.gson.Gson" %>

<%
    // ✅ MyBatis DAO 객체 생성
    StockDAO stockDAO = new StockDAO(MyBatisConnectionFactory.getSqlSessionFactory());

    // ✅ 주식 데이터를 가져올 회사 코드 리스트
    String[] companyCodes = {"004370", "005380", "005930", "034220", "051900", "051910", "073240", "267260"};

    // ✅ 주식 데이터 저장을 위한 JSON 변환
    Gson gson = new Gson();
    String stockDataJson = gson.toJson(stockDAO.getStockClosePrices(companyCodes));
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SPAndTech</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        let stockData = <%= stockDataJson %>;

        function createStockChart(stockCode) {
            let stockInfo = stockData[stockCode];

            if (!stockInfo) {
                console.error("해당 종목의 데이터가 없습니다.");
                return;
            }

            let ctx = document.getElementById('stockChart').getContext('2d');
            if (window.stockChart) {
                window.stockChart.destroy();
            }

            window.stockChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: stockInfo.map(item => item.DATE),
                    datasets: [{
                        label: stockInfo[0].COMPANY_NAME + ' 주가',
                        data: stockInfo.map(item => item.CLOSE),
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
                        title: {
                            display: true,
                            text: stockInfo[0].COMPANY_NAME + ' 주가 (원)'
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: false,
                            ticks: {
                                callback: function(value) {
                                    return value.toLocaleString() + '원';
                                }
                            }
                        },
                        x: { grid: { display: false } }
                    }
                }
            });

            document.querySelector('.stock-price').textContent = 
                stockInfo[0].CLOSE.toLocaleString() + '원';
        }

        document.addEventListener('DOMContentLoaded', () => {
            createStockChart('005930');
        });

        document.getElementById('stockSelector').addEventListener('change', function(e) {
            createStockChart(e.target.value);
        });
    </script>
</head>
<body>
    <main>
        <section class="chart-section">
            <div class="stock-info">
                <select id="stockSelector" class="stock-selector">
                    <option value="004370">농심 (004370)</option>
                    <option value="005380">현대차 (005380)</option>
                    <option value="005930">삼성전자 (005930)</option>
                    <option value="034220">LG디스플레이 (034220)</option>
                    <option value="051900">LG생활건강 (051900)</option>
                    <option value="051910">LG화학 (051910)</option>
                    <option value="073240">금호타이어 (073240)</option>
                    <option value="267260">HD현대 (267260)</option>
                </select>
                <div class="stock-price"></div>
            </div>
            <div class="chart-wrapper">
                <canvas id="stockChart"></canvas>
            </div>
        </section>
    </main>
</body>
</html>
