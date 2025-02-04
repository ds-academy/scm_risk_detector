package com.scm.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

public class StockDAO {
	private final SqlSessionFactory sqlSessionFactory;

    // DAO 생성자에서 MyBatis 세션 팩토리 주입
    public StockDAO(SqlSessionFactory sqlSessionFactory) {
        this.sqlSessionFactory = sqlSessionFactory;
    }

    // ✅ 특정 회사 코드의 모든 주가 데이터 조회 (최신순 정렬)
    public List<StockDTO> getStockByCompany(String companyCode) {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            return session.selectList("com.scm.db.StockMapper.getStockByCompany", companyCode);
        }
    }

    // ✅ 특정 날짜의 주가 데이터 조회
    public StockDTO getStockByDate(String companyCode, String date) {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            Map<String, Object> params = new HashMap<>();
            params.put("COMPANY_CODE", companyCode);
            params.put("DATE", date);
            return session.selectOne("com.scm.db.StockMapper.getStockByDate", params);
        }
    }
}
