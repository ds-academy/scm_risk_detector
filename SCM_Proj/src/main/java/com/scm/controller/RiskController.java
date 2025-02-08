package com.scm.controller;

import com.scm.model.RiskDAO;
import com.scm.model.RiskDTO;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.apache.ibatis.session.SqlSessionManager;

import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

@WebServlet(urlPatterns = {"/risk", "/risk-page"})
public class RiskController extends HttpServlet {
    private RiskDAO riskDAO;

    @Override
    public void init() throws ServletException {
        try {
            String resource = "com/scm/db/mybatis-config.xml";
            InputStream inputStream = Resources.getResourceAsStream(resource);
            SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
            riskDAO = new RiskDAO(sqlSessionFactory);
        } catch (Exception e) {
            throw new ServletException("DB 초기화 중 오류 발생", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String pathInfo = request.getServletPath();
        
        if ("/risk-page".equals(pathInfo)) {
            request.getRequestDispatcher("/html/SecondPage.html").forward(request, response);
            return;
        }
        
        try {
            String companyCode = request.getParameter("companyCode");
            if (companyCode == null || companyCode.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "회사 코드가 필요합니다.");
                return;
            }

            List<RiskDTO> riskScores = riskDAO.getRiskScoreByCompany(companyCode);
            
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            
            Gson gson = new Gson();
            String jsonResponse = gson.toJson(riskScores);
            response.getWriter().write(jsonResponse);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "서버 오류가 발생했습니다.");
        }
    }
}