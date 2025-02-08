package com.scm.controller;

import com.scm.model.RiskDAO;
import com.scm.model.RiskDTO;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

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
            request.getRequestDispatcher("html/SecondPage.html").forward(request, response);
            return;
        }
        
        try {
            String companyCode = request.getParameter("companyCode");
            if (companyCode == null || companyCode.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "회사 코드가 필요합니다.");
                return;
            }

            // RiskDAO에서 회사 코드로 리스크 데이터를 가져오기
            List<RiskDTO> riskList = riskDAO.getRiskScoreByCompany(companyCode);

            // BigDecimal을 double로 변환하여 JSON 형태로 반환
            List<Map<String, Object>> riskData = new ArrayList<>();
            for (RiskDTO risk : riskList) {
                Map<String, Object> riskMap = new HashMap<>();
                riskMap.put("RISK_SCORE", risk.getRISK_SCORE() != null ? risk.getRISK_SCORE().doubleValue() : 0.0);
                riskMap.put("PREDICT_DATE", risk.getPREDICT_DATE());
                riskData.add(riskMap);
            }

            // JSON 변환 및 응답 설정
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            Gson gson = new Gson();
            String jsonResponse = gson.toJson(riskData);
            response.getWriter().write(jsonResponse);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "서버 오류가 발생했습니다.");
        }
    }
}
