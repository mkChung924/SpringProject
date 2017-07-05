package com.brothersplant.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.brothersplant.domain.UserInfoVO;
import com.brothersplant.persistence.UserInfoDAO;

@Service
public class UserInfoServiceImpl implements UserInfoService {
	
	@Inject
	private UserInfoDAO dao;

	@Override
	public void create(UserInfoVO vo) throws Exception {
		//System.out.println("service: " + vo);
		dao.insert(vo);

	}


	@Override
	public String changePassword(String id, String name, String secure_code, String secure_ans) throws Exception {
		
		return dao.proove(id, name, secure_code, secure_ans);
	}

	@Override
	public List<String> findId(String name, String birth) throws Exception {
		
		return dao.readId(name, birth);
	}

	@Override
	public String checkId(String id, String pass) throws Exception {
		
		return null;
	}

	@Override
	public boolean dupCheck(String id) throws Exception {
		
		return dao.dupCheck(id);
	}

	@Override
	public boolean login(String id, String pass) throws Exception {
		
		return dao.select(id, pass);
	}

	@Override
	public void modifyPassword(String id, String pass) throws Exception {
		dao.updatePassword(id, pass);
		
	}

	@Override
	public boolean checkNickname(String nickname) throws Exception {
		
		System.out.println("service: " + nickname);
		return dao.nickCheck(nickname);
	}

	@Override
	public String selectprofile(String id) throws Exception {
		return dao.selectprofile(id);
	}
	@Override
	public int getMyAuth(String id) throws Exception {
		return dao.selectAuth(id);
	}


	@Override
	public int updateProfilePicture(String profile,String id) throws Exception {
		return dao.updateProfilePicture(profile,id);
	}

}
