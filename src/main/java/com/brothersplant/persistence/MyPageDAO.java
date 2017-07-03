package com.brothersplant.persistence;

import java.util.List;

import com.brothersplant.domain.SecureVO;
import com.brothersplant.domain.UserInfoVO;

public interface MyPageDAO {
	
	public UserInfoVO myPageInfo(String id)throws Exception;

	public List<SecureVO> secureCode()throws Exception;
	
	public String passMatch(String id, String pass) throws Exception;
	
	public void deleteUser(String id)throws Exception;
	
	public void updateUser(UserInfoVO vo)throws Exception;

}
