package com.scm.controller;

import com.scm.db.SqlSessionManager;
import com.scm.model.StockDAO;
import com.scm.model.StockDTO;
import org.apache.ibatis.session.SqlSessionFactory;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        stockDAO = new StockDAO(sessionFactory);
        String action = request.getParameter("action");
        String companyCode = request.getParameter("companyCode");

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        Gson gson = new Gson();

        try {
            if (action != null) {
                switch (action) {
                    case "kospiClose":
                        System.out.println("Fetching Kospi Close...");
                        double kospiClose = stockDAO.getKospiClose();
                        response.getWriter().write(gson.toJson(kospiClose));
                        break;

                    case "kosdaqClose":
                        System.out.println("Fetching Kosdaq Close...");
                        double kosdaqClose = stockDAO.getKosdaqClose();
                        response.getWriter().write(gson.toJson(kosdaqClose));
                        break;

                    case "sp500Close":
                        System.out.println("Fetching SP500 Close...");
                        double sp500Close = stockDAO.getSP500Close();
                        response.getWriter().write(gson.toJson(sp500Close));
                        break;

                    case "kospiIndex":
                        List<StockDTO> kospiIndexData = stockDAO.getKospiIndex();
                        response.getWriter().write(gson.toJson(kospiIndexData));
                        break;

                    case "kospiVolume":
                        List<StockDTO> kospiVolumeData = stockDAO.getKospiVolume();
                        response.getWriter().write(gson.toJson(kospiVolumeData));
                        break;

                    case "getStockInfo":
                        if (companyCode != null && !companyCode.isEmpty()) {
                            StockDTO stockInfo = stockDAO.getStockInfoByCompany(companyCode);

                            // 반환된 객체 확인
                            System.out.println("쿼리 결과: " + stockInfo);

                            if (stockInfo != null) {
                                JsonObject jsonResponse = new JsonObject();
                                jsonResponse.addProperty("COMPANY_NAME", stockInfo.getCompanyName());
                                jsonResponse.addProperty("CURRENT_CLOSE", stockInfo.getCurrentClose());
                                jsonResponse.addProperty("PERCENT_CHANGE", stockInfo.getPercentChange());

                                System.out.println("서버 응답 데이터: " + gson.toJson(jsonResponse));  // 서버 응답 데이터 확인
                                response.getWriter().write(gson.toJson(jsonResponse));
                            } else {
                                System.out.println("서버 응답: No stock info available for the company.");  // Null일 때
                                response.getWriter().write(gson.toJson("No stock info available for the company."));
                            }
                        } else {
                            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "companyCode parameter is required.");
                        }
                        break;



                    default:
                        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action parameter.");
                        System.out.println("Invalid action parameter: " + action);
                }
            } else if (companyCode != null && !companyCode.isEmpty()) {
                System.out.println("Fetching stock data for company code: " + companyCode);
                List<StockDTO> stockData = stockDAO.getClosePriceByCompany(companyCode);

                if (stockData.isEmpty()) {
                    response.getWriter().write(gson.toJson("No stock data available."));
                    System.out.println("No stock data found for company code: " + companyCode);
                } else {
                    response.getWriter().write(gson.toJson(stockData));
                }
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action or companyCode parameter required.");
                System.out.println("Action and companyCode parameters missing.");
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write(gson.toJson("Server Error: " + e.getMessage()));
            e.printStackTrace();
        }
    }
}
