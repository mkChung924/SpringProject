package com.brothersplant.persistence;

import java.util.List;
import java.util.Map;

import com.brothersplant.domain.BoardListVO;
import com.brothersplant.domain.BoardVO;
import com.brothersplant.domain.CategoryInfoVO;
import com.brothersplant.domain.SearchCriteria;
import com.brothersplant.domain.SelectRegionVO;

public interface BoardInfoDAO {
	public void insertBoard(BoardVO board) throws Exception;
	public BoardVO selectCommonRow(int tbno,String id) throws Exception;
	public int deleteCommonRow(int tbno) throws Exception;
	public int updateCommonRow(BoardVO vo) throws Exception;
	
	public List<String> selectDo() throws Exception;
	public List<String> selectSi(String do1) throws Exception;
	
	public List<Map<String, Object>> selectMainCategory() throws Exception;
	public List<Map<String, Object>> selectSubCategory(int cno) throws Exception;
	public Map<String, String> selectCategory(int csno) throws Exception;	
	
	public List<BoardListVO> selectBoardList(SearchCriteria cri) throws Exception;
	public int selectBoardCount(SearchCriteria cri) throws Exception;
	
	public List<BoardListVO> selectTravelReviewList(SearchCriteria cri) throws Exception;
	public int selectTravelCount(SearchCriteria cri) throws Exception;
	
	public int selectBookmark(String id, int tbno) throws Exception;
	public void addBookmark(String id, int tbno) throws Exception;
	public void removeBookmark(String id, int tbno) throws Exception;
	
	public List<SelectRegionVO> selectSido() throws Exception;
	public List<SelectRegionVO> selectGugun(String ds_sido) throws Exception;
	
	public int addViewCnt(int tbno) throws Exception;//조회수
	public List<Object> selectViewCnt(List<Object> tbnoList) throws Exception;
}


