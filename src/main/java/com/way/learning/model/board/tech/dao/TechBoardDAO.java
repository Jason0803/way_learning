package com.way.learning.model.board.tech.dao;

import java.sql.SQLException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.way.learning.model.board.tech.vo.TechBoard;




public interface TechBoardDAO {

	

	
	public int write(TechBoard bvo)throws SQLException;
	
	//selectByNoForDate
	public Date selectByNoForDate(int no) throws SQLException;
	//getBoardList
	public List<TechBoard> getBoardList(String no,String search_option, String keyword) throws SQLException;
	
	//showContent
	public TechBoard showContent(String no) throws SQLException;
	//deleteBoard
	public void deleteBoard(String no) throws SQLException;
	//updateCount
	public void updateCount(String no) throws SQLException;
	
	//updateBoard
	public void updateBoard(TechBoard vo) throws SQLException;
	
	//페이징 처리 추가...
	public int totalCount() throws SQLException;

	
	public int countArticle(String search_option, String keyword)throws SQLException;
		
	
	
}




















