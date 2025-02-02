package com.smhrd.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.smhrd.model.MessageDAO;
import com.smhrd.model.MessageDTO;

@WebServlet("/MessageService")
public class MessageService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. 한글 인코딩
		request.setCharacterEncoding("UTF-8");
		
		// 2. 요청으로부터 데이터 꺼내오기 -> 3개의 데이터 꺼내오기
		String sendName = request.getParameter("sendName");
		String receiveName = request.getParameter("receiveName");
		String message = request.getParameter("message");		
		
		System.out.println(sendName);
		System.out.println(receiveName);
		System.out.println(message);
		
		// 3. 데이터 처리하기 -> DB 전달
		MessageDTO dto = new MessageDTO();
		dto.setSendName(sendName);
		dto.setReceiveName(receiveName);
		dto.setMessage(message);
		
		MessageDAO dao = new MessageDAO();
		int result = dao.insertMessage(dto);
		
		// 4. 결과에 따른 화면 출력 작업
		RequestDispatcher rd = request.getRequestDispatcher("main.jsp");
		rd.forward(request, response);
	}

}
