package com.scm.controller;

import com.google.gson.Gson;
import com.scm.model.StockDAO;
import com.scm.model.StockDTO;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/getKospiIndex")
public class StockServlet extends HttpServlet {
    private StockDAO stockDAO;

    @Override
    public void init() throws ServletException {
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder()
            .build(getServletContext().getResourceAsStream("/WEB-INF/mybatis-config.xml"));
        stockDAO = new StockDAO(sqlSessionFactory);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<StockDTO> kospiData = stockDAO.getKospiIndex();

        response.setContentType("application/json; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        String json = new Gson().toJson(kospiData);
        response.getWriter().write(json);
    }
}
