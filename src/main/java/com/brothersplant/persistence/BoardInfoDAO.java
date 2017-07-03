package com.brothersplant.persistence;

import java.util.List;

import com.brothersplant.domain.BoardVO;

public interface BoardInfoDAO {
	public void insertBoard(BoardVO board) throws Exception;
	
	public List<String> selectDo() throws Exception;
	public List<String> selectSi(String do1) throws Exception;
	
	public List<String> selectMainCategory() throws Exception;
	public List<String> selectSubCategory(int cno) throws Exception;
	
	public BoardVO selectCommonRow(int tbno) throws Exception;
}


