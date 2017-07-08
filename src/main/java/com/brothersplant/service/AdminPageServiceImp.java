package com.brothersplant.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.brothersplant.domain.SearchCriteria;
import com.brothersplant.domain.UserInfoVO;
import com.brothersplant.persistence.AdminPageDAO;

@Service
public class AdminPageServiceImp implements AdminPageService {

	@Inject
	private AdminPageDAO dao;
	
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

}
