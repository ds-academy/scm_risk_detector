package com.scm.controller;

import com.google.gson.Gson;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/fetchNews")
public class NewsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        NewsFetcher newsFetcher = new NewsFetcher();
        List<NewsFetcher.NewsData> newsList = newsFetcher.fetchNews();

        // JSON 변환
        Gson gson = new Gson();
        String newsJson = gson.toJson(newsList);

        // JSON 응답 전송
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(newsJson);
    }
}
