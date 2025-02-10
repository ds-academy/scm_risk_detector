<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.scm.model.CustomerDTO" %>

<%
    // 로그인 상태 확인
    CustomerDTO user = (CustomerDTO) session.getAttribute("user");
    boolean isLoggedIn = (user != null);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MQAndTech</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<link rel="stylesheet" href="../css/SecondPage.css">
<style type="text/css">
.risk-score {
    font-size: 20px;
    font-weight: 600;
    background-color: rgba(255, 59, 48, 0.08);  /* 빨간색 배경 */
    color: #FF3B30;  /* 빨간색 글씨 */
    padding: 8px 16px;
    border-radius: 8px;
    margin-left: 16px;
    transition: all 0.2s ease;
}
</style>
</head>
<body>
   <nav class="navbar">
      <div class="logo">
         <i class="fas fa-leaf"></i> MQAndTech
      </div>
      <div class="nav-links">
         <a href="MainPage.jsp">홈</a>
		 <a href="Mypage.jsp">마이페이지</a>
		 <a href="secondPage.jsp">리스크</a>
      </div>
      <div class="search-bar">
         <input type="text" placeholder="종목명, 종목코드 검색">
      </div>
     <!-- 로그인/로그아웃 버튼 표시 -->
        <button class="btn-login">
            <%= isLoggedIn ? "로그아웃" : "로그인" %>
        </button>
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
               <option value="051900">LG생활과학(051900)</option>
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
               <option value="051900">LG생활과학(051900)</option>
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

    /** 패스트파일의 코드 가져오기 **/
    function createStockChart(companyCode) {
        $.ajax({
            url: '/com.SCM_Pro.proj/stocks',
            method: 'GET',
            data: { companyCode },
            dataType: 'json',
            success: function(data) {
                if (!data || data.length === 0) {
                    console.warn("🚨 주가 데이터 없음");
                    const stockPriceElement = document.querySelector('.chart-section .stock-price');
                    if (stockPriceElement) {
                        stockPriceElement.textContent = '주가 데이터 없음';
                    }
                    return;
                }

                const ctx = document.getElementById('stockChart').getContext('2d');
                const stockPricesLimited = data.slice(-8).map(item => parseFloat(item.CLOSE));
                const labels = data.slice(-8).map(item => new Date(item.DATE));
                const averagePrice = Math.round(stockPricesLimited.reduce((sum, price) => sum + price, 0) / stockPricesLimited.length);

                if (stockChart) stockChart.destroy();

                stockChart = new Chart(ctx, {
                    type: 'line',
                    data: {
                        labels: labels,
                        datasets: [{ label: '주가', data: stockPricesLimited, borderColor: '#326CF9', fill: true }]
                    },
                    options: { responsive: true, maintainAspectRatio: false }
                });

                const stockPriceElement = document.querySelector('.chart-section .stock-price');
                if (stockPriceElement) {
                    stockPriceElement.textContent = `평균 주가: ${averagePrice.toLocaleString()}원`;
                }
            },
            error: function(xhr, status, error) {
                console.error("❌ 주가 데이터 요청 실패:", error);
            }
        });
    }
    
    /** 리스크 체크 처리 **/
    function createRiskChart(companyCode) {
        $.ajax({
            url: '/com.SCM_Pro.proj/risk',
            data: { companyCode },
            dataType: 'json',
            success: function(data) {
                if (!data || data.length === 0) {
                    console.warn("\ud83d\udea8 \ub9ac스크 데이터 없음");
                    const riskScoreElement = document.querySelector('.risk-section .risk-score');
                    if (riskScoreElement) {
                        riskScoreElement.textContent = '\ub9ac스크 데이터 없음';
                    }
                    return;
                }

                const ctx = document.getElementById('riskChart').getContext('2d');
                const riskScoresLimited = data.slice(-6).map(item => parseFloat(item.RISK_SCORE));
                const labels = data.slice(-6).map(item => new Date(item.PREDICT_DATE));
                const averageRisk = (riskScoresLimited.reduce((sum, score) => sum + score, 0) / riskScoresLimited.length).toFixed(2);

                if (riskChart) riskChart.destroy();

                riskChart = new Chart(ctx, {
                    type: 'line',
                    data: {
                        labels: labels,
                        datasets: [{ label: '\ub9ac스크 점수', data: riskScoresLimited, borderColor: '#FF3B30', fill: true }]
                    },
                    options: { responsive: true, maintainAspectRatio: false }
                });

                const riskScoreElement = document.querySelector('.risk-section .risk-score');
                if (riskScoreElement) {
                    riskScoreElement.textContent = `평균 위험도: ${averageRisk}%`;
                }
            },
            error: function(xhr, status, error) {
                console.error("❌ 리스크 데이터 요청 실패:", error);
            }
        });
    }
    </script>

   <script>
        var page = 0;
        var limit = 3;
        var allPositiveNews = [];
        var allNegativeNews = [];
        var timer;

        function loadNews() {
            $.ajax({
                url: '${pageContext.request.contextPath}/newsController',
                method: 'GET',
                dataType: 'json',
                data: {
                    action: 'getPositiveNews'
                },
                success: function(data) {
                    allPositiveNews = data;
                    updateNewsDisplay();
                },
                error: function(xhr, status, error) {
                    console.error("긍정 뉴스 데이터를 불러오는 데 실패했습니다: " + error);
                }
            });

            $.ajax({
                url: '${pageContext.request.contextPath}/newsController',
                method: 'GET',
                dataType: 'json',
                data: {
                    action: 'getNegativeNews'
                },
                success: function(data) {
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