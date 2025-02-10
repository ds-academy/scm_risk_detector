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
                <!-- 프로필 수정 버튼 클릭 시 Mypage2.jsp로 이동 -->
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
                    <option value="">종목 선택</option>
                    <option value="samsung">삼성전자</option>
                    <option value="hyundai">현대차</option>
                    <option value="sk">SK하이닉스</option>
                    <option value="naver">네이버</option>
                    <option value="kakao">카카오</option>
                    <option value="lg">LG전자</option>
                    <option value="kia">기아</option>
                    <option value="posco">POSCO</option>
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
    
    <script type="text/javascript">
    $(document).ready(function() {
        // 로그인/로그아웃 버튼 클릭 시 처리
        $('.btn-login').click(function() {
            var isLoggedIn = '<%= isLoggedIn %>' === 'true';

            if (isLoggedIn) {
                // 로그아웃 처리: 세션 무효화 및 로그인 페이지로 이동
                window.location.href = '<%= request.getContextPath() %>/auth?action=logout';
            } else {
                // 로그인 페이지로 이동
                window.location.href = '<%= request.getContextPath() %>/jsp/Login.jsp';
            }
        });

        // 프로필 수정 버튼 클릭 시 Mypage2.jsp로 이동
        $('.btn-edit').click(function() {
            window.location.href = '<%= request.getContextPath() %>/jsp/Mypage2.jsp';
        });
        
        
        // 리스크 알림 체크 시 알림
        $('#riskAlert').change(function() {
            if ($(this).is(':checked')) {
                alert("리스크 알림이 활성화 되었습니다.");
            } else {
                alert("리스크 알림이 비활성화 되었습니다.");
            }
        });

        // 가격 변동 알림 체크 시 알림
        $('#priceAlert').change(function() {
            if ($(this).is(':checked')) {
                alert("가격 변동 알림이 활성화 되었습니다.");
            } else {
                alert("가격 변동 알림이 비활성화 되었습니다.");
            }
        });
    });
    </script>
</body>
</html>
