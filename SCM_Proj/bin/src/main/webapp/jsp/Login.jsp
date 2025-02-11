<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.scm.model.CustomerDTO" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MQAndTech - 로그인/회원가입</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/Login.css"> <!-- 경로 수정 -->
</head>
<body>
    <nav class="navbar">
        <a href="<%= request.getContextPath() %>/jsp/MainPage.jsp" class="logo">
            <i class="fas fa-leaf"></i> MQAndTech
        </a>
    </nav>

    <div class="auth-container">
        <div class="auth-box">
            <div class="auth-header">
                <h1>환영합니다</h1>
                <p>MQAndTech와 함께 스마트한 투자를 시작하세요</p>
            </div>

            <div class="auth-tabs">
                <div class="auth-tab active" onclick="switchTab('login')">로그인</div>
                <div class="auth-tab" onclick="switchTab('signup')">회원가입</div>
            </div>

            <!-- 로그인 폼 -->
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

                <!-- 로그인 버튼 스타일 유지 -->
                <button type="submit" class="submit-btn" style="width: 100%; height: 50px; font-size: 1.1rem; padding: 12px; display: flex; align-items: center; justify-content: center;">
                    로그인
                </button>

                <div class="auth-footer">
                    비밀번호를 잊으셨나요? <a href="#">비밀번호 찾기</a>
                </div>
            </form>

            <!-- 회원가입 폼 -->
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

                <!-- 회원가입 버튼 스타일 유지 -->
                <button type="submit" class="submit-btn" style="width: 100%; height: 50px; font-size: 1.1rem; padding: 12px; display: flex; align-items: center; justify-content: center;">
                    회원가입
                </button>

                <div class="auth-footer">
                    이미 계정이 있으신가요? <a href="#" onclick="switchTab('login')">로그인하기</a>
                </div>
            </form>
        </div>
    </div>

    <script>
        function switchTab(tab) {
            const loginForm = document.getElementById('loginForm');
            const signupForm = document.getElementById('signupForm');
            const tabs = document.querySelectorAll('.auth-tab');

            tabs.forEach(t => t.classList.remove('active'));

            if (tab === 'login') {
                loginForm.style.display = 'block';
                signupForm.style.display = 'none';
                tabs[0].classList.add('active');
            } else {
                loginForm.style.display = 'none';
                signupForm.style.display = 'block';
                tabs[1].classList.add('active');
            }
        }

        // 회원가입 성공 및 로그인 실패 알림 처리
        document.addEventListener("DOMContentLoaded", function () {
            const params = new URLSearchParams(window.location.search);

            // 회원가입 성공 시
            if (params.get("success") === "registered") {
                alert("회원가입에 성공했습니다.");
                switchTab('login');  // 로그인 탭으로 자동 전환
            }

            // 로그인 실패 시
            if (params.get("error") === "loginFailed") {
                alert("로그인에 실패했습니다. 아이디 또는 비밀번호를 확인하세요.");
                switchTab('login');  // 로그인 탭 유지
            }
        });
    </script>
</body>
</html>
