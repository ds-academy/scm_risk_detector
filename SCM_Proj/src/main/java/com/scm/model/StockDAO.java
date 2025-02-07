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
}
