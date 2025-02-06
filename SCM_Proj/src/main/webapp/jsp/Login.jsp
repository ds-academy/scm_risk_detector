<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.scm.model.CustomerDTO" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SPAndTech - 로그인/회원가입</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="../css/Login.css">
</head>
<body>
    <nav class="navbar">
        <a href="../jsp/Mainpage2.jsp" class="logo">
            <i class="fas fa-leaf"></i> SPAndTech
        </a>
    </nav>

    <div class="auth-container">
        <div class="auth-box">
            <div class="auth-header">
                <h1>환영합니다</h1>
                <p>SPAndTech와 함께 스마트한 투자를 시작하세요</p>
            </div>

            <div class="auth-tabs">
                <div class="auth-tab active" onclick="switchTab('login')">로그인</div>
                <div class="auth-tab" onclick="switchTab('signup')">회원가입</div>
            </div>

            <form id="loginForm" class="auth-form" action="${pageContext.request.contextPath}/auth" method="post">
                <input type="hidden" name="action" value="login">
                <div class="form-group">
                    <label for="LOGIN_USER_ID">아이디</label>
                    <input type="text" id="LOGIN_USER_ID" name="USER_ID" placeholder="아이디를 입력하세요" required>
                </div>
                <div class="form-group">
                    <label for="LOGIN_PASSWORD">비밀번호</label>
                    <input type="password" id="LOGIN_PASSWORD" name="PASSWORD" placeholder="비밀번호를 입력하세요" required>
                </div>
                <button type="submit" class="submit-btn">로그인</button>
                <div class="auth-footer">
                    비밀번호를 잊으셨나요? <a href="#">비밀번호 찾기</a>
                </div>
            </form>

            <form id="signupForm" class="auth-form" action="${pageContext.request.contextPath}/auth" method="post" style="display: none;">
                <input type="hidden" name="action" value="register">
                <div class="form-group">
                    <label for="REGISTER_USER_ID">아이디</label>
                    <input type="text" id="REGISTER_USER_ID" name="USER_ID" placeholder="아이디를 입력하세요" required>
                </div>
                <div class="form-group">
                    <label for="REGISTER_USER_NAME">이름</label>
                    <input type="text" id="REGISTER_USER_NAME" name="USER_NAME" placeholder="이름을 입력하세요" required>
                </div>
                <div class="form-group">
                    <label for="REGISTER_EMAIL">이메일</label>
                    <input type="email" id="REGISTER_EMAIL" name="EMAIL" placeholder="이메일을 입력하세요" required>
                </div>
                <div class="form-group">
                    <label for="REGISTER_MOBILE">전화번호</label>
                    <input type="tel" id="REGISTER_MOBILE" name="MOBILE" placeholder="전화번호를 입력하세요" required>
                </div>
                <div class="form-group">
                    <label for="REGISTER_PASSWORD">비밀번호</label>
                    <input type="password" id="REGISTER_PASSWORD" name="PASSWORD" placeholder="비밀번호를 입력하세요" required>
                </div>
                <button type="submit" class="submit-btn">회원가입</button>
                <div class="auth-footer">
                    이미 계정이 있으신가요? <a href="#" onclick="switchTab('login')">로그인하기</a>
                </div>
            </form>
        </div>
    </div>

    <script>
        function switchTab(tab) {
            const loginForm
