<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>도서관리 프로그램 - 회원가입</title>
</head>
<body>
    <h2>회원가입</h2>
    <form action="JoinCon" method="post">
        <label for="id">id:</label>
        <input type="text" id="id" name="id" required>
        <br>
        <label for="pw">pw:</label>
        <input type="password" id="pw" name="pw" required>
        <br>
        <label for="nick">nickname:</label>
        <input type="text" id="nick" name="nick" required>
        <br>
        <label for="email">email:</label>
        <input type="email" id="email" name="email">
        <br>
        <label for="tel">tbl:</label>
        <input type="tel" id="tel" name="tel">
        <br>
        <button type="submit">가입</button>
    </form>
    <br>
    <a href="Login.jsp">로그인</a>
</body>
</html>
