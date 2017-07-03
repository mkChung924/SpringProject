package com.brothersplant.service;

import java.util.List;
import java.util.Map;

import com.brothersplant.domain.BoardListVO;
import com.brothersplant.domain.BoardVO;
import com.brothersplant.domain.CategoryInfoVO;

public interface BoardInfoService {
	
	public void insertBoard(BoardVO board) throws Exception;
	
	public List<String> selectDo() throws Exception;
	public List<String> selectSi(String do1) throws Exception;
	
	public List<Map<String, Object>> selectMainCategory() throws Exception;
	public List<Map<String, Object>> selectSubCategory(int cno) throws Exception;
	public Map<String,String> selectCategory(int csno) throws Exception;
	
	public BoardVO selectCommonRow(int tbno) throws Exception;
	
	// 관심 게시판 검색
	public List<BoardListVO> selectMyInterestList(CategoryInfoVO vo) throws Exception;

}
