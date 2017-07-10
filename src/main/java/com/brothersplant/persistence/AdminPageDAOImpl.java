package com.brothersplant.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.brothersplant.domain.BoardVO;
import com.brothersplant.domain.BoardsCountListVO;
import com.brothersplant.domain.SearchCriteria;
import com.brothersplant.domain.UserInfoVO;

@Repository
public class AdminPageDAOImpl implements AdminPageDAO {
	
	@Inject
	private SqlSession sql;

	@Override
	public List<UserInfoVO> selectMemeberList(SearchCriteria cri) throws Exception {
		
		RowBounds bounds = new RowBounds(cri.getPageStart(), cri.getPerPageNum());
		return sql.selectList("admin.selectMemberList",cri,bounds);
	}

	@Override
	public List<UserInfoVO> selectAdminList() throws Exception {
		
		return sql.selectList("admin.selectAdminList");
	}

	@Override
	public int selectMemberCount(SearchCriteria cri) throws Exception {
		
		return sql.selectOne("admin.selectMemberCount",cri);
	}
	
	@Override
	public void upgrade(String id) throws Exception {
		
		sql.update("admin.upgrade", id);	
	}

	@Override
	public void downgrade(String id) throws Exception {
		
		sql.update("admin.downgrade", id);	
	}

	@Override
	public List<BoardsCountListVO> selectBoardsCountList() throws Exception {
		
		return sql.selectList("admin.selectBoardsCount");
	}

	@Override
	public List<BoardVO> selectCategoryDetail(int cno) throws Exception {
		
		return null;
	}

}
