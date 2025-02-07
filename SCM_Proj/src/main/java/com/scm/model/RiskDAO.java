package com.scm.model;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import java.util.List;

public class RiskDAO {
    private final SqlSessionFactory sqlSessionFactory;

    public RiskDAO(SqlSessionFactory sqlSessionFactory) {
        this.sqlSessionFactory = sqlSessionFactory;
    }

    // 회사 코드로 위험도 데이터 조회
    public List<RiskDTO> getRiskScoreByCompany(String companyCode) {
        int retryCount = 3;
        while (retryCount > 0) {
            try (SqlSession session = sqlSessionFactory.openSession()) {
                return session.selectList("com.scm.db.RiskMapper.getRiskByCompany", companyCode);
            } catch (Exception e) {
                e.printStackTrace();
                retryCount--;
                if (retryCount == 0) {
                    throw new RuntimeException("데이터베이스 연결 실패: " + e.getMessage());
                }
            }
        }
        return null;
    }

}
