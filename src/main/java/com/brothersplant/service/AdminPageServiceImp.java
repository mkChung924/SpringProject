package com.brothersplant.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.brothersplant.aop.InterCeptorLoingCheck;
import com.brothersplant.domain.BoardVO;
import com.brothersplant.domain.BoardsCountListVO;
import com.brothersplant.domain.SearchCriteria;
import com.brothersplant.domain.UserInfoVO;
import com.brothersplant.persistence.AdminPageDAO;

@Service
public class AdminPageServiceImp implements AdminPageService {

	@Inject
	private AdminPageDAO dao;
	private static final org.slf4j.Logger logger = LoggerFactory.getLogger(InterCeptorLoingCheck.class);
	
	@Override
	public List<UserInfoVO> selectMemeberList(SearchCriteria cri) throws Exception {
		
		return dao.selectMemeberList(cri);
	}

	@Override
	public List<UserInfoVO> selectAdminList() throws Exception {
		return dao.selectAdminList();
	}

	@Override
	public int selectMemberCount(SearchCriteria cri) throws Exception {
		return dao.selectMemberCount(cri);
	}
	
	@Override
	public void upgradeAuth(String id) throws Exception {
		dao.upgrade(id);	
	}

	@Override
	public void downgradeAuth(String id) throws Exception {
		
		dao.downgrade(id);	
	}

	@Override
	public List<BoardsCountListVO> selectBoardsCountList() throws Exception {
		
		return dao.selectBoardsCountList();
	}

	@Override
	public List<BoardVO> selectCategoryDetail(SearchCriteria cri) throws Exception {
		
		return dao.selectCategoryDetail(cri);
	}
	
	@Override
	public int selectCategoryDetailCount(SearchCriteria cri) throws Exception {
		return dao.selectCategoryDetailCount(cri);
	}

	@Override
	public List<Map<String, Object>> selectCnoList(SearchCriteria cri) throws Exception {
		return dao.selectCnoList(cri);
	}

	@Override
	public List<Map<String, Object>> selectCityList(SearchCriteria cri) throws Exception {
		
		return dao.selectCityList(cri);
	}



}
