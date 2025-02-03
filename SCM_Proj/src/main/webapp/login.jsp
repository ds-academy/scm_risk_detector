<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SPAndTech - 로그인/회원가입</title>
    <link rel="stylesheet" href="./css/Login.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="login.html">
</head>
<body>
    <nav class="navbar">
        <a href="#" class="logo">
            <i class="fas fa-leaf"></i>
            SPAndTech
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

            <form id="loginForm" class="auth-form" action="login" method="post">
                <div class="form-group">
                    <label for="email">이메일</label>
                    <input type="email" id="email" name="email" placeholder="이메일을 입력하세요" required>
                </div>
                <div class="form-group">
                    <label for="password">비밀번호</label>
                    <input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요" required>
                </div>
                <button type="submit" class="submit-btn">로그인</button>
                
            </form>

            <form id="signupForm" class="auth-form" action="signup" method="post" style="display: none;">
                <div class="form-group">
                    <label for="signup-name">이름</label>
                    <input type="text" id="signup-name" name="name" placeholder="이름을 입력하세요" required>
                </div>
                <div class="form-group">
                    <label for="signup-email">이메일</label>
                    <input type="email" id="signup-email" name="email" placeholder="이메일을 입력하세요" required>
                </div>
                <div class="form-group">
                    <label for="signup-password">비밀번호</label>
                    <input type="password" id="signup-password" name="password" placeholder="비밀번호를 입력하세요" required>
                </div>
                <!-- <div class="form-group">
                    <label for="signup-password-confirm">비밀번호 확인</label>
                    <input type="password" id="signup-password-confirm" name="passwordConfirm" placeholder="비밀번호를 다시 입력하세요" required>
                </div> -->
                <button type="submit" class="submit-btn">회원가입</button>
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
                loginForm.style.display = 'flex';
                signupForm.style.display = 'none';
                tabs[0].classList.add('active');
            } else {
                loginForm.style.display = 'none';
                signupForm.style.display = 'flex';
                tabs[1].classList.add('active');
            }
        }
    </script>
</body>
</html>
