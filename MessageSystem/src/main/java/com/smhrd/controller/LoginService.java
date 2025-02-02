package com.smhrd.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.smhrd.model.MemberDAO;
import com.smhrd.model.MemberDTO;

@WebServlet("/Login")
public class LoginService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. 한글 인코딩
		request.setCharacterEncoding("UTF-8");
		
		// 2. 요청 데이터 꺼내오기(2개)		
		String email = request.getParameter("email");
		String pw = request.getParameter("pw");
		System.out.println("이메일:"+email);
		System.out.println("pw:"+pw);
		// 2-1. 요청 데이터 하나로 묶어주기
		MemberDTO dto = new MemberDTO();
		dto.setEmail(email);
		dto.setPw(pw);
		
		// 3. DAO 생성
		MemberDAO dao = new MemberDAO();
		
		// 4. DAO에서 로그인 메소드 호출
		MemberDTO result = dao.login(dto);
		
		// 5. 로그인에 성공했다면 email, tel, address를 session에 담기
		if (result != null) {
			// 5-1. session 꺼내기
			HttpSession session = request.getSession();			
			// 5-2. session에 데이터 담기
			session.setAttribute("result", result);
			
		}
		
		// 6. main.jsp로 이동
		response.sendRedirect("main.jsp");	
	
	}

}
