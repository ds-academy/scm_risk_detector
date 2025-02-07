package com.scm.controller;

import com.scm.model.RiskDAO;
import com.scm.model.RiskDTO;
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

@WebServlet("/risk")  // 변경: /RiskController → /risk
public class RiskController extends HttpServlet {
    private RiskDAO riskDAO;

    @Override
    public void init() throws ServletException {
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(
            getServletContext().getResourceAsStream("/WEB-INF/mybatis-config.xml")
        );
        riskDAO = new RiskDAO(sqlSessionFactory);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String companyCode = request.getParameter("companyCode");

        if (companyCode == null || companyCode.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "회사 코드가 필요합니다.");
            return;
        }

        try {
            List<RiskDTO> riskScores = riskDAO.getRiskScoreByCompany(companyCode);

            if (riskScores == null || riskScores.isEmpty()) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "해당 회사의 리스크 데이터가 없습니다.");
                return;
            }

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
