package com.brothersplant.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.brothersplant.domain.BoardListVO;
import com.brothersplant.domain.BoardVO;
import com.brothersplant.domain.CategoryInfoVO;

@Repository
public class BoardInfoDAOImpl implements BoardInfoDAO {
	
	@Inject
	private SqlSession session;

private static final String namespace = "board";
	
	@Override
	public void insertBoard(BoardVO board) throws Exception {//일반 사용자가 쓴 여행 추천 글 db에 삽입
		session.insert(namespace+".insertBoard",board);
	}


	@Override
	public List<String> selectDo() throws Exception { // 도를 검색
		return session.selectList(namespace+".selectDO");
	}

	@Override
	public List<String> selectSi(String do1) throws Exception { //시를 검색
		Map<String, String> map = new HashMap<>();
		map.put("do1", do1);
		return session.selectList(namespace+".selectSi",map);
	}

	@Override
	public BoardVO selectCommonRow(int tbno) throws Exception {
		return session.selectOne(namespace+".selectCommonRow",tbno);
	}

	@Override
	public List<String> selectMainCategory() throws Exception {
		return session.selectList(namespace+".selectMainCategory");
	}

	@Override
	public List<Map<String, Object>> selectSubCategory(int cno) throws Exception {
		System.out.println(cno);
		return session.selectList(namespace+".selectSubCategory",cno);
	}


	@Override
	public List<BoardListVO> selectBoardList(CategoryInfoVO vo) throws Exception {
		
		return session.selectList(namespace+".selectBoardList", vo);
	}


	@Override
	public Map<String, String> selectCategory(int csno) throws Exception {
		
		return session.selectOne(namespace+".selectCategory",csno);
		
	}

}
