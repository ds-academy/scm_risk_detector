<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.scm.model.CustomerDTO" %>

<%
    // 로그인 상태 확인
    CustomerDTO user = (CustomerDTO) session.getAttribute("user");
    boolean isLoggedIn = (user != null);

    // 디버깅 코드 (브라우저에서 확인 가능)
    if (isLoggedIn) {
        out.println("DEBUG - USER_NAME: " + user.getUSER_NAME());
        out.println("DEBUG - EMAIL: " + user.getEMAIL());
    } else {
        out.println("DEBUG - 로그인되지 않음.");
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MQAndTech - 마이페이지</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="../css/Mypage.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <nav class="navbar">
        <div class="logo">
            <a href="MainPage.jsp" style="text-decoration: none; color : inherit;">
                <i class="fas fa-leaf"></i> MQAndTech
            </a>
        </div>
        <div class="nav-links">
            <a href="MainPage.jsp">홈</a>
            <a href="Mypage.jsp">마이페이지</a>
            <a href="secondPage.jsp">리스크</a>
        </div>
        <div class="search-bar">
            <input type="text" placeholder="종목명, 종목코드 검색">
        </div>
        <button class="btn-login">
            <%= isLoggedIn ? "로그아웃" : "로그인" %>
        </button>
    </nav>

    <main class="main-content">
        <section class="profile-section">
            <div class="profile-header">
                <div class="profile-info">
                    <div class="profile-image">
                        <i class="fas fa-user"></i>
                    </div>
                    <div class="profile-details">
                        <h2><%= isLoggedIn && user.getUSER_NAME() != null ? user.getUSER_NAME() + " 님" : "홍길동 님" %></h2>
                        <p><%= isLoggedIn && user.getEMAIL() != null ? user.getEMAIL() : "hong@example.com" %></p>
                    </div>
                </div>
                <button class="btn-edit">프로필 수정</button>
            </div>
        </section>

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

        <section class="watchlist-section">
            <h2 class="section-title">관심 종목</h2>
            <div class="watchlist-header">
                <select class="stock-select" id="stockSelect">
                    <option value="004370">농심 (004370)</option>
                    <option value="005380">현대자동차 (005380)</option>
                    <option value="005930">삼성전자 (005930)</option>
                    <option value="034220">LG디스플레이 (034220)</option>
                    <option value="051900">LG생활과학(051900)</option>
                    <option value="051910">LG화학 (051910)</option>
                    <option value="073240">금호타이어 (073240)</option>
                    <option value="267260">HD현대일렉트릭 (267260)</option>
                </select>
            </div>
           <div class="watchlist-container">
                <div class="stock-card">
                    <div class="stock-header">
                        <span class="stock-name">삼성전자</span>
                        <button class="btn-remove"><i class="fas fa-times"></i></button>
                    </div>
                    <div class="stock-price">74,300</div>
                    <div class="stock-change positive">+1.23%</div>
                    <div class="risk-level low">저위험</div>
                </div>
            </div>
        </section>
    </main>
    
    <!-- JavaScript -->
    <script type="text/javascript">
    $(document).ready(function() {
        // 로그인/로그아웃 버튼 클릭 처리
        $('.btn-login').click(function() {
            const isLoggedIn = '<%= isLoggedIn %>' === 'true';
            if (isLoggedIn) {
                window.location.href = '<%= request.getContextPath() %>/auth?action=logout';
            } else {
                window.location.href = '<%= request.getContextPath() %>/jsp/Login.jsp';
            }
        });

        // 프로필 수정 버튼 클릭 처리
        $('.btn-edit').click(function() {
            window.location.href = '<%= request.getContextPath() %>/jsp/Mypage2.jsp';
        });

        // 리스크 알림 체크박스 변경 처리
        $('#riskAlert').change(function() {
            alert($(this).is(':checked') ? "리스크 알림이 활성화 되었습니다." : "리스크 알림이 비활성화 되었습니다.");
        });

        // 가격 변동 알림 체크박스 변경 처리
        $('#priceAlert').change(function() {
            alert($(this).is(':checked') ? "가격 변동 알림이 활성화 되었습니다." : "가격 변동 알림이 비활성화 되었습니다.");
        });

        // 종목 선택 시 주식 정보 가져오기
        $('#stockSelect').change(function() {
            const companyCode = $(this).val();
            if (companyCode) {
                fetchStockInfo(companyCode);
            }
        });

        // AJAX로 주식 정보 가져오기
        function fetchStockInfo(companyCode) {
            $.ajax({
                url: '<%= request.getContextPath() %>/stocks', // Backend endpoint
                method: 'GET',
                data: { action: 'getStockInfo', companyCode: companyCode },
                dataType: 'json',
                success: function(data) {
                    console.log("서버 응답:", data); // 디버깅용 로그

                    if (data && data.COMPANY_NAME && data.CURRENT_CLOSE && data.PERCENT_CHANGE !== undefined) {
                        renderStockInfo(data);
                    } else {
                        $('.watchlist-container').html('<p>주식 정보를 불러올 수 없습니다.</p>');
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Error fetching stock info:", xhr.status, error);
                    $('.watchlist-container').html('<p>서버 오류로 데이터를 불러올 수 없습니다.</p>');
                }
            });
        }

        // 주식 정보를 화면에 렌더링하는 함수
        function renderStockInfo(stockData) {
    // Ensure stockData contains all required fields
    const companyName = stockData.COMPANY_NAME || "알 수 없음";
    const currentPrice = stockData.CURRENT_CLOSE ? stockData.CURRENT_CLOSE.toLocaleString() : "0";
    const percentChange = stockData.PERCENT_CHANGE || 0;

    // Determine the class for price change (positive or negative)
    const changeClass = percentChange >= 0 ? 'positive' : 'negative';
    const riskLevel = Math.abs(percentChange) > 5 ? '고위험' : '저위험';
    const riskClass = Math.abs(percentChange) > 5 ? 'high' : 'low';

    // Create the stock card HTML structure
     const stockCardHtml = `
        <div class="stock-card">
            <div class="stock-header">
                <span class="stock-name">${companyName}</span>
                <button class="btn-remove"><i class="fas fa-times"></i></button>
            </div>
            <div class="stock-price">${currentPrice} 원</div>
            <div class="stock-change ${changeClass}">
                ${percentChange >= 0 ? '+' : ''}${percentChange.toFixed(2)}%
            </div>
            <div class="risk-level ${riskClass}">${riskLevel}</div>
        </div>`;

    // Clear the container before inserting new content
    $('.watchlist-container').empty(); // Clear existing content

    // Insert the new stock card HTML into the container
    $('.watchlist-container').html(stockCardHtml); // Ensure that the content is added
        }
        });
    </script>
</body>
</html>
