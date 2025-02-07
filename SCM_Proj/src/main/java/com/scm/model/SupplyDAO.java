package com.scm.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

public class SupplyDAO {
	private SqlSessionFactory sqlSessionFactory;
	
	public SupplyDAO(SqlSessionFactory sqlSessionFactory) {
		this.sqlSessionFactory = sqlSessionFactory;
	}
	
	public List<SupplyDTO> getAllSupplies(){
		try (SqlSession session = sqlSessionFactory.openSession()){
			return session.selectList("com.scm.model.SupplyMapper.getAllSupplies");
		}
	}
}
