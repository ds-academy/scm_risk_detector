package com.scm.model;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.scm.db.SqlSessionManager;

public class CustomerDAO {

	private SqlSessionFactory sessionFactory = SqlSessionManager.getSqlSession();
	
	
	// 로그인 메소드
	public CustomerDTO login(CustomerDTO dto) {
		try(SqlSession session = sessionFactory.openSession()){
			return session.selectOne("com.scm.db.CustomerMapper.login", dto);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}
