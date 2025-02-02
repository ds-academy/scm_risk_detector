package com.smhrd.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;

@WebServlet("/Logout")
public class LogoutService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. session 꺼내기
		HttpSession session = request.getSession();		
		
		// 2. session 무효화 시켜주기(모든 데이터 지우기)
		session.invalidate();
		
		// 3. main.jsp로 redirect방식으로 이동
		response.sendRedirect("main.jsp");
		
	}

}
