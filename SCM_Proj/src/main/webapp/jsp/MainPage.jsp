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
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link rel="stylesheet" href="../css/Mainpage2.css">
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
                    <option value="004370">농심(004370)</option>
                    <option value="005380">현대자동차(005380)</option>
                    <option value="005930">삼성전자(005930)</option>
                    <option value="034220">LG 디스플레이(034220)</option>
                    <option value="051910">LG 화학(051910)</option>
                    <option value="051900">LG 생활건강(051900)</option>
                    <option value="073240">금호타이어(073240)</option>
                    <option value="267260">HD 현대일렉트릭(267260)</option>
                </select>
            </div>
            <div id="map" style="height: 500px;"></div>
        </section>
    </main>

    <script>
    
   
    
               // 차트 초기화 - 코스피 지수
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
                    legend: {
                        display: false
                    },
                    title: {
                        display: true,
                        text: '코스피 지수'
                    }
                },
                scales: {
                    x: {
                        grid: {
                            display: false
                        }
                    },
                    y: {
                        grid: {
                            color: '#E5E8EB'
                        }
                    }
                }
            }
        });

        // 차트 초기화 - 거래량
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
                    legend: {
                        display: false
                    },
                    title: {
                        display: true,
                        text: '거래량'
                    }
                },
                scales: {
                    x: {
                        grid: {
                            display: false
                        }
                    },
                    y: {
                        grid: {
                            color: '#E5E8EB'
                        }
                    }
                }
            }
        });
        let map;
        let markers = [];
        let polylines = [];

        const companyData = {
            "004370": {
                color: "#FF6347",
                nodes: [
                    { lat: 34.08561650, lng: -117.54022610, label: "미국 지사" },
                    { lat: -33.79491650, lng: 151.14338010, label: "오스트레일리아 지사" },
                    { lat: 10.77618240, lng: 106.69126530, label: "베트남 지사" },
                    { lat: 43.62268600, lng: -79.69528560, label: "캐나다 지사" },
                    { lat: 35.67049300, lng: 139.75151230, label: "상하이 판매법인" },
                    { lat: 30.81758000, lng: 121.34626000, label: "파리 지사" },
                    { lat: 41.77237000, lng: 123.27034000, label: "무바이 생산공장" },
                    { lat: 36.28813390, lng: 120.03870350, label: "중국 지사" },
                    { lat: 35.67049300, lng: 139.75151230, label: "일본 지사" },
                    { lat: 30.81758000, lng: 121.34626000, label: "모스크바 영업부" }
                ]
            },
            "005380": {
                color: "#FF5733",
                nodes: [
                    { lat: 32.37920000, lng: 86.30770000, label: "서울 부사" },
                    { lat: 28.45950000, lng: 77.02660000, label: "인도 지사" },
                    { lat: 41.00820000, lng: 28.97840000, label: "터키 지사" },
                    { lat: 49.66110000, lng: 18.42750000, label: "체코 지사" },
                    { lat: 21.02850000, lng: 105.85420000, label: "베트남" },
                    { lat: 23.55050000, lng: 46.63330000, label: "방코치 생산공장" },
                    { lat: 6.23830000, lng: 106.97560000, label: "쿠알라룸푸르 지사3333333" },
                    
                    
                ]
            },
            "005930": {
                color: "#326CF9",
                nodes: [
                    { lat: 48.13790240, lng: 11.62366860, label: "북미 지사" },
                    { lat: 41.04979610, lng: -73.53932830, label: "뉴욕 지사" },
                    { lat: 24.69196390, lng: 46.68295040, label: "사우디 아라비아 지사" },
                    { lat: 31.23041600, lng: 121.47370100, label: "중국 지사" },
                    { lat: 52.39950940, lng: 4.87668990, label: "네덜란드 지사" },
                    { lat: 1.28324460, lng: 103.84965970, label: "말레이시아 지사" },
                    { lat: 28.45090610, lng: 77.09644320, label: "인도 지사" },
                    { lat: 35.62671670, lng: 139.74069080, label: "일본 지사" },
                    { lat: 51.37114180, lng: -0.53077730, label: "런던 지사" },
                    { lat: -26.04868000, lng: 28.02064000, label: "남아프리카 지사" }
                ]
            },
            "034220": {
                color: "#00A86B",
                nodes: [
                    { lat: 30.39020930, lng: -97.74000460, label: "서울 부사사사사사사사사사사사ㅏ" },
                    { lat: 33.13096970, lng: -117.25410870, label: "미국 지사" },
                    { lat: 29.97913970, lng: -95.56410710, label: "사랑사 연구소" },
                    { lat: 38.89552610, lng: -77.02771220, label: "프러도크 유럽관리차" },
                    { lat: 34.67678710, lng: 135.50810670, label: "일본 지사" },
                    { lat: 5.42707550, lng: 100.32147640, label: "말레이시아 지사" },
                    { lat: 36.06622990, lng: 120.38299000, label: "중국 지사" },
                    { lat: 30.39020930, lng: -97.74000460, label: "귀멸의칼날탄지로" },
                    { lat: 42.56010500, lng: -83.14565180, label: "마이에스트로바보청년" },
                    { lat: 39.90781000, lng: 116.44702000, label: "쭈꾸미먹고싶다불닭" }
                
                   
                    
                ]
            },
            "051910": {
                color: "#FFB347",
                nodes: [
                    { lat: 39.89491990, lng: 116.47400000, label: "서울 부사사사사사" },
                    { lat: 28.49428830, lng: 77.08891270, label: "인도 지사" },
                    { lat: 10.77371240, lng: 106.70328600, label: "베트남 지사" },
                    { lat: 32.11653990, lng: 118.80917000, label: "재재재재재재ㅐ재재재재재재" },
                    { lat: 33.83640030, lng: -118.35267810, label: "미국 지사" },
                    { lat: 50.08165430, lng: 8.62708710, label: "독일 지사" },
                    { lat: 35.67780150, lng: 139.77018000, label: "일본 지사" },
                    { lat: 40.89739960, lng: -73.94206920, label: "DDDDDDDDDDD" },
                    { lat: 32.14569000, lng: 118.87313000, label: "중국 지사" },
                    { lat: 42.75551770, lng: -86.06944670, label: "CCCCCCCCCC" }
                    
                ]
            },
            "051900": {
                color: "#DA70D6",
                nodes: [
                    { lat: 25.90263958, lng: -18.81856568, label: "OOOOOOOO" },
                    { lat: 35.66742110, lng: 139.76071560, label: "일본 지사" },
                    { lat: 31.23041600, lng: 121.47370100, label: "중국 지사" },
                    { lat: 33.58841900, lng: 130.39838790, label: "모스크바 판매가구" },
                    { lat: 34.11667230, lng: -118.24409690, label: "미국 지사" },
                    { lat: 30.48266779, lng: 10.52818735, label: "리비아 지사" },
                    { lat: 28.95599172, lng: 0.74593634, label: "알제리 지사" },
                    { lat: 27.42931565, lng: -9.03631467, label: "서사하라 지사" },
                    { lat: 33.58841900, lng: -77.51207174, label: "EEEEEEEE" },
                    { lat: 22.84928744, lng: -38.38306770, label: "FFFFFFFF" }
                ]
            },
            "073240": {
                color: "#FFD700",
                nodes: [
                    { lat: 13.74340900, lng: 100.54789500, label: "태국 지사" },
                    { lat: 48.83100700, lng: 2.26199300, label: "프랑스 지사" },
                    { lat: 48.18845950, lng: 16.40292630, label: "오스트리아 지사" },
                    { lat: 43.64338050, lng: -79.68125690, label: "캐나다 지사" },
                    { lat: 35.69649950, lng: 139.76808620, label: "일본 지사" },
                    { lat: 55.74812930, lng: 37.54389340, label: "러시아 지사" },
                    { lat: 33.75726480, lng: -84.38697020, label: "미국 지사" },
                    { lat: 19.42672110, lng: -99.16968190, label: "멕시코 지사" },
                    { lat: 8.98712300, lng: -79.51994610, label: "파나마 지사" },
                    { lat: 25.09755150, lng: 55.17406320, label: "아랍에미리트 지사" },
                ]
            },
            "267260": {
                color: "#4682B4",
                nodes: [
                    { lat: 34.67689270, lng: 135.49862430, label: "일본 지사" },
                    { lat: 24.69508700, lng: 46.68064720, label: "상하이 부사" },
                    { lat: 55.75477770, lng: 37.55696650, label: "러시아 지사" },
                    { lat: 24.95788650, lng: 55.05922780, label: "아랍에미리트 지사" },
                    { lat: 50.12736800, lng: 8.60264570, label: "독일 지사" },
                    { lat: 13.72229040, lng: 100.52934780, label: "태국 지사" },
                    { lat: 10.78270460, lng: 106.69743520, label: "베트남 지사" },
                    { lat: 51.37334840, lng: -0.45685490, label: "영국 지사" },
                    { lat: 24.69508700, lng: 46.68064720, label: "사우디아라비아 지사" },
                    { lat: 24.95788650, lng: 55.05922780, label: "HHHHHHHHHHHHHHH" },

                ]
            }
        };
            // 다른 기업 데이터 추가...
        

        // 지도 초기화
        function initMap() {
            map = new google.maps.Map(document.getElementById('map'), {
                center: { lat: 37.5665, lng: 126.9780 },
                zoom: 2,
                styles: [
                    { featureType: "all", elementType: "labels.text.fill", stylers: [{ color: "#191F28" }] },
                    { featureType: "all", elementType: "labels.text.stroke", stylers: [{ color: "#ffffff" }] },
                    { featureType: "water", elementType: "geometry", stylers: [{ color: "#E5E8EB" }] }
                ]
            });
        }

        // 기업 선택 시 지도 업데이트
        function updateCompanyInfo() {
            const selectedCompany = document.getElementById('companySelect').value;
            if (companyData[selectedCompany]) {
                loadCompanyData(companyData[selectedCompany]);
            }
        }

        // 기업 데이터 로드
        function loadCompanyData(company) {
            clearMap();
            company.nodes.forEach(node => {
                const marker = new google.maps.Marker({
                    position: { lat: node.lat, lng: node.lng },
                    map: map,
                    icon: {
                        path: google.maps.SymbolPath.CIRCLE,
                        scale: 8,
                        fillColor: company.color,
                        fillOpacity: 1,
                        strokeWeight: 1,
                        strokeColor: "#000"
                    },
                    label: { text: node.label, color: "black", fontSize: "12px" }
                });
                markers.push(marker);
            });

            for (let i = 0; i < company.nodes.length - 1; i++) {
                const polyline = new google.maps.Polyline({
                    path: [company.nodes[i], company.nodes[i + 1]],
                    geodesic: true,
                    strokeColor: company.color,
                    strokeOpacity: 1.0,
                    strokeWeight: 3,
                    map: map
                });
                polylines.push(polyline);
            }
        }

        // 기존 마커와 라인 제거
        function clearMap() {
            markers.forEach(marker => marker.setMap(null));
            polylines.forEach(line => line.setMap(null));
            markers = [];
            polylines = [];
        }
    </script>

    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBfIo_r6F31jWYr0FF1W_iLkgwYlDPPxzw&callback=initMap" async defer></script>
</body>
</html>