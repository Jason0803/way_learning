package com.way.learning.service.board.tech;


import java.sql.SQLException;

import java.util.List;


import org.springframework.stereotype.Service;


import com.way.learning.model.board.tech.vo.TechBoard;



@Service
public interface TechBoardService {
	
	
	
	public void write(TechBoard bvo)throws SQLException;
	
	public List<TechBoard> getBoardList(String Pageno,  String keyword) throws SQLException;
	
	public List getTagList() throws SQLException;
	//showContent
	public TechBoard showContent(String no) throws SQLException;
		
	//deleteBoard
	public void deleteBoard(String no) throws SQLException;
	
	//updateCount
	public void updateCount(String no) throws SQLException;
	
	//updateBoard
	public void updateBoard(TechBoard vo) throws SQLException;
	
	
	
	public int countArticle(String keyword) throws SQLException ;
	
	
		
	
}














