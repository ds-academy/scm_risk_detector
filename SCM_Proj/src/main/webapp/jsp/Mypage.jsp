<%@page import="com.scm.model.CustomerDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SPAndTech - 프로필 수정</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Mainpage.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Mypage2.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ProfileEdit.css">
</head>
<body>
    <%
        // 로그인 체크
        CustomerDTO user = (CustomerDTO) session.getAttribute("user");
        if(user == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
    %>

    <nav class="navbar">
        <div class="logo">
            <i class="fas fa-leaf"></i> SPAndTech
        </div>
        <div class="nav-links">
            <a href="Mainpage2.jsp">홈</a>
            <a href="Mypage.jsp" class="active">마이페이지</a>
            <a href="Settings.jsp">설정</a>
            <a href="Risk.jsp">리스크</a>
        </div>
        <div class="search-bar">
            <input type="text" placeholder="종목명, 종목코드 검색">
        </div>
        <form action="LogoutController" method="post" style="display: inline;">
            <button type="submit" class="btn-login">로그아웃</button>
        </form>
    </nav>

    <main class="main-content">
        <section class="edit-profile-section">
            <div class="section-header">
                <h2 class="section-title">프로필 수정</h2>
                <p class="section-description">프로필 정보를 수정하고 관리하세요.</p>
            </div>

            <form class="profile-form" action="UpdateProfileController" method="post">
                <div class="form-fields">
                    <div class="form-group">
                        <label for="USER_ID">아이디</label>
                        <input type="text" id="USER_ID" name="USER_ID" value="<%=user.getUSER_ID()%>" class="form-input" readonly>
                        <p class="input-description">아이디는 변경할 수 없습니다.</p>
                    </div>

                    <div class="form-group">
                        <label for="USER_NAME">이름</label>
                        <input type="text" id="USER_NAME" name="USER_NAME" value="<%=user.getUSER_NAME()%>" class="form-input">
                    </div>

                    <div class="form-group">
                        <label for="EMAIL">이메일</label>
                        <input type="email" id="EMAIL" name="EMAIL" value="<%=user.getEMAIL()%>" class="form-input">
                    </div>

                    <div class="form-group">
                        <label for="MOBILE">전화번호</label>
                        <input type="tel" id="MOBILE" name="MOBILE" value="<%=user.getMOBILE()%>" class="form-input">
                    </div>

                    <div class="form-group">
                        <label for="PASSWORD">새 비밀번호</label>
                        <input type="password" id="PASSWORD" name="PASSWORD" class="form-input">
                        <p class="input-description">변경을 원하시는 경우에만 입력하세요.</p>
                    </div>

                    <div class="button-group">
                        <button type="submit" class="btn-save">저장하기</button>
                        <a href="Mypage.jsp" class="btn-cancel">취소</a>
                    </div>
                </div>
            </form>
        </section>
    </main>

    <script>
        // 폼 제출 전 유효성 검사
        document.querySelector('.profile-form').addEventListener('submit', function(e) {
            const name = document.getElementById('USER_NAME').value;
            const email = document.getElementById('EMAIL').value;
            const mobile = document.getElementById('MOBILE').value;
            
            if (!name || !email || !mobile) {
                e.preventDefault();
                alert('모든 필수 항목을 입력해주세요.');
                return;
            }
            
            // 이메일 형식 검사
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                e.preventDefault();
                alert('올바른 이메일 형식을 입력해주세요.');
                return;
            }
            
            // 전화번호 형식 검사
            const mobileRegex = /^[0-9]{10,11}$/;
            if (!mobileRegex.test(mobile.replace(/-/g, ''))) {
                e.preventDefault();
                alert('올바른 전화번호 형식을 입력해주세요.');
                return;
            }
        });
    </script>
</body>
</html>
