<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
    // 데이터베이스 연결 정보
    String url = "jdbc:mysql://localhost:3306/stockdb";
    String user = "root";
    String password = "password";
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String selectedStock = request.getParameter("stockCode");
    
    if (selectedStock == null) {
        selectedStock = "005930"; // 기본값: 삼성전자
    }

    List<Integer> stockPrices = new ArrayList<>();
    List<Integer> riskData = new ArrayList<>();
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);
        
        // 주식 가격 데이터 조회
        String sql = "SELECT price FROM stock_prices WHERE stock_code = ? ORDER BY time ASC LIMIT 8";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, selectedStock);
        rs = pstmt.executeQuery();
        while (rs.next()) {
            stockPrices.add(rs.getInt("price"));
        }
        
        // 위험도 데이터 조회
        sql = "SELECT risk FROM stock_risk WHERE stock_code = ? ORDER BY month DESC LIMIT 6";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, selectedStock);
        rs = pstmt.executeQuery();
        while (rs.next()) {
            riskData.add(rs.getInt("risk"));
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SPAndTech</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link rel="stylesheet" href="/css/SecondPage.css">
    <link rel="stylesheet" href="secondpage.html">
</head>
<body>
    <nav class="navbar">
        <div class="logo">
            <i class="fas fa-leaf"></i> SPAndTech
        </div>
        <div class="nav-links">
            <a href="MAINPAGE2.jsp">홈</a>
            <a href="MYPAGE.jsp">마이페이지</a>
            <a href="#">설정</a>
            <a href="secondpage.jsp">리스크</a>
        </div>
        <div class="search-bar">
            <input type="text" placeholder="종목명, 종목코드 검색">
        </div>
        <button class="btn-login">로그인</button>
    </nav>
    <main class="main-content">
        <section class="chart-section">
            <form method="get" action="secondpage.jsp">
                <select name="stockCode" class="stock-selector" onchange="this.form.submit()">
                    <option value="005930" <% if (selectedStock.equals("005930")) out.print("selected"); %>>삼성전자 (005930)</option>
                    <option value="000660" <% if (selectedStock.equals("000660")) out.print("selected"); %>>SK하이닉스 (000660)</option>
                    <option value="035720" <% if (selectedStock.equals("035720")) out.print("selected"); %>>카카오 (035720)</option>
                    <option value="035420" <% if (selectedStock.equals("035420")) out.print("selected"); %>>NAVER (035420)</option>
                    <option value="051910" <% if (selectedStock.equals("051910")) out.print("selected"); %>>LG화학 (051910)</option>
                    <option value="005380" <% if (selectedStock.equals("005380")) out.print("selected"); %>>현대차 (005380)</option>
                    <option value="207940" <% if (selectedStock.equals("207940")) out.print("selected"); %>>삼성바이오로직스 (207940)</option>
                    <option value="006400" <% if (selectedStock.equals("006400")) out.print("selected"); %>>삼성SDI (006400)</option>
                </select>
            </form>
            <div class="stock-price"><%= stockPrices.size() > 0 ? stockPrices.get(stockPrices.size() - 1) + "원" : "데이터 없음" %></div>
            <div class="chart-wrapper">
                <canvas id="stockChart"></canvas>
            </div>
        </section>
        <section class="risk-section">
            <div class="chart-wrapper">
                <canvas id="riskChart"></canvas>
            </div>
        </section>
    </main>
</body>
</html>
