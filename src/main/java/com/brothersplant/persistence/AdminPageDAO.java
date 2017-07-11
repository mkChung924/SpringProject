package com.brothersplant.persistence;

import java.util.List;
import java.util.Map;

import com.brothersplant.domain.BoardVO;
import com.brothersplant.domain.BoardsCountListVO;
import com.brothersplant.domain.SearchCriteria;
import com.brothersplant.domain.UserInfoVO;

public interface AdminPageDAO {
	
	//회원현황
	public List<UserInfoVO> selectAdminList() throws Exception;
	public List<UserInfoVO> selectMemeberList(SearchCriteria cri) throws Exception;
	public int selectMemberCount(SearchCriteria cri) throws Exception;
	public void upgrade(String id) throws Exception;
	public void downgrade(String id) throws Exception;
	
	//게시판현황
	public  List<BoardsCountListVO> selectBoardsCountList()throws Exception;
	public List<BoardVO> selectCategoryDetail(SearchCriteria cri)throws Exception;
	public int selectCategoryDetailCount(SearchCriteria cri) throws Exception;
	public List<Map<String, Object>> selectCnoList(SearchCriteria cri) throws Exception;
	public List<Map<String, Object>> selectCityList(SearchCriteria cri) throws Exception;
	

}
