package com.brothersplant.service;

import java.util.List;

import com.brothersplant.domain.SearchCriteria;
import com.brothersplant.domain.UserInfoVO;

public interface AdminPageService {

	
	public List<UserInfoVO> selectAdminList() throws Exception;
	public List<UserInfoVO> selectMemeberList(SearchCriteria cri) throws Exception;
	public int selectMemberCount(SearchCriteria cri) throws Exception;
	public void upgradeAuth(String id) throws Exception;
	public void downgradeAuth(String id) throws Exception;
}
