package com.scm.controller;

import com.scm.model.NewsDAO;
import com.scm.model.NewsDTO;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/newsController")
public class NewsController extends HttpServlet {
   private NewsDAO newsDAO;

   @Override
   public void init() throws ServletException {
       try {
           newsDAO = new NewsDAO();
       } catch (Exception e) {
           throw new ServletException("DAO 초기화 실패", e);
       }
   }

   @Override
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       try {
           request.setCharacterEncoding("UTF-8");
           response.setCharacterEncoding("UTF-8");
           response.setContentType("application/json; charset=UTF-8");
           
           String action = request.getParameter("action");
           PrintWriter out = response.getWriter();
           Gson gson = new Gson();

           if ("getPositiveNews".equals(action)) {
               List<NewsDTO> allPositiveNews = newsDAO.getPositiveNews();
               String jsonResponse = gson.toJson(allPositiveNews);
               out.print(jsonResponse);
           } 
           else if ("getNegativeNews".equals(action)) {  // 이 부분 확인
               List<NewsDTO> allNegativeNews = newsDAO.getNegativeNews();
               String jsonResponse = gson.toJson(allNegativeNews);
               out.print(jsonResponse);
           }
           
           out.flush();
       } catch (Exception e) {
           e.printStackTrace();
           response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
           response.getWriter().write("{\"error\": \"" + e.getMessage() + "\"}");
       }
   }

   private int getIntParameter(HttpServletRequest request, String paramName, int defaultValue) {
       String param = request.getParameter(paramName);
       if (param != null && !param.trim().isEmpty()) {
           try {
               int value = Integer.parseInt(param);
               return value > 0 ? value : defaultValue;
           } catch (NumberFormatException e) {
               return defaultValue;
           }
       }
       return defaultValue;
   }
}