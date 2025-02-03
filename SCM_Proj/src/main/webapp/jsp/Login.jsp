<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.scm.model.CustomerDTO" %>
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
        CustomerDTO user = (CustomerDTO) session.getAttribute("user");
        if(user != null) {
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
                    <label for="USER_ID">아이디</label>
                    <input type="text" id="USER_ID" name="USER_ID" placeholder="아이디를 입력하세요" required>
                </div>
                <div class="form-group">
                    <label for="PASSWORD">비밀번호</label>
                    <input type="password" id="PASSWORD" name="PASSWORD" placeholder="비밀번호를 입력하세요" required>
                </div>
                <button type="submit" class="submit-btn">로그인</button>
               <!--  <div class="auth-footer">
                    비밀번호를 잊으셨나요? <a href="findPassword.jsp">비밀번호 찾기</a>
                </div> -->
            </form>

            <%-- 회원가입 폼 --%>
            <form id="signupForm" class="auth-form" action="JoinController" method="post" style="display: none;">
                <div class="form-group">
                    <label for="signup-USER_ID">아이디</label>
                    <input type="text" id="signup-USER_ID" name="USER_ID" placeholder="아이디를 입력하세요" required>
                </div>
                <div class="form-group">
                    <label for="signup-USER_NAME">이름</label>
                    <input type="text" id="signup-USER_NAME" name="USER_NAME" placeholder="이름을 입력하세요" required>
                </div>
                <div class="form-group">
                    <label for="signup-EMAIL">이메일</label>
                    <input type="email" id="signup-EMAIL" name="EMAIL" placeholder="이메일을 입력하세요" required>
                </div>
                <div class="form-group">
                    <label for="signup-MOBILE">전화번호</label>
                    <input type="tel" id="signup-MOBILE" name="MOBILE" placeholder="전화번호를 입력하세요" required>
                </div>
                <div class="form-group">
                    <label for="signup-PASSWORD">비밀번호</label>
                    <input type="password" id="signup-PASSWORD" name="PASSWORD" placeholder="비밀번호를 입력하세요" required>
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
            const loginForm = document.getElementById('loginForm');
            const signupForm = document.getElementById('signupForm');
            const tabs = document.querySelectorAll('.auth-tab');
            
            if (tab === 'login') {
                loginForm.style.display = 'block';
                signupForm.style.display = 'none';
                tabs[0].classList.add('active');
                tabs[1].classList.remove('active');
            } else {
                loginForm.style.display = 'none';
                signupForm.style.display = 'block';
                tabs[0].classList.remove('active');
                tabs[1].classList.add('active');
            }
        }
    </script>
</body>
</html>
