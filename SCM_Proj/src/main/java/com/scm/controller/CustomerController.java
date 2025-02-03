package com.scm.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.scm.model.CustomerDAO;
import com.scm.model.CustomerDTO;

@WebServlet("/CustomerController")
public class CustomerController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CustomerDAO customerDAO = new CustomerDAO();
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String action = request.getParameter("action");
		
		if("login".equals(action)) {
			login(request, response);
		} else if("register".equals(action)) {
			register(request, response);
		}
	}
	
	// 로그인 처리
	private void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userId = request.getParameter("USER_ID");
		String password = request.getParameter("PASSWORD");
		
		// 입력값 검증
		if (userId == null || userId.trim().isEmpty() || password == null || password.trim().isEmpty()) {
			response.sendRedirect("login.jsp?error=empty");
			return;
		}
		
		// DTO 객체 생성 후 로그인 시도
		CustomerDTO dto = new CustomerDTO();
		dto.setUSER_ID(userId);
        dto.setPASSWORD(password);

        CustomerDTO loggedInUser = customerDAO.login(dto);

        if (loggedInUser != null) {
            HttpSession session = request.getSession();
            session.setAttribute("loginUser", loggedInUser);
            response.sendRedirect("home.jsp"); // 로그인 성공 시 홈으로 이동
            System.out.println("로그인 성공!");
        } else {
            System.out.println("로그인 실패");
            response.sendRedirect("login.jsp?error=invalid");
        }
    }

    // 회원가입 처리
    private void register(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("USER_ID");
        String userName = request.getParameter("USER_NAME");
        String password = request.getParameter("PASSWORD");
        String mobile = request.getParameter("MOBILE");
        String email = request.getParameter("EMAIL");

        // 입력값 검증
        if (userId == null || userId.trim().isEmpty() || userName == null || userName.trim().isEmpty() ||
            password == null || password.trim().isEmpty() || mobile == null || mobile.trim().isEmpty() ||
            email == null || email.trim().isEmpty()) {
            response.sendRedirect("login.jsp?error=empty");
            return;
        }

        // DTO 객체 생성 후 회원가입 시도
        CustomerDTO dto = new CustomerDTO(userId, userName, password, mobile, email);
        boolean isRegistered = customerDAO.register(dto);

        if (isRegistered) {
            response.sendRedirect("login.jsp?success=registered"); // 회원가입 성공 시 로그인 페이지로 이동
            System.out.println("회원가입 성공!");
        } else {
            System.out.println("회원가입 실패");
            response.sendRedirect("login.jsp?error=exists");
        }
	}
	

}
