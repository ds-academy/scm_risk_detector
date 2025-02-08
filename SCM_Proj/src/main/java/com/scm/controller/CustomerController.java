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

@WebServlet("/auth")
public class CustomerController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CustomerDAO customerDAO = new CustomerDAO();

    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String action = request.getParameter("action");

        if ("login".equals(action)) {
            login(request, response);
        } else if ("register".equals(action)) {
            register(request, response);
        } else if ("update".equals(action)) {
            updateCustomer(request, response);
        } else if ("logout".equals(action)) {
            logout(request, response);
        }
    }

    // 로그인 처리
    private void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("USER_ID");
        String password = request.getParameter("PASSWORD");

        if (userId == null || userId.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("loginError", "아이디 또는 비밀번호를 입력하세요.");
            request.getRequestDispatcher("/jsp/Login.jsp").forward(request, response);
            return;
        }

        CustomerDTO dto = new CustomerDTO();
        dto.setUSER_ID(userId);
        dto.setPASSWORD(password);

        CustomerDTO loggedInUser = customerDAO.login(dto);

        if (loggedInUser != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", loggedInUser);
            response.sendRedirect(request.getContextPath() + "/jsp/secondPage.jsp"); 
        } else {
            request.setAttribute("loginError", "로그인 실패: 아이디 또는 비밀번호가 틀립니다.");
            request.getRequestDispatcher("/jsp/Login.jsp").forward(request, response);
        }
    }

    // 회원가입 처리
    private void register(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("USER_ID");
        String userName = request.getParameter("USER_NAME");
        String password = request.getParameter("PASSWORD");
        String mobile = request.getParameter("MOBILE");
        String email = request.getParameter("EMAIL");

        if (userId == null || userId.trim().isEmpty() || userName == null || userName.trim().isEmpty() ||
            password == null || password.trim().isEmpty() || mobile == null || mobile.trim().isEmpty() ||
            email == null || email.trim().isEmpty()) {
            request.setAttribute("registerError", "모든 필드를 입력하세요.");
            request.getRequestDispatcher("/jsp/Login.jsp").forward(request, response);
            return;
        }

        CustomerDTO dto = new CustomerDTO(userId, userName, password, mobile, email);
        boolean isRegistered = customerDAO.register(dto);

        if (isRegistered) {
            response.sendRedirect(request.getContextPath() + "/jsp/Login.jsp?success=registered");
        } else {
            request.setAttribute("registerError", "회원가입 실패: 아이디가 중복되었습니다.");
            request.getRequestDispatcher("/jsp/Login.jsp").forward(request, response);
        }
    }

    // 회원 정보 업데이트 처리
    private void updateCustomer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        CustomerDTO loggedInUser = (CustomerDTO) session.getAttribute("user");

        if (loggedInUser == null) {
            response.sendRedirect(request.getContextPath() + "/jsp/Login.jsp");
            return;
        }

        String userId = loggedInUser.getUSER_ID();
        String userName = request.getParameter("USER_NAME");
        String password = request.getParameter("PASSWORD");
        String mobile = request.getParameter("MOBILE");
        String email = request.getParameter("EMAIL");

        if (userName == null || userName.trim().isEmpty() || password == null || password.trim().isEmpty() ||
            mobile == null || mobile.trim().isEmpty() || email == null || email.trim().isEmpty()) {
            request.setAttribute("updateError", "모든 필드를 입력하세요.");
            request.getRequestDispatcher("/jsp/Mypage.jsp").forward(request, response);
            return;
        }

        CustomerDTO dto = new CustomerDTO(userId, userName, password, mobile, email);
        boolean isUpdated = customerDAO.updateCustomer(dto);

        if (isUpdated) {
            session.setAttribute("user", dto);
            response.sendRedirect(request.getContextPath() + "/jsp/Mypage.jsp?success=updated");
        } else {
            request.setAttribute("updateError", "업데이트 실패: 다시 시도해주세요.");
            request.getRequestDispatcher("/jsp/Mypage.jsp").forward(request, response);
        }
    }

    // 로그아웃 처리
    private void logout(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        session.invalidate();
        response.sendRedirect(request.getContextPath() + "/jsp/Login.jsp");
    }
}
