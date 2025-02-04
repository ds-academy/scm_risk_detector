<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.scm.model.CustomerDAO" %>
<%@ page import="com.scm.model.CustomerDTO" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
</head>
<body>
    <%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            try {
                String userId = request.getParameter("USER_ID");
                String userName = request.getParameter("USER_NAME");
                String password = request.getParameter("PASSWORD");
                String mobile = request.getParameter("MOBILE");
                String email = request.getParameter("EMAIL");

                // DAO 객체 생성
                CustomerDAO dao = new CustomerDAO();
                CustomerDTO dto = new CustomerDTO(userId, userName, password, mobile, email);

                boolean isRegistered = dao.register(dto);

                if (isRegistered) {
                    response.sendRedirect("login.jsp");
                } else {
                    out.println("<script>alert('회원가입 실패!'); history.back();</script>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<script>alert('서버 오류 발생: " + e.getMessage() + "'); history.back();</script>");
            }
        }
    %>

    <h2>회원가입</h2>
    <form method="post">
        ID: <input type="text" name="USER_ID" required><br>
        이름: <input type="text" name="USER_NAME" required><br>
        비밀번호: <input type="password" name="PASSWORD" required><br>
        핸드폰: <input type="text" name="MOBILE" required><br>
        이메일: <input type="email" name="EMAIL" required><br>
        <input type="submit" value="회원가입">
    </form>
</body>
</html>
