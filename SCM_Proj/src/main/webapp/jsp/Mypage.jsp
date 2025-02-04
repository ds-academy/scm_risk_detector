<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.spandtech.model.Stock" %>
<%@ page import="com.spandtech.dao.StockDAO" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SPAndTech - 마이페이지</title>
    
    <!-- FontAwesome 아이콘 라이브러리 로드 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    
    <!-- 외부 CSS 파일 로드 -->
    <link rel="stylesheet" href="../css/Mypage.css">
    
    <!-- jQuery 라이브러리 로드 -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <%
        // 세션에서 사용자 정보 가져오기 (로그인 확인)
        String userName = (String) session.getAttribute("userName");
        String userEmail = (String) session.getAttribute("userEmail");
        
        // 로그인하지 않은 경우 로그인 페이지로 이동
        if(userName == null || userEmail == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        // 데이터베이스에서 주식 목록 가져오기
        StockDAO stockDAO = new StockDAO();
        List<Stock> availableStocks = stockDAO.getAllStocks();
    %>

    <!-- 네비게이션 바 -->
    <nav class="navbar">
        <div class="logo">
            <i class="fas fa-leaf"></i> SPAndTech
        </div>
        <div class="nav-links">
            <a href="Mainpage2.jsp">홈</a>
            <a href="Mypage" class="active">마이페이지</a>
            <a href="#" onclick="alert('준비 중입니다.');">설정</a>
            <a href="Secondpage.jsp">리스크</a>
        </div>
        <div class="search-bar">
            <input type="text" placeholder="종목명, 종목코드 검색">
        </div>
        <button class="btn-login" onclick="logout()">로그아웃</button>
    </nav>

    <!-- 메인 콘텐츠 -->
    <main class="main-content">
        <!-- 프로필 섹션 -->
        <section class="profile-section">
            <div class="profile-header">
                <div class="profile-info">
                    <div class="profile-image">
                        <i class="fas fa-user"></i>
                    </div>
                    <div class="profile-details">
                        <h2><%= userName %> 님</h2>
                        <p><%= userEmail %></p>
                    </div>
                </div>
                <button class="btn-edit" onclick="location.href='mypage2.jsp'">프로필 수정</button>
            </div>
        </section>

        <!-- 설정 섹션 -->
        <section class="settings-section">
            <h2 class="section-title">알림 설정</h2>
            <div class="settings-grid">
                <div class="setting-card">
                    <div class="setting-header">
                        <h3>리스크 알림</h3>
                        <label class="switch">
                            <input type="checkbox" id="riskAlert">
                            <span class="slider round"></span>
                        </label>
                    </div>
                    <p class="setting-description">고위험 종목에 대한 실시간 알림을 받습니다.</p>
                </div>
                <div class="setting-card">
                    <div class="setting-header">
                        <h3>가격 변동 알림</h3>
                        <label class="switch">
                            <input type="checkbox" id="priceAlert">
                            <span class="slider round"></span>
                        </label>
                    </div>
                    <p class="setting-description">관심 종목의 가격 변동 알림을 받습니다.</p>
                </div>
            </div>
        </section>

        <!-- 관심 종목 섹션 -->
        <section class="watchlist-section">
            <h2 class="section-title">관심 종목</h2>
            <div class="watchlist-grid">
                <div class="stock-selection">
                    <!-- 주식 목록 선택 -->
                    <select id="stockSelect" multiple>
                        <% for(Stock stock : availableStocks) { %>
                            <option value="<%= stock.getCode() %>"><%= stock.getName() %></option>
                        <% } %>
                    </select>
                    <button onclick="addSelectedStocks()">추가</button>
                </div>
                
                <!-- 선택된 주식들이 추가될 컨테이너 -->
                <div id="selectedStocksContainer"></div>
            </div>
        </section>
    </main>

    <script>
        // 리스크 알림 설정 시 알림 표시
        $('#riskAlert').on('change', function() {
            if($(this).is(':checked')) {
                alert('리스크 알림 설정이 완료되었습니다.');
            }
        });

        // 가격 변동 알림 설정 시 알림 표시
        $('#priceAlert').on('change', function() {
            if($(this).is(':checked')) {
                alert('가격 변동 알림이 완료되었습니다.');
            }
        });

        // 관심 주식 추가 기능
        function addSelectedStocks() {
            const selectedOptions = $('#stockSelect').val(); // 선택한 주식 코드 배열
            const selectedStocksContainer = $('#selectedStocksContainer');
            
            selectedStocksContainer.empty(); // 기존 선택 초기화

            if(selectedOptions && selectedOptions.length > 0) {
                selectedOptions.forEach(stockCode => {
                    // 주식 정보를 가져오기 위한 AJAX 요청
                    $.ajax({
                        url: 'getStockData.jsp', // 주식 정보를 가져올 JSP 파일
                        method: 'GET',
                        data: { stockCode: stockCode },
                        success: function(data) {
                            // 동적으로 선택한 주식 정보 추가
                            selectedStocksContainer.append(`
                                <div class="stock-card">
                                    <div class="stock-header">
                                        <span class="stock-name">\${data.name}</span>
                                        <button class="btn-remove" onclick="removeStock('\${stockCode}')">
                                            <i class="fas fa-times"></i>
                                        </button>
                                    </div>
                                    <div class="stock-price">\${data.price}</div>
                                    <div class="stock-change \${data.change > 0 ? 'positive' : 'negative'}">\${data.changePercent}%</div>
                                    <div class="risk-level \${data.riskLevel}">\${data.riskLevelText}</div>
                                </div>
                            `);
                        }
                    });
                });
            }
        }

        // 선택한 주식 제거 기능
        function removeStock(stockCode) {
            $(`#selectedStocksContainer .stock-card:contains('\${stockCode}')`).remove();
        }

        // 로그아웃 처리
        function logout() {
            <%
                // 세션 무효화
                session.invalidate();
            %>
            location.href = 'login.jsp';
        }
    </script>
</body>
</html>
