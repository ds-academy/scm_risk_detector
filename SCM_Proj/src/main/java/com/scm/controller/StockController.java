package com.scm.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.scm.model.StockDAO;
import com.scm.model.StockDTO;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

@WebServlet("/stock")
public class StockController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private StockDAO stockDAO;

    @Override
    public void init() throws ServletException {
        InputStream inputStream = getClass().getClassLoader().getResourceAsStream("mybatis-config.xml");
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
        stockDAO = new StockDAO(sqlSessionFactory);
    }

    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String companyCode = request.getParameter("companyCode");
        String date = request.getParameter("date");

        if (companyCode == null || companyCode.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Company code is required");
            return;
        }

        if (date != null && !date.isEmpty()) {
            StockDTO stock = stockDAO.getStockByDate(companyCode, date);
            request.setAttribute("stock", stock);
            request.getRequestDispatcher("stockDetail.jsp").forward(request, response);
        } else {
            List<StockDTO> stockList = stockDAO.getStockByCompany(companyCode);
            request.setAttribute("stockList", stockList);
            request.getRequestDispatcher("stockList.jsp").forward(request, response);
        }
    }
}
