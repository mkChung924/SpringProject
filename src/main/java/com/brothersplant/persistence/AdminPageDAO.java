package com.brothersplant.persistence;

import java.util.List;

import com.brothersplant.domain.SearchCriteria;
import com.brothersplant.domain.UserInfoVO;

public interface AdminPageDAO {
	
	//회원현황
	public List<UserInfoVO> selectAdminList() throws Exception;
	public List<UserInfoVO> selectMemeberList(SearchCriteria cri) throws Exception;
	public int selectMemberCount(SearchCriteria cri) throws Exception;
	public void upgrade(String id) throws Exception;
	public void downgrade(String id) throws Exception;

}
