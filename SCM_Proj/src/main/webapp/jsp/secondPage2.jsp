<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
            <div id="positive-news">
                <!-- AJAX로 받아온 뉴스 데이터가 추가됩니다. -->
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
                    <option value="004370/농심">농심 (004370)</option>
                    <option value="005380/현대자동차">현대자동차 (005380)</option>
                    <option value="005930/삼성전자">삼성전자 (005930)</option>
                    <option value="034220/LG디스플레이">LG디스플레이 (034220)</option>
                    <option value="051900/LG생활건강">LG생활건강 (051900)</option>
                    <option value="051910/LG화학">LG화학 (051910)</option>
                    <option value="073240/금호타이어">금호타이어 (073240)</option>
                    <option value="267260/HD현대일렉트릭">HD현대일렉트릭 (267260)</option>
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
                    <option value="051900">LG생활건강 (051900)</option>
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

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script>
    
    let chart = "";
    
        $(document).ready(function() {
            createChart('005930/삼성전자');  // 삼성전자 기본값
            createRiskChart('005930');

            $('#stockSelector').change(function() {
                const selectedCompany = $(this).val();
                createChart(selectedCompany);
            });

            $('#riskSelector').change(function() {
                const selectedCompany = $(this).val();
                createRiskChart(selectedCompany);
            });
        });

        function createChart(companyCode) {
        	
        	let spData = companyCode.split("/");
        	console.log(spData);
        	
            $.ajax({
                url: '/com.SCM_Pro.proj/stocks',  // Ensure this matches the @WebServlet("/stocks")
                method: 'GET',
                data: { companyCode: spData[0] },
                dataType: 'json',
                success: function(data) {
                	
                	console.log(data);
                	
                	// 가져온 데이터로 차트 그리기 부분
                	
                	 const stockData = {
			            companyCode: {
			                name: spData[1],
			                data: [data[0].CLOSE, data[1].CLOSE, data[2].CLOSE, data[3].CLOSE, data[4].CLOSE, data[5].CLOSE, data[6].CLOSE ,data[7].CLOSE]
			            }
                	}
                	
                	console.log(stockData);
                	let info = stockData;
                	 
                     const ctx = document.getElementById('stockChart').getContext('2d');

                     const stockInfo = stockData[spData[0]];
                     
                     
                     
                     
                  // 평균 구하기
                     average = (data[0].CLOSE+data[1].CLOSE+data[2].CLOSE+data[3].CLOSE+ data[4].CLOSE+ data[5].CLOSE+ data[6].CLOSE+data[7].CLOSE) / 8;
                     average = parseInt(average);
                     console.log(info.companyCode.data);
                     
                     /* chart.destroy(); */
                   
                     console.log(chart);
                     
                     
                     
                     console.log(chart);
                     if (chart) {
                         chart.destroy();
                     }
                     
					console.log(data[0].DATE);
                     chart = new Chart(ctx, {
                         type: 'line',
                         data: {
                             labels: [data[0].DATE, data[1].DATE, data[2].DATE, data[3].DATE, data[4].DATE, data[5].DATE, data[6].DATE, data[7].DATE],
                             datasets: [{
                                 label: '주가',
                                 data: stockData.companyCode.data,
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
                                     /* text: `${stockInfo.name} 주가 (원)` */
                                     text: average+' 주가 (원)'
                                 }
                             },
                             scales: {
                                 y: {
                                     beginAtZero: false,
                                     ticks: {
                                         callback: function(value) {
                                             return value.toLocaleString()+ '원';
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
                    	 average + '원';
                 
                },
                error: function(xhr, status, error) {
                    console.error('주가 데이터를 불러오는데 실패했습니다:', error);
                }
            });
        }

        function createRiskChart(companyCode) {
            console.log("선택된 회사 코드:", companyCode);

            $.ajax({
                url: '/risk',  // 리스크 데이터를 가져오는 엔드포인트
                method: 'GET',
                data: { companyCode: companyCode },  // 회사 코드 전송
                dataType: 'json',
                success: function(data) {
                    if (!data || data.length === 0) {
                        console.warn("리스크 데이터가 없습니다.");
                        return;
                    }

                    const riskScores = data.map(item => parseFloat(item.riskScore || 0));  // Null 값 처리
                    const predictDates = data.map(item => item.predictDate);

                    const averageRisk = (riskScores.reduce((sum, score) => sum + score, 0) / riskScores.length).toFixed(2);
                    console.log("평균 리스크 점수:", averageRisk);

                    const ctx = document.getElementById('riskChart').getContext('2d');
                    if (window.riskChart) {
                        window.riskChart.destroy();
                    }

                    window.riskChart = new Chart(ctx, {
                        type: 'line',
                        data: {
                            labels: predictDates,
                            datasets: [{
                                label: '리스크 점수',
                                data: riskScores,
                                borderColor: '#FF3B3B',
                                backgroundColor: 'rgba(255, 59, 59, 0.1)',
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
                                    text: `평균 리스크 점수: ${averageRisk}`
                                }
                            },
                            scales: {
                                y: {
                                    beginAtZero: false,
                                    ticks: {
                                        callback: function(value) {
                                            return value.toFixed(2);
                                        }
                                    }
                                },
                                x: {
                                    grid: { display: false }
                                }
                            }
                        }
                    });

                    // 위험도 표시 업데이트
                    document.querySelector('.risk-section .stock-price').textContent = `위험도: ${averageRisk}%`;
                },
                error: function(xhr, status, error) {
                    console.error("리스크 데이터 요청 실패:", error);
                }
            });
        }

    </script>
</body>
</html>