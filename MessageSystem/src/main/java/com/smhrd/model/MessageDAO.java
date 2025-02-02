package com.smhrd.model;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.smhrd.db.SqlSessionManager;

public class MessageDAO {
	
	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();
	
	// 메세지 전송을 위한 기능!
	public int insertMessage(MessageDTO dto) {
		
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		
		int cnt = sqlSession.insert("insertMessage", dto);
		
		sqlSession.close();
		
		return cnt;
	}
	
	// 전체 메세지를 저장하기 위한 ArrayList 생성
	ArrayList<MessageDTO> list = new ArrayList<>();
	
	// 메세지를 보여오기 위한 기능!
	public ArrayList<MessageDTO> showMessage(String email) {
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		
		list = (ArrayList)sqlSession.selectList("showMessage", email);
		
		sqlSession.close();
		
		return list;
	}

}
