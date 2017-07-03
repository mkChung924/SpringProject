package com.brothersplant.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.brothersplant.domain.BoardVO;
import com.brothersplant.persistence.BoardInfoDAO;

@Service
public class BoardInfoServiceImpl implements BoardInfoService {
	
	@Inject
	private BoardInfoDAO dao;

	@Override
	public List<String> selectDo() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<String> selectSi(String do1) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<String> selectMainCategory() throws Exception {
		return dao.selectMainCategory();
	}

	@Override
	public List<String> selectSubCategory(int cno) throws Exception {
		
		return dao.selectSubCategory(cno);
	}

	@Override
	public void insertBoard(BoardVO board) throws Exception {
		
		dao.insertBoard(board);
		
	}

	@Override
	public BoardVO selectCommonRow(int tbno) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

}
