<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.scm.model.CustomerDTO" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SPAndTech - 마이페이지</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="../css/Mypage2.css">
</head>
<body>
    <%
        CustomerDTO user = (CustomerDTO) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/jsp/Login.jsp");
            return;
        }
    %>

    <nav class="navbar">
        <a href="../jsp/Mainpage2.jsp" class="logo"><i class="fas fa-leaf"></i> SPAndTech </a>
        <div class="nav-links">
            <a href="#">홈</a>
            <a href="#">마이페이지</a>
            <a href="#">설정</a>
            <a href="#">리스크</a>
        </div>
        <button class="btn-logout" onclick="logout()">로그아웃</button>
    </nav>

    <main class="main-content">
        <section class="profile-section">
            <h2>마이페이지</h2>

            <!-- Display User Info -->
            <div class="user-info">
                <h3>안녕하세요, <%= user.getUSER_NAME() %>님!</h3>
                <p>아이디: <%= user.getUSER_ID() %></p>
                <p>이메일: <%= user.getEMAIL() %></p>
                <p>전화번호: <%= user.getMOBILE() %></p>
            </div>

            <!-- User update form -->
            <div class="update-form">
                <h3>회원 정보 수정</h3>
                <form action="<%= request.getContextPath() %>/auth" method="POST">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="USER_ID" value="<%= user.getUSER_ID() %>">
                    <div class="form-group">
                        <label for="USER_NAME">이름</label>
                        <input type="text" id="USER_NAME" name="USER_NAME" value="<%= user.getUSER_NAME() %>" required>
                    </div>
                    <div class="form-group">
                        <label for="EMAIL">이메일</label>
                        <input type="email" id="EMAIL" name="EMAIL" value="<%= user.getEMAIL() %>" required>
                    </div>
                    <div class="form-group">
                        <label for="MOBILE">전화번호</label>
                        <input type="tel" id="MOBILE" name="MOBILE" value="<%= user.getMOBILE() %>" required>
                    </div>
                    <div class="form-group">
                        <label for="PASSWORD">비밀번호</label>
                        <input type="password" id="PASSWORD" name="PASSWORD" placeholder="새 비밀번호를 입력하세요">
                    </div>
                    <button type="submit">정보 수정</button>
                </form>
            </div>
        </section>
    </main>

    <script>
        function logout() {
            window.location.href = "<%= request.getContextPath() %>/auth?action=logout";
        }
    </script>
</body>
</html>
