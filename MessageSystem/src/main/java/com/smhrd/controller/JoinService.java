package com.smhrd.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.smhrd.model.MemberDAO;
import com.smhrd.model.MemberDTO;


@WebServlet("/Join")
public class JoinService extends HttpServlet {
   private static final long serialVersionUID = 1L;

   // main 페이지로 부터 넘어온 회원가입의 데이터를 
   // 데이터베이스로 넘겨 회원가입 기능을 처리하는 Servlet!   
   
   protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      // 0. 한글인코딩(post방식이기 때문에)      
      request.setCharacterEncoding("UTF-8");
      
      // 1. 받아온 데이터(요청 데이터) 꺼내기
      String email = request.getParameter("email");
      String pw = request.getParameter("pw");
      String tel = request.getParameter("tel");
      String address = request.getParameter("address");
      
      // 2. 요청받은 데이터를 다른 클래스 파일로 넘겨줄 수 있게 
      //     하나로 묶어주는 작업 => MemberDTO타입으로!
      MemberDTO dto = new MemberDTO();
      dto.setEmail(email);
      dto.setPw(pw);
      dto.setTel(tel);
      dto.setAddress(address);
      
      // 3. 데이터베이스에 해당 내용 전달하기
      MemberDAO dao = new MemberDAO();
      int result = dao.join(dto);
      
      // 4. 결과에 따른 페이지 이동!
      if(result > 0) {
    	  // 회원가입 성공 -> join_sucess.jsp 이동
    	  // => 페이지 이동시 회원가입 성공의 email 가지고 페이지 이동을 해야한다!
    	  // => 포워딩 방식으로 페이지 이동!
    	  
    	  // 공유하고자 하는 데이터를 session에 저장!
    	  HttpSession session = request.getSession();
    	  session.setAttribute("email", email);
    	  
          RequestDispatcher rd = request.getRequestDispatcher("join_success.jsp");
          rd.forward(request, response);

    	  response.sendRedirect("join_sucess.jsp");
      }else {
    	  // 회원가입 실패 -> main.jsp 이동
    	  // => 리다이렉트 방식으로 페이지 이동!
    	  response.sendRedirect("main.jsp");
      }
   }

}
