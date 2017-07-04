package com.brothersplant.service;

import java.util.List;

import com.brothersplant.domain.MyBookmarkVO;
import com.brothersplant.domain.SecureVO;
import com.brothersplant.domain.UserInfoVO;

public interface MyPageService {
	
	public UserInfoVO myPageInfo(String id)throws Exception;
	
	public List<SecureVO> secureCode()throws Exception;
	
	public void removeAll(String id)throws Exception;
	
	public String deleteAll(String id, String pass) throws Exception;
	
	public void updateUser(UserInfoVO vo) throws Exception;
	
	public String updateAll(String id, String pass) throws Exception;
	
	public List<MyBookmarkVO> getMyBookmarks(String id) throws Exception;
	
	

}
