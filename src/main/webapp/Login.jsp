<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>도서관리 프로그램 - 로그인</title>
</head>
<body>
    <h2>도서관리 프로그램</h2>
    <form action="LoginCon" method="post">
        <label for="id">아이디:</label>
        <input type="text" id="id" name="id" required>
        <br>
        <label for="pw">비밀번호:</label>
        <input type="password" id="pw" name="pw" required>
        <br>
        <button type="submit">로그인</button>
    </form>
    <br>
    <a href="Join.jsp">회원가입</a>
</body>
</html>
