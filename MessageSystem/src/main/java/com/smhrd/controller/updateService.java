package com.smhrd.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.smhrd.model.MemberDAO;
import com.smhrd.model.MemberDTO;

@WebServlet("/update")
public class updateService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// dao가 가진 update 메소드 만들기
		// 0. 한글인코딩(post방식이기 때문에)
		request.setCharacterEncoding("UTF-8");
		
		// 1. 받아온 데이터(요청 데이터) 꺼내기(pw, tel, address)
		// email은 어디서 가지고 올 수 있을까? => session
		HttpSession session = request.getSession();
		
		MemberDTO user = (MemberDTO)session.getAttribute("result");
		
	    String email = user.getEmail();
	    String pw = request.getParameter("pw");
	    String tel = request.getParameter("tel");
	    String address = request.getParameter("address");
	      
	    // 2. 요청받은 데이터를 다른 클래스 파일로 넘겨줄 수 있게 
	    //     하나로 묶어주는 작업 => MemberDTO타입으로!
	    MemberDTO dto = new MemberDTO(email, pw, tel, address);
	    // dao가 가진 update 메소드 실행
	    MemberDAO dao = new MemberDAO();
	    
	    int result = dao.update(dto);
	    MemberDTO sendDTO = new MemberDTO(email, tel, address);
	      
	    // update WEB_MEMBER set pw =?, tel=?, address=?
	    // 조건에 맞게 처리	    	    
	    // 3. 결과에 따른 페이지 이동!
	      if(result > 0) {
	    	  // 성공! 바뀐 회원의 정보를 화면에 출력 -> session "result"
	    	  // 공유하고자 하는 데이터를 session에 저장!
	    	  session.setAttribute("result", sendDTO);
	    	  
//	          RequestDispatcher rd = request.getRequestDispatcher("update.jsp");
//	          rd.forward(request, response);

	          // main.jsp -> forward -> request, response 객체를 전달하고자 할 때
	          // sendRedirect
	    	  response.sendRedirect("main.jsp");
	      }else {
	    	  // 실패 => 리다이렉트 방식으로 페이지 이동!
	    	  response.sendRedirect("update.jsp");
	      }
	      
	}

}
