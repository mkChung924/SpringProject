package com.brothersplant.service;

import java.util.List;
import java.util.Map;

import com.brothersplant.domain.BoardListVO;
import com.brothersplant.domain.BoardVO;
import com.brothersplant.domain.BoardsCountListVO;
import com.brothersplant.domain.CategoryInfoVO;
import com.brothersplant.domain.SearchCriteria;
import com.brothersplant.domain.SelectRegionVO;

public interface BoardInfoService {
	
	public void insertBoard(BoardVO board) throws Exception;
	
	public List<String> selectDo() throws Exception;
	public List<String> selectSi(String do1) throws Exception;
	
	public List<Map<String, Object>> selectMainCategory() throws Exception;
	public List<Map<String, Object>> selectSubCategory(int cno) throws Exception;
	public Map<String,String> selectCategory(int csno) throws Exception;
	
	//일반 게시물
	public BoardVO selectCommonRow(int tbno,String id) throws Exception;
	public int deleteCommonRow(int tbno) throws Exception;
	public int updateCommonRow(BoardVO vo)throws Exception;
	
	// 관심 게시판 검색
	public List<BoardListVO> selectMyInterestList(SearchCriteria cri) throws Exception;
	public BoardListVO selectMyInterestRow(SearchCriteria cri) throws Exception;
	public int countBoardList(SearchCriteria cri) throws Exception;
	
	public List<BoardListVO> showTravelReviewList(SearchCriteria cri) throws Exception;
	public int countTravelReviewList(SearchCriteria cri) throws Exception;
	
	//즐겨찾기 추가
	public int getBookmark(String id, int tbno) throws Exception;
	public void addBookmark(String id, int tbno) throws Exception;
	public void deleteBookmark(String id, int tbno) throws Exception;
	
	public List<SelectRegionVO> sido() throws Exception;
	public List<SelectRegionVO> gugun(String sido) throws Exception;
	
	//조회수 증가
	public int addViewCnt(int tbno) throws Exception;
	
	//카테고리별 지역 가져오기
	public List<Map<String, Object>> selectCnoList(SearchCriteria cri) throws Exception;
	public List<Map<String, Object>> selectCityList(String do1, int cno) throws Exception;
}
