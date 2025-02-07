package com.scm.controller;

import com.scm.db.SqlSessionManager;
import com.scm.model.StockDAO;
import com.scm.model.StockDTO;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/stocks")
public class StockController extends HttpServlet {
    private StockDAO stockDAO;
    private SqlSessionFactory sessionFactory = SqlSessionManager.getSqlSession();
	
//    @Override
//    public void init() throws ServletException {
//        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(
//            getServletContext().getResourceAsStream("/WEB-INF/mybatis-config.xml")
//        );
//        stockDAO = new StockDAO(sqlSessionFactory);
//    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
    	stockDAO = new StockDAO(sessionFactory);
    	String companyCode = request.getParameter("companyCode");

        if (companyCode == null || companyCode.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "회사 코드가 필요합니다.");
            return;
        }

        List<StockDTO> closePrices = stockDAO.getClosePriceByCompany(companyCode);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        Gson gson = new Gson();
        String jsonResponse = gson.toJson(closePrices);
        response.getWriter().write(jsonResponse);
    }
}
