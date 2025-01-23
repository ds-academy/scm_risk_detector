<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>도서관리 프로그램 - 메인</title>
</head>
<body>
    <h2>도서관리 프로그램</h2>
    <%
        HttpSession session2 = request.getSession(false);
        if (session == null || session.getAttribute("nickname") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
        String nickname = (String) session.getAttribute("nickname");
    %>
    <p><%= nickname %>님 환영합니다!</p>
    <%
        if ("admin".equals(session.getAttribute("id"))) {
    %>
        <button onclick="href='manageBooks.jsp'">도서관리</button>
        <button onclick="href='manageMembers.jsp'">회원관리</button>
    <%
        }
    %>
    <a href="LogoutCon">로그아웃</a>
</body>
</html>
