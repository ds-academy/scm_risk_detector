package com.scm.model;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import java.util.List;

public class RiskDAO {
    private final SqlSessionFactory sqlSessionFactory;

    public RiskDAO(SqlSessionFactory sqlSessionFactory) {
        this.sqlSessionFactory = sqlSessionFactory;
    }

    // 회사 코드로 리스크 데이터 가져오기
    public List<RiskDTO> getRiskScoreByCompany(String companyCode) {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            return session.selectList("com.scm.db.RiskMapper.getRiskByCompany", companyCode);
        }
    }
}
