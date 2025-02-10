package com.scm.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

public class StockDAO {
    private SqlSessionFactory sqlSessionFactory;

    public StockDAO(SqlSessionFactory sqlSessionFactory) {
        this.sqlSessionFactory = sqlSessionFactory;
    }

    // 회사 코드로 주식 정보 조회 (단일 결과 반환)
    public StockDTO getStockInfoByCompany(String companyCode) {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            return session.selectOne("com.scm.db.StockMapper.getStockInfoByCompany", companyCode);  // 네임스페이스 확인
        }
    }

    // 기존 메서드들 (예: 코스피 종가 조회 등)
    public double getKospiClose() {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            return session.selectOne("getKospiClose");
        }
    }

    public double getKosdaqClose() {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            return session.selectOne("getKosdaqClose");
        }
    }

    public double getSP500Close() {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            return session.selectOne("getSP500Close");
        }
    }

    public List<StockDTO> getKospiIndex() {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            return session.selectList("getKospiIndex");
        }
    }

    public List<StockDTO> getKospiVolume() {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            return session.selectList("getKospiVolume");
        }
    }

    public List<StockDTO> getClosePriceByCompany(String companyCode) {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            return session.selectList("getClosePriceByCompany", companyCode);
        }
    }
}
