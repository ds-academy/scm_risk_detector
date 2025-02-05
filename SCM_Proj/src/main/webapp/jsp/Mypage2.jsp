<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.scm.model.CustomerDTO" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SPAndTech - 프로필 수정</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="../css/Mainpage.css">
    <link rel="stylesheet" href="../css/Mypage2.css">
</head>
<body>
    <%
        HttpSession userSession = request.getSession(false);
        CustomerDTO user = (CustomerDTO) userSession.getAttribute("user");

        if (user == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        String userId = user.getUSER_ID();
        String userName = user.getUSER_NAME();
        String userEmail = user.getEMAIL();
        String userPhone = user.getMOBILE();
    %>

    <nav class="navbar">
        <div class="logo">
            <i class="fas fa-leaf"></i> SPAndTech
        </div>
        <div class="nav-links">
            <a href="Mainpage2.jsp">홈</a>
            <a href="Mypage.jsp" class="active">마이페이지</a>
            <a href="#">설정</a>
            <a href="Secondpage.jsp">리스크</a>
        </div>
        <div class="search-bar">
            <input type="text" placeholder="종목명, 종목코드 검색">
        </div>
        <button class="btn-login" onclick="logout()">로그아웃</button>
    </nav>

    <main class="main-content">
        <section class="edit-profile-section">
            <div class="section-header">
                <h2 class="section-title">프로필 수정</h2>
                <p class="section-description">프로필 정보를 수정하고 관리하세요.</p>
            </div>

            <form class="profile-form" id="profileForm" action="<%= request.getContextPath() %>/auth?action=update" method="post" onsubmit="return validateAndSubmit()">
                <div class="form-image-section">
                    <div class="profile-image-wrapper">
                        <div class="profile-image" id="profileImageDisplay">
                            <i class="fas fa-user"></i>
                        </div>
                        <div class="image-upload-overlay">
                            <i class="fas fa-camera"></i>
                        </div>
                    </div>
                    <input type="file" id="profileImage" name="profileImage" hidden accept="image/*" onchange="previewImage(event)">
                    <button type="button" class="btn-upload" onclick="document.getElementById('profileImage').click()">이미지 업로드</button>
                </div>

                <div class="form-fields">
                    <div class="form-group">
                        <label for="username">아이디</label>
                        <input type="text" id="username" name="USER_ID" value="<%= userId %>" class="form-input" readonly>
                        <p class="input-description">아이디는 변경할 수 없습니다.</p>
                    </div>

                    <div class="form-group">
                        <label for="name">이름</label>
                        <input type="text" id="name" name="USER_NAME" value="<%= userName %>" class="form-input">
                    </div>

                    <div class="form-group">
                        <label for="password">비밀번호</label>
                        <input type="password" id="password" name="PASSWORD" class="form-input" required>
                    </div>

                    <div class="form-group">
                        <label for="phone">전화번호</label>
                        <input type="tel" id="phone" name="MOBILE" value="<%= userPhone %>" class="form-input">
                    </div>

                    <div class="form-group">
                        <label for="email">이메일</label>
                        <input type="email" id="email" name="EMAIL" value="<%= userEmail %>" class="form-input" readonly>
                    </div>

                    <div class="form-actions">
                        <button type="button" class="btn-cancel" onclick="cancelEdit()">취소</button>
                        <button type="submit" class="btn-save">저장하기</button>
                    </div>
                </div>
            </form>
        </section>
    </main>

    <script>
        function previewImage(event) {
            const file = event.target.files[0];
            const reader = new FileReader();
            
            reader.onload = function(e) {
                document.getElementById('profileImageDisplay').innerHTML = `<img src="${e.target.result}" alt="Profile Image" style="width:100%; height:100%; object-fit:cover;">`;
            }
            
            reader.readAsDataURL(file);
        }

        function validatePassword(password) {
            const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;
            return passwordRegex.test(password);
        }

        function validateAndSubmit() {
            const password = document.getElementById('password').value;
            
            if (!validatePassword(password)) {
                alert('오류: 비밀번호는 최소 8자 이상, 숫자 및 특수 문자를 포함해야 합니다.');
                return false;
            }

            alert('회원 수정이 확인되었습니다.');
            return true;
        }

        function cancelEdit() {
            window.location.href = 'Mypage.jsp';
        }

        function logout() {
            window.location.href = '<%= request.getContextPath() %>/auth?action=logout';
        }
    </script>
</body>
</html>
