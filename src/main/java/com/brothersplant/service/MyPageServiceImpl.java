package com.brothersplant.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.brothersplant.domain.MyBookmarkVO;
import com.brothersplant.domain.SecureVO;
import com.brothersplant.domain.UserInfoVO;
import com.brothersplant.persistence.MyPageDAO;

@Service
public class MyPageServiceImpl implements MyPageService{
	
	@Inject
	private MyPageDAO dao;

	@Override
	public UserInfoVO myPageInfo(String id) throws Exception {
		
		return dao.myPageInfo(id);
	}

	@Override
	public List<SecureVO> secureCode() throws Exception {
		
		return dao.secureCode();
	}

	@Override
	public void removeAll(String id) throws Exception {
		dao.deleteUser(id);
		
	}

	@Override
	public String deleteAll(String id, String pass) throws Exception {
		return dao.passMatch(id, pass);
	}

	@Override
	public int updateUser(UserInfoVO vo) throws Exception {
		return dao.updateUser(vo);
		
	}

	@Override
	public String updateAll(String id, String pass) throws Exception {
		
		return dao.passMatch(id, pass);
	}

	@Override
	public List<MyBookmarkVO> getMyBookmarks(String id) throws Exception {
		
		return dao.selectMyBookmark(id);
	}

}
