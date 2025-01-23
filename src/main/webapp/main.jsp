<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>메인 페이지</title>
</head>
<body>
    <h2>빅데이터 과정 회원 시스템</h2>
    <%
      
        HttpSession session2 = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("loginForm.html");
            return;
        }
        String username = (String) session.getAttribute("username");
    %>
    <p>환영합니다, <%= username %>님!</p>
    <form action="Logout" method="post">
        <button type="submit">로그아웃</button>
    </form>
</body>
</html>
