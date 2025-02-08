<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            <!-- 뉴스 항목들이 여기에 추가됨 -->
         </div>
      </section>

      <section class="sentiment-news">
         <div class="news-header">
            <div class="news-icon negative">
               <i class="fas fa-arrow-down"></i>
            </div>
            <h2 class="section-title">부정 뉴스</h2>
         </div>
         <div id="negative-news">
            <!-- 뉴스 항목들이 여기에 추가됨 -->
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
    // jQuery 코드
       $(document).ready(function() {
           // jQuery 코드 사용
       });
   </script>

   <script>
        // 주식 데이터 (예시)
        const stockData = {
            '004370': {
                name: '농심',
                data: [19500, 25200, 31000, 36800, 42500, 48000, 54000 ,59900]
            },
            '005380': {
                name: '현대자동차',
                data: [37900, 75000 ,112000 , 150000, 187000, 224000, 262000, 299500]
            },
            '005930': {
                name: '삼성전자',
                data: [8770, 21000, 33900, 46000, 59000, 71600, 84000, 96800]
            },
            '034220': {
                name: 'LG디스플레이',
                data: [8770, 12000 ,16300 ,20000 ,24000 ,28000 ,32000, 36600]
            },
            '051900': {
                name: 'LG생활건강',
                data: [194500, 420000, 648000, 875000, 1100000, 1300000, 1550000, 1784000]
            },
            '051910': {
                name: 'LG화학',
                data: [118000,250000 , 380000, 517000,650000,780000,916000 ,1050000]
            },
            '073240': {
                name: '금호타이어',
                data: [2585,4300 ,6000 ,7800 ,9500 ,11000 ,13000 , 14800]
            },
            '267260': {
                name: 'HD현대일렉트릭',
                data: [4840,68000 ,130000 ,195000 ,259000,320000 ,386000, 450000]
            }
        };

        let chart;
        const ctx = document.getElementById('stockChart').getContext('2d');

        function createChart(stockCode) {
            const stockInfo = stockData[stockCode];
            console.log(stockCode);
            console.log(stockData[stockCode]);
            console.log(stockInfo);
            console.log(stockInfo.data);
            
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
   <script>
        var page = 0;
        var limit = 3;
        var allPositiveNews = [];
        var allNegativeNews = []; // 추가
        var timer;

        function loadNews() {
            // 긍정 뉴스 로드
            $.ajax({
                url: '${pageContext.request.contextPath}/newsController',
                method: 'GET',
                dataType: 'json',
                data: {
                    action: 'getPositiveNews'
                },
                success: function(data) {
                    console.log("받은 긍정 데이터:", data);
                    allPositiveNews = data;
                    updateNewsDisplay();
                },
                error: function(xhr, status, error) {
                    console.error("긍정 뉴스 데이터를 불러오는 데 실패했습니다: " + error);
                }
            });

            // 부정 뉴스 로드
            $.ajax({
                url: '${pageContext.request.contextPath}/newsController',
                method: 'GET',
                dataType: 'json',
                data: {
                    action: 'getNegativeNews'
                },
                success: function(data) {
                    console.log("받은 부정 데이터:", data);
                    allNegativeNews = data;
                    updateNegativeNewsDisplay();
                },
                error: function(xhr, status, error) {
                    console.error("부정 뉴스 데이터를 불러오는 데 실패했습니다: " + error);
                }
            });
        }

        function decodeHTMLEntities(text) {
            var textArea = document.createElement('textarea');
            textArea.innerHTML = text;
            return textArea.value;
        }

function updateNewsDisplay() {
    var newsContainer = $('#positive-news');
    newsContainer.empty();

    var start = (page * limit) % allPositiveNews.length;
    var end = Math.min(start + limit, allPositiveNews.length);
    
    var newsToShow = allPositiveNews.slice(start, end);
    if (newsToShow.length < limit) {
        newsToShow = newsToShow.concat(allPositiveNews.slice(0, limit - newsToShow.length));
    }

    newsToShow.forEach(function(news) {
        var title = decodeHTMLEntities(news.TITLE);

        var newsItem = $('<div class="news-item" style="cursor: pointer;"></div>')
            .append($('<div class="news-title"></div>').text(title))
            .append($('<div class="news-meta"></div>').text(new Date(news.PUB_DATE).toLocaleString()))
            .click(function() {
                window.open(news.NEWS_API, '_blank');
            });
        
        newsContainer.append(newsItem);
    });
}

function updateNegativeNewsDisplay() {
    var newsContainer = $('#negative-news');
    newsContainer.empty();

    var start = (page * limit) % allNegativeNews.length;
    var end = Math.min(start + limit, allNegativeNews.length);
    
    var newsToShow = allNegativeNews.slice(start, end);
    if (newsToShow.length < limit) {
        newsToShow = newsToShow.concat(allNegativeNews.slice(0, limit - newsToShow.length));
    }

    newsToShow.forEach(function(news) {
        var title = decodeHTMLEntities(news.TITLE);

        var newsItem = $('<div class="news-item" style="cursor: pointer;"></div>')
            .append($('<div class="news-title"></div>').text(title))
            .append($('<div class="news-meta"></div>').text(new Date(news.PUB_DATE).toLocaleString()))
            .click(function() {
                window.open(news.NEWS_API, '_blank');
            });
        
        newsContainer.append(newsItem);
    });
}
$(document).ready(function(){
    loadNews();
    // 3초마다 양쪽 뉴스 모두 업데이트
    timer = setInterval(function() {
        page++;
        updateNewsDisplay();
        updateNegativeNewsDisplay();
    }, 3000);
    
    $(window).on('unload', function() {
        if (timer) {
            clearInterval(timer);
        }
    });
});
</script>


</body>
</html>