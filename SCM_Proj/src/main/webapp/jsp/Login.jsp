<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SPAndTech - 로그인/회원가입</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Login.css">
</head>
<body>
    <%-- 로그인 상태 확인 --%>
    <% 
        // 세션에서 로그인 정보 확인
        String userId = (String) session.getAttribute("userId");
        if(userId != null) {
            // 이미 로그인된 경우 메인 페이지로 리다이렉트
            response.sendRedirect("Mainpage2.jsp");
            return;
        }
        
        // 로그인 에러 메시지 확인
        String errorMsg = (String) session.getAttribute("loginError");
        if(errorMsg != null) {
            // 에러 메시지 표시 후 세션에서 제거
            out.println("<div class='error-message'>" + errorMsg + "</div>");
            session.removeAttribute("loginError");
        }
    %>

    <nav class="navbar">
        <a href="Mainpage2.jsp" class="logo">
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

            <%-- 로그인 폼 --%>
            <form id="loginForm" class="auth-form" action="LoginController" method="post">
                <div class="form-group">
                    <label for="email">이메일</label>
                    <input type="email" id="email" name="email" placeholder="이메일을 입력하세요" required>
                </div>
                <div class="form-group">
                    <label for="password">비밀번호</label>
                    <input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요" required>
                </div>
                <button type="submit" class="submit-btn">로그인</button>
                <div class="auth-footer">
                    비밀번호를 잊으셨나요? <a href="findPassword.jsp">비밀번호 찾기</a>
                </div>
            </form>

            <%-- 회원가입 폼 --%>
            <form id="signupForm" class="auth-form" action="JoinController" method="post" style="display: none;">
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
                <div class="form-group">
                    <label for="signup-password-confirm">비밀번호 확인</label>
                    <input type="password" id="signup-password-confirm" name="passwordConfirm" placeholder="비밀번호를 다시 입력하세요" required>
                </div>
                <button type="submit" class="submit-btn">회원가입</button>
                <div class="auth-footer">
                    이미 계정이 있으신가요? <a href="#" onclick="switchTab('login')">로그인하기</a>
                </div>
            </form>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/js/Login.js"></script>
</body>
</html>
