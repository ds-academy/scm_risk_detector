<%@page import="com.smhrd.model.MemberDTO"%>
<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@ page import="com.smhrd.model.MessageDTO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.smhrd.model.MessageDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
   <head>
      <title>Forty by HTML5 UP</title>
      <meta charset="UTF-8" />
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <link rel="stylesheet" href="assets/css/main.css" />
   </head>
   <body>

      <!-- Wrapper -->
         <div id="wrapper">

            <!-- Header -->
               <header id="header" class="alt">
                  <a href="index.html" class="logo"><strong>Forty</strong> <span>by HTML5 UP</span></a>
                  
                  <!-- 로그인에 성공했다면 로그아웃 버튼과 개인정보 수정 버튼 보여주기
                  	   로그인에 실패했다면 로그인버튼 보여주기 -->
                  <nav>
                  <c:if test="${result == null}">
                        <a href="#menu">로그인</a>
                  </c:if>
                  <c:if test="${result != null}">
                  		<c:if test="${result.email != 'admin'}">
                        	<a href="update.jsp">개인정보수정</a>
                        </c:if>
                        <c:if test="${result.email == 'admin'}">
                        	<a href="SelectAll">전체회원조회</a>
                        </c:if>
                        <a href="Logout">로그아웃</a>
                  </c:if>
                  </nav>
               </header>

            <!-- Menu -->
               <nav id="menu">   
                  <ul class="links">
                     <li><h5>로그인</h5></li>
                        <form action="Login" method="post">
                           <li><input type="text" name="email" placeholder="Email을 입력하세요"></li>
                           <li><input type="password" name="pw" placeholder="PW를 입력하세요"></li>
                           <li><input type="submit" value="LogIn" class="button fit"></li>
                        </form>
                  </ul>
                  <ul class="actions vertical">
                     <li><h5>회원가입</h5></li>
                     <!-- action은 확장자가 달려있지 않으면 무조건 Servlet!!!  -->
                        <form action = "Join" method="post">
                           <li><input type="text"  placeholder="Email을 입력하세요" name ="email"></li>
                           <li><input type="password"  placeholder="PW를 입력하세요" name ="pw"></li>
                           <li><input type="text"  placeholder="전화번호를 입력하세요" name="tel"></li>
                           <li><input type="text"  placeholder="집주소를 입력하세요" name = "address"></li>
                           <li><input type="submit" value="JoinUs" class="button fit"></li>
                        </form>
                  </ul>
               </nav>         
            <!-- Banner -->
               <section id="banner" class="major">
                  <div class="inner">
                     <header class="major">
                     	<c:if test="${result == null}">
                              <h1>로그인 해주세요</h1>                     	
                     	</c:if>
                     	<c:if test="${result != null}">
                              <h1>${result.email}님 환영합니다.</h1>
                     	</c:if>
                        <!-- 로그인 후 로그인 한 사용자의 세션아이디로 바꾸시오.
                            ex)smart님 환영합니다 -->
                     </header>
                     <div class="content">
                        <p>아래는 지금까지 배운 웹 기술들입니다.<br></p>
                        <ul class="actions">
                           <li><a href="#one" class="button next scrolly">확인하기</a></li>
                        </ul>
                     </div>
                  </div>
               </section>

            <!-- Main -->
               <div id="main">

                  <!-- One -->
                     <section id="one" class="tiles">
                        <article>
                           <span class="image">
                              <img src="images/pic01.jpg" alt="" />
                           </span>
                           <header class="major">
                              <h3><a href="#" class="link">HTML</a></h3>
                              <p>홈페이지를 만드는 기초 언어</p>
                           </header>
                        </article>
                        <article>
                           <span class="image">
                              <img src="images/pic02.jpg" alt="" />
                           </span>
                           <header class="major">
                              <h3><a href="#" class="link">CSS</a></h3>
                              <p>HTML을 디자인해주는 언어</p>
                           </header>
                        </article>
                        <article>
                           <span class="image">
                              <img src="images/pic03.jpg" alt="" />
                           </span>
                           <header class="major">
                              <h3><a href="#" class="link">Servlet/JSP</a></h3>
                              <p>Java를 기본으로 한 웹 프로그래밍 언어/스크립트 언어</p>
                           </header>
                        </article>
                        <article>
                           <span class="image">
                              <img src="images/pic04.jpg" alt="" />
                           </span>
                           <header class="major">
                              <h3><a href="#" class="link">JavaScript</a></h3>
                              <p>HTML에 기본적인 로직을 정의할 수 있는 언어</p>
                           </header>
                        </article>
                        <article>
                           <span class="image">
                              <img src="images/pic05.jpg" alt="" />
                           </span>
                           <header class="major">
                              <h3><a href="#" class="link">MVC</a></h3>
                              <p>웹 프로젝트 중 가장 많이 사용하는 디자인패턴</p>
                           </header>
                        </article>
                        <article>
                           <span class="image">
                              <img src="images/pic06.jpg" alt="" />
                           </span>
                           <header class="major">
                              <h3><a href="#" class="link">Web Project</a></h3>
                              <p>여러분의 최종프로젝트에 웹 기술을 활용하세요!</p>
                           </header>
                        </article>
                     </section>
               <!-- Two -->
                     <section id="two">
                        <div class="inner">
                           <header class="major">
                              <h2>나에게 온 메세지 확인하기</h2>
                           </header>
                           <p></p>
                           <ul class="actions">
                              <li>로그인을 하세요.</li>
                              <li><a href="#" class="button next scrolly">전체삭제하기</a></li>
                           </ul>
                           
                           <%
                          	// main.jsp 페이지가 실행되자 마자
                          	// MessageDAO 클래스를 통하여 showMessage() 호출!
                          	
                          	// 로그인한 사용자의 메세지만 화면에 띄우기
                          	// 0. session에서 로그인한 사용자의 email 값 가져오기                          	
                          	MemberDTO result = (MemberDTO)session.getAttribute("result");
                            ArrayList<MessageDTO> list = null;
                            if(result != null) {
                            	System.out.println("로그인한 사용자 정보 : "+result.getEmail());
                            	
	                          	// 1. MessageDAO 객체 생성 -> import 필수! ctrl+space 활용!
	                          	MessageDAO dao = new MessageDAO();
	                          	list = dao.showMessage(result.getEmail());
                            }
                          	
                           %>
                           
                           <!-- 메세지의 전체내용을 띄우는 테이블 태그 생성! -->
                           <table>
                           <!-- 각 행들의 제목이 될 수 있는 하나의 행 생성! -->
                           	<tr>
                           		<td>번호</td>
                           		<td>보낸 사람</td>
                           		<td>받는 사람</td>                           		
                           		<td>내용</td>
                           		<td>날짜</td>
                           	
                           	<% if(result != null) {
                           		  for(int i=0 ; i<list.size() ; i++) { %>                           		
		                           	</tr>
		                           		<td><%= list.get(i).getNum() %></td>
		                           		<td><%= list.get(i).getSendName() %></td>
		                           		<td><%= list.get(i).getReceiveName() %></td>
		                           		<td><%= list.get(i).getMessage() %></td>
		                           		<td><%= list.get(i).getM_date() %></td>
		                           	</tr>
                           		<%}                           	
                           	 }%>
                           </table>
                        </div>
                     </section>

               </div>

            <!-- Contact -->
               <section id="contact">
                  <div class="inner">
                     <section>
                        <form action="MessageService" method="post">
                        <div class="field half first">
                              <label for="name">Name</label>
                              <input type="text" name="sendName" id="name" placeholder="보내는 사람 이름" />
                           </div>
                           <div class="field half">
                              <label for="email">Email</label>
                              <input type="text" name="receiveName" id="email" placeholder="보낼 사람 이메일"/>
                           </div>

                           <div class="field">
                              <label for="message">Message</label>
                              <textarea name="message" id="message" rows="6"></textarea>
                           </div>
                           <ul class="actions">
                              <li><input type="submit" value="Send Message" class="special" /></li>
                              <li><input type="reset" value="Clear" /></li>
                           </ul>
                        </form>
                     </section>
                     
                     <section class="split">
                        <section>
                           <div class="contact-method">
                              <span class="icon alt fa-envelope"></span>
                              <h3>Email</h3>
                              <a href="#">${result.email}</a>
                              <!-- 로그인 한 사용자의 이메일을 출력하시오 -->
                           </div>
                        </section>
                        <section>
                           <div class="contact-method">
                              <span class="icon alt fa-phone"></span>
                              <h3>Phone</h3>
                              <span>${result.tel}</span>
                              <!-- 로그인 한 사용자의 전화번호를 출력하시오 -->
                           </div>
                        </section>
                        <section>
                           <div class="contact-method">
                              <span class="icon alt fa-home"></span>
                              <h3>Address</h3>
                              <span>${result.address}</span>
                              <!-- 로그인 한 사용자의 집주소를 출력하시오 -->
                           </div>
                        </section>
                     </section>               
                  </div>
               </section>

            <!-- Footer -->
               <footer id="footer">
                  <div class="inner">
                     <ul class="icons">
                        <li><a href="#" class="icon alt fa-twitter"><span class="label">Twitter</span></a></li>
                        <li><a href="#" class="icon alt fa-facebook"><span class="label">Facebook</span></a></li>
                        <li><a href="#" class="icon alt fa-instagram"><span class="label">Instagram</span></a></li>
                        <li><a href="#" class="icon alt fa-github"><span class="label">GitHub</span></a></li>
                        <li><a href="#" class="icon alt fa-linkedin"><span class="label">LinkedIn</span></a></li>
                     </ul>
                     <ul class="copyright">
                        <li>&copy; Untitled</li><li>Design: <a href="https://html5up.net">HTML5 UP</a></li>
                     </ul>
                  </div>
               </footer>

         </div>

      <!-- Scripts -->
         <script src="assets/js/jquery.min.js"></script>
         <script src="assets/js/jquery.scrolly.min.js"></script>
         <script src="assets/js/jquery.scrollex.min.js"></script>
         <script src="assets/js/skel.min.js"></script>
         <script src="assets/js/util.js"></script>
         <!--[if lte IE 8]><script src="assets/js/ie/respond.min.js"></script><![endif]-->
         <script src="assets/js/main.js"></script>

   </body>
</html>


