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
	
	// 회원가입
	public boolean register(CustomerDTO dto) {
		try(SqlSession session = sessionFactory.openSession()){
			int result = session.insert("com.scm.db.CustomerMapper.register", dto);
			session.commit();
			return result > 0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
}
