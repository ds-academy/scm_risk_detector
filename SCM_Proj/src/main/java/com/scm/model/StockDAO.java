package com.scm.model;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

public class StockDAO {
    private final SqlSessionFactory sqlSessionFactory;

    public StockDAO(SqlSessionFactory sqlSessionFactory) {
        this.sqlSessionFactory = sqlSessionFactory;
    }

    // 회사 코드로 주식 종가 데이터 조회
    public List<StockDTO> getClosePriceByCompany(String companyCode) {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            return session.selectList("com.scm.db.StockMapper.getClosePriceByCompany", companyCode);
        }
    }
    
 // 코스피 CLOSE 값 조회
    public double getKospiClose() {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            return session.selectOne("com.scm.db.StockMapper.getKospiClose");  
        }
    }

    // 코스닥 CLOSE 값 조회
    public double getKosdaqClose() {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            return session.selectOne("com.scm.db.StockMapper.getKosdaqClose"); 
        }
    }

    // S&P 500 CLOSE 값 조회
    public double getSP500Close() {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            return session.selectOne("com.scm.db.StockMapper.getSP500Close"); 
        }
    }
    
    // 코스피 지수 최근 7일 CLOSE 값과 DATE 조회
    public List<StockDTO> getKospiIndex() {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            return session.selectList("com.scm.db.StockMapper.getKospiIndex");
        }
    }

    // 코스피 거래량 최근 7일 VOLUME 값과 DATE 조회
    public List<StockDTO> getKospiVolume() {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            return session.selectList("com.scm.db.StockMapper.getKospiVolume");
        }
    }
    
}
