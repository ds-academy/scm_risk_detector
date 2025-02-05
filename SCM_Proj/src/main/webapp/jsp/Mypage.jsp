<%@page import="org.apache.ibatis.session.SqlSessionFactory"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.scm.model.StockDTO" %>
<%@ page import="com.scm.model.StockDAO" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactory" %>
<%@ page import="com.scm.db.SqlSessionManager" %> 
<%@ page import="com.scm.model.CustomerDTO" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    // ✅ 세션 확인 (로그인 여부 체크)
    HttpSession userSession = request.getSession(false);
    if (userSession == null || userSession.getAttribute("user") == null) {
        System.out.println("세션 오류: 로그인한 사용자 정보 없음");
        response.sendRedirect("Login.jsp");
        return;
    }

    // ✅ 세션에서 사용자 정보 가져오기
    CustomerDTO loggedInUser = (CustomerDTO) userSession.getAttribute("user");
    String userName = loggedInUser.getUSER_NAME();
    String userEmail = loggedInUser.getEMAIL();

    // ✅ MyBatis 세션 팩토리 가져오기
    SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();
    if (sqlSessionFactory == null) {
        throw new Exception("SqlSessionFactory 생성 실패: MyBatis 설정 문제 발생");
    }

    // ✅ StockDAO 객체 생성 (DB 연결 최소화)
    StockDAO stockDAO = new StockDAO(sqlSessionFactory);
    List<StockDTO> availableStocks = stockDAO.getStockByCompany("AAPL");  // 예시로 "AAPL" 주식 데이터 조회
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SPAndTech - 마이페이지</title>

    <!-- ✅ 원본 스타일 유지 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="../css/Mypage.css">

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

    <!-- ✅ 원본 네비게이션 바 유지 -->
    <nav class="navbar">
        <div class="logo">
            <i class="fas fa-leaf"></i> SPAndTech
        </div>
        <div class="nav-links">
            <a href="Mainpage2.jsp">홈</a>
            <a href="Mypage.jsp" class="active">마이페이지</a>
            <a href="#" onclick="alert('준비 중입니다.');">설정</a>
            <a href="SecondPage.jsp">리스크</a>
        </div>
        <div class="search-bar">
            <input type="text" placeholder="종목명, 종목코드 검색">
        </div>
        <button class="btn-login" onclick="logout()">로그아웃</button>
    </nav>

    <!-- ✅ 원본 프로필 섹션 유지 -->
    <main class="main-content">
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
                <button class="btn-edit" onclick="location.href='MyPage2.jsp'">프로필 수정</button>
            </div>
        </section>

        <!-- ✅ 관심 종목 (동적 데이터 반영) -->
        <section class="watchlist-section">
            <h2 class="section-title">관심 종목</h2>
            <div class="watchlist-grid">
                <div class="stock-selection">
                    <select id="stockSelect" multiple>
                        <% for (StockDTO stock : availableStocks) { %>
                            <option value="<%= stock.getCOMPANY_CODE() %>"><%= stock.getCOMPANY_CODE() %></option>
                        <% } %>
                    </select>
                    <button onclick="addSelectedStocks()">추가</button>
                </div>
                <div id="selectedStocksContainer"></div>
            </div>
        </section>
    </main>

    <script>
        // ✅ 로그아웃 기능
        function logout() {
            window.location.href = '<%= request.getContextPath() %>/auth?action=logout';
        }

        // ✅ 관심 주식 추가 기능 (동적 데이터 반영)
        function addSelectedStocks() {
            const selectedOptions = $('#stockSelect').val();
            const selectedStocksContainer = $('#selectedStocksContainer');

            selectedStocksContainer.empty();

            if (selectedOptions && selectedOptions.length > 0) {
                selectedOptions.forEach(stockCode => {
                    $.ajax({
                        url: 'getStockData.jsp',
                        method: 'GET',
                        data: { stockCode: stockCode },
                        success: function(data) {
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

        // ✅ 관심 주식 제거 기능
        function removeStock(stockCode) {
            $(`#selectedStocksContainer .stock-card:contains('\${stockCode}')`).remove();
        }
    </script>

</body>
</html>
