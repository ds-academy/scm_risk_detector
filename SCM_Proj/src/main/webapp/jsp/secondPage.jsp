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
        <section class="sentiment-news">
            <div class="news-header">
                <div class="news-icon positive">
                    <i class="fas fa-arrow-up"></i>
                </div>
                <h2 class="section-title">긍정 뉴스</h2>
            </div>
            
            <table>
            <thead>
                <tr>
                    <th>뉴스 제목</th>
                    <th>뉴스 메타</th>
                </tr>
            </thead>
            <tbody>
                <!-- DAO에서 전달받은 newsList를 반복 -->
                <c:forEach var="news" items="${newsList}">
                    <tr>
                        <td>${news.title}</td>
                        <td>${news.meta}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
            
            
            <div class="news-item">
                <div class="news-title">반도체 수출 증가세 지속, 전년 대비 15% 상승</div>
                <div class="news-meta">5분 전 • 경제신문</div>
            </div>
            <div class="news-item">
                <div class="news-title">주요 기업 실적 전망치 상향 조정</div>
                <div class="news-meta">15분 전 • 테크뉴스</div>
            </div>
            <div class="news-item">
                <div class="news-title">글로벌 투자자금 국내 주식시장 유입 확대</div>
                <div class="news-meta">30분 전 • 투자저널</div>
            </div>
        </section>

        <section class="sentiment-news">
            <div class="news-header">
                <div class="news-icon negative">
                    <i class="fas fa-arrow-down"></i>
                </div>
                <h2 class="section-title">부정 뉴스</h2>
            </div>
            <div class="news-item">
                <div class="news-title">원자재 가격 상승으로 기업 부담 가중</div>
                <div class="news-meta">10분 전 • 경제신문</div>
            </div>
            <div class="news-item">
                <div class="news-title">미 연준 금리 인상 우려 확대</div>
                <div class="news-meta">20분 전 • 글로벌뉴스</div>
            </div>
            <div class="news-item">
                <div class="news-title">중국 경기 둔화 조짐에 수출기업 우려</div>
                <div class="news-meta">35분 전 • 투자저널</div>
            </div>
        </section>

        <section class="chart-section">
            <div class="stock-info">
                <select id="stockSelector" class="stock-selector">
                    <option value="004370">농심 (004370)</option>
                    <option value="005380">현대자동차 (005380)</option>
                    <option value="005930">삼성전자 (005930)</option>
                    <option value="034220">LG디스플레이 (034220)</option>
                    <option value="051900">LG생활건강(051900)</option>
                    <option value="051910">LG화학 (051910)</option>
                    <option value="073240">금호타이어 (073240)</option>
                    <option value="267260">HD현대일렉트릭 (267260)</option>
                </select>
                <div class="stock-price">72,300원</div>
            </div>
            <div class="chart-wrapper">
                <canvas id="stockChart"></canvas>
            </div>
        </section>
        <section class="risk-section">
            <div class="stock-info">
                <select id="riskSelector" class="stock-selector">
                    <option value="004370">농심 (004370)</option>
                    <option value="005380">현대자동차 (005380)</option>
                    <option value="005930">삼성전자 (005930)</option>
                    <option value="034220">LG디스플레이 (034220)</option>
                    <option value="051900">LG생활건강(051900)</option>
                    <option value="051910">LG화학 (051910)</option>
                    <option value="073240">금호타이어 (073240)</option>
                    <option value="267260">HD현대일렉트릭 (267260)</option>
                </select>
                <div class="stock-price">위험도: 65%</div>
            </div>
            <div class="chart-wrapper">
                <canvas id="riskChart"></canvas>
            </div>
        </section>
        
    </main>

    <script>
        // 주식 데이터 (예시)
        const stockData = {
            '004370': {
                name: '농심',
                data: [71000, 71200, 71800, 71500, 72100, 72400, 72300, 72300]
            },
            '005380': {
                name: '현대자동차',
                data: [125000, 126000, 125800, 126500, 127000, 126800, 127200, 127500]
            },
            '005930': {
                name: '삼성전자',
                data: [45000, 45200, 45500, 45300, 45800, 46000, 45900, 46200]
            },
            '034220': {
                name: 'LG디스플레이',
                data: [185000, 186000, 186500, 187000, 186800, 187500, 188000, 188200]
            },
            '051900': {
                name: 'LG생활건강',
                data: [550000, 552000, 553000, 551000, 554000, 555000, 556000, 557000]
            },
            '051910': {
                name: 'LG화학',
                data: [175000, 176000, 176500, 177000, 176800, 177500, 178000, 178200]
            },
            '0073240': {
                name: '금호타이어',
                data: [820000, 822000, 823000, 821000, 824000, 825000, 826000, 827000]
            },
            '267260': {
                name: 'HD현대일렉트릭',
                data: [450000, 452000, 453000, 451000, 454000, 455000, 456000, 457000]
            }
        };

        let chart;
        const ctx = document.getElementById('stockChart').getContext('2d');

        function createChart(stockCode) {
            const stockInfo = stockData[stockCode];
            if (chart) {
                chart.destroy();
            }

            chart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: ['9:00', '10:00', '11:00', '12:00', '13:00', '14:00', '15:00', '15:30'],
                    datasets: [{
                        label: '주가',
                        data: stockInfo.data,
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
                        legend: {
                            display: false
                        },
                        title: {
                            display: true,
                            text: `${stockInfo.name} 주가 (원)`
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
                        x: {
                            grid: {
                                display: false
                            }
                        }
                    }
                }
            });

            // 주가 업데이트
            document.querySelector('.stock-price').textContent = 
                stockInfo.data[stockInfo.data.length - 1].toLocaleString() + '원';
        }

        // 초기 차트 생성
        createChart('005930');

        // SELECT 변경 이벤트 처리
        document.getElementById('stockSelector').addEventListener('change', function(e) {
            createChart(e.target.value);
        });
    </script>
    <script>
        // 공급망 위험 데이터 (예시 - 6개월치 데이터)
        const riskData = {
            '004370': {
                name: '농심',
                data: [65, 63, 68, 64, 62, 65],
                riskLevel: '65%'
            },
            '005380': {
                name: '현대자동차',
                data: [70, 72, 75, 73, 71, 74],
                riskLevel: '74%'
            },
            '005930': {
                name: '삼성전자',
                data: [45, 43, 44, 46, 45, 47],
                riskLevel: '47%'
            },
            '034220': {
                name: 'LG디스플레이',
                data: [48, 46, 45, 47, 49, 48],
                riskLevel: '48%'
            },
            '051900': {
                name: 'LG생활건강',
                data: [78, 76, 75, 77, 79, 80],
                riskLevel: '80%'
            },
            '051910': {
                name: 'LG화학',
                data: [72, 70, 73, 75, 74, 73],
                riskLevel: '73%'
            },
            '073240': {
                name: '금호타이어',
                data: [55, 53, 54, 56, 55, 57],
                riskLevel: '57%'
            },
            '267260': {
                name: 'HD현대일렉트릭',
                data: [68, 66, 65, 67, 69, 68],
                riskLevel: '68%'
            }
        };
        
        let riskChart;
        
        function createRiskChart(stockCode) {
            const riskInfo = riskData[stockCode];
            const ctxRisk = document.getElementById('riskChart').getContext('2d');
            
            if (riskChart) {
                riskChart.destroy();
            }
        
            riskChart = new Chart(ctxRisk, {
                type: 'line',
                data: {
                    labels: ['6개월 전', '5개월 전', '4개월 전', '3개월 전', '2개월 전', '1개월 전'],
                    datasets: [{
                        label: '공급망 위험도',
                        data: riskInfo.data,
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
                        legend: {
                            display: false
                        },
                        title: {
                            display: true,
                            text: `${riskInfo.name} 공급망 위험도 추이 (단위: %)`
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: false,
                            min: 0,
                            max: 100,
                            ticks: {
                                callback: function(value) {
                                    return value + '%';
                                }
                            }
                        },
                        x: {
                            grid: {
                                display: false
                            }
                        }
                    }
                }
            });
        
            // 위험도 업데이트
            document.querySelector('.stock-price').textContent = `위험도: ${riskInfo.riskLevel}`;
        }
        
        // 초기 차트 생성
        document.addEventListener('DOMContentLoaded', () => {
            createRiskChart('005930');
        });
        
        // SELECT 변경 이벤트 처리
        document.getElementById('riskSelector').addEventListener('change', function(e) {
            createRiskChart(e.target.value);
        });
        </script>
</body>
</html>