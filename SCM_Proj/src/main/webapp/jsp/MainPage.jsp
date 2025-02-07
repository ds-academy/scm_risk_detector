<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SPAndTech</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link rel="stylesheet" href="../css/Mainpage2.css">
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
            <a href="#">리스크 </a>
        </div>
        <div class="search-bar">
            <input type="text" placeholder="종목명, 종목코드 검색">
        </div>
        <button class="btn-login" onclick="location.href='<%=request.getContextPath()%>/jsp/Login.jsp'">로그인</button>
    </nav>

    <main class="main-content">
        <section class="market-summary">
            <h2 class="section-title">실시간 시장 동향</h2>
            <div class="stock-grid">
                <div class="stock-card">
                    <div class="stock-name">코스피</div>
                    <div class="stock-price">2,658.35</div>
                </div>
                <div class="stock-card">
                    <div class="stock-name">코스닥</div>
                    <div class="stock-price">865.62</div>
                </div>
                <div class="stock-card">
                    <div class="stock-name">S&P 500</div>
                    <div class="stock-price">4,890.97</div>
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

        <section class="news-feed">
            <h2 class="section-title">실시간 뉴스</h2>
            <div class="news-item">
                <div class="news-title">글로벌 증시 상승세, 미 연준 금리 동결 전망에 투자심리 개선</div>
                <div class="news-meta">5분 전 • 경제신문</div>
            </div>
            <div class="news-item">
                <div class="news-title">AI 기업들 실적 발표 앞두고 기술주 강세</div>
                <div class="news-meta">15분 전 • 테크뉴스</div>
            </div>
            <div class="news-item">
                <div class="news-title">국내 주요기업 실적 전망치 상향 조정</div>
                <div class="news-meta">30분 전 • 투자저널</div>
            </div>
        </section>

        <section class="maps-section">
            <h2 class="section-title">글로벌 마켓 현황</h2>
            <div class="company-selector">
                <select id="companySelect" onchange="updateCompanyInfo()">
                    <option value="">기업을 선택하세요</option>
                    <option value="samsung">삼성전자</option>
                    <option value="lg">LG전자</option>
                    <option value="sk">SK하이닉스</option>
                    <option value="hyundai">현대자동차</option>
                    <option value="naver">네이버</option>
                </select>
            </div>
            <div id="map"></div>
        </section>
    </main>

    <script>
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

        function fetchSuppliesAndDisplay(map) {
            fetch('<%=request.getContextPath()%>/supplies')
                .then(response => response.json())
                .then(data => {
                    data.forEach(supply => {
                        const marker = new google.maps.Marker({
                            position: { lat: parseFloat(supply.LAT), lng: parseFloat(supply.LON) },
                            map: map,
                            title: supply.PRODUCT
                        });

                        const infoWindow = new google.maps.InfoWindow({
                            content: `
                                <h3>${supply.PRODUCT}</h3>
                                <p>위치: ${supply.LOC_NAME}</p>
                                <p>주소: ${supply.ADDRESS}</p>
                                <p>비율: ${supply.RATIO}%</p>
                            `
                        });

                        marker.addListener('click', () => {
                            infoWindow.open(map, marker);
                        });
                    });
                })
                .catch(error => console.error('Error fetching supplies:', error));
        }

        function initMap() {
            const mapOptions = {
                center: { lat: 37.5665, lng: 126.9780 },
                zoom: 5
            };
            const map = new google.maps.Map(document.getElementById('map'), mapOptions);

            fetchSuppliesAndDisplay(map);
        }
    </script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBfIo_r6F31jWYr0FF1W_iLkgwYlDPPxzw&callback=initMap" async defer></script>
</body>
</html>
