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
        let spData = companyCode.split("/");
        console.log("회사 코드:", spData[0], "회사 이름:", spData[1]);

        $.ajax({
            url: '/com.SCM_Pro.proj/risk',
            method: 'GET',
            data: { companyCode: spData[0] },
            dataType: 'json',
            success: function(data) {
                console.log("받아온 데이터:", data);

                if (!data || data.length === 0) {
                    console.warn("리스크 데이터가 없습니다.");
                    document.querySelector('.risk-section .stock-price').textContent = '위험도 데이터 없음';
                    return;
                }

                // null 값 필터링 및 리스크 점수 배열 생성
                const riskScores = data
                    .filter(item => item && item.RISK_SCORE != null)
                    .map(item => parseFloat(item.RISK_SCORE));  // BigDecimal 값을 float로 변환
                
                const predictDates = data
                    .filter(item => item && item.PREDICT_DATE)
                    .map(item => new Date(item.PREDICT_DATE));  // 날짜 객체로 변환

                if (riskScores.length === 0 || predictDates.length === 0) {
                    console.error("유효한 리스크 데이터가 부족합니다.");
                    document.querySelector('.risk-section .stock-price').textContent = '유효한 위험도 데이터 없음';
                    return;
                }

                // 평균 리스크 점수 계산
                const averageRisk = (riskScores.reduce((sum, score) => sum + score, 0) / riskScores.length).toFixed(2);
                console.log("평균 리스크 점수:", averageRisk);

                const ctx = document.getElementById('riskChart').getContext('2d');

                // 이전 차트가 존재하면 파괴
                if (chart) {
                    chart.destroy();
                }

                // 차트 생성
                chart = new Chart(ctx, {
                    type: 'line',
                    data: {
                        labels: predictDates,
                        datasets: [{
                            label: '리스크 점수',
                            data: riskScores,
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
                                text: `${spData[1]} 평균 리스크 점수: ${averageRisk}%`
                            }
                        },
                        scales: {
                            x: {
                                type: 'time',  // 시간 축으로 설정
                                time: {
                                    unit: 'day',
                                    displayFormats: {
                                        day: 'yyyy-MM-dd'
                                    }
                                },
                                grid: { display: false }
                            },
                            y: {
                                beginAtZero: false,
                                ticks: {
                                    callback: function(value) {
                                        return value.toFixed(2) + '%';  // Y축 값에 % 추가
                                    }             
                                }
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