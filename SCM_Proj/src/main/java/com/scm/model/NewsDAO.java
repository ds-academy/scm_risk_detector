package com.scm.model;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import java.util.List;

public class NewsDAO {
    private SqlSessionFactory sqlSessionFactory;

    public NewsDAO() {
        sqlSessionFactory = MyBatisUtil.getSqlSessionFactory(); // MyBatis 유틸리티 클래스 사용
    }

    public List<NewsDTO> getPositiveNews() {	
        try (SqlSession session = sqlSessionFactory.openSession()) {
            return session.selectList("com.scm.db.NewsMapper.getPositiveNews");
        }
    }

    public List<NewsDTO> getNegativeNews() {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            return session.selectList("com.scm.db.NewsMapper.getNegativeNews");
        }
    }
}