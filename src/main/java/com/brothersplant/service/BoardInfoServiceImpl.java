package com.brothersplant.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.brothersplant.domain.BoardListVO;
import com.brothersplant.domain.BoardVO;
import com.brothersplant.domain.CategoryInfoVO;
import com.brothersplant.domain.SearchCriteria;
import com.brothersplant.persistence.BoardInfoDAO;

@Service
public class BoardInfoServiceImpl implements BoardInfoService {
	
	@Inject
	private BoardInfoDAO dao;

	@Override
	public List<String> selectDo() throws Exception {
		// TODO Auto-generated method stub
		return dao.selectDo();
	}

	@Override
	public List<String> selectSi(String do1) throws Exception {
		// TODO Auto-generated method stub
		return dao.selectSi(do1);
	}

	@Override
	public List<Map<String, Object>> selectMainCategory() throws Exception {
		return dao.selectMainCategory();
	}

	@Override
	public List<Map<String, Object>> selectSubCategory(int cno) throws Exception {
		
		return dao.selectSubCategory(cno);
	}

	@Override
	public void insertBoard(BoardVO board) throws Exception {
		
		dao.insertBoard(board);
		
	}

	@Override
	public BoardVO selectCommonRow(int tbno) throws Exception {
		System.out.println(tbno);
		return dao.selectCommonRow(tbno);
	}

	@Override
	public List<BoardListVO> selectMyInterestList(SearchCriteria cri) throws Exception {
		
		return dao.selectBoardList(cri);
	}
	
	@Override
	public int countBoardList(SearchCriteria cri) throws Exception {
		
		return dao.selectBoardCount(cri);
	}

	@Override
	public Map<String, String> selectCategory(int csno) throws Exception {
		
		return dao.selectCategory(csno);
	}

	@Override
	public void addBookmark(String id, int tbno) throws Exception {

		dao.addBookmark(id, tbno);
	}

	@Override
	public void deleteBookmark(String id, int tbno) throws Exception {
		dao.removeBookmark(id, tbno);
		
	}

	@Override
	public int getBookmark(String id, int tbno) throws Exception {

		return dao.selectBookmark(id, tbno);
	}

	@Override
	public int deleteCommonRow(int tbno) throws Exception {
		return dao.deleteCommonRow(tbno);
	}

}
