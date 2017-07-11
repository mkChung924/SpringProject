package com.brothersplant.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.brothersplant.domain.BoardListVO;
import com.brothersplant.domain.BoardVO;
import com.brothersplant.domain.BoardsCountListVO;
import com.brothersplant.domain.CategoryInfoVO;
import com.brothersplant.domain.SearchCriteria;
import com.brothersplant.domain.SelectRegionVO;

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
	public BoardVO selectCommonRow(int tbno,String id) throws Exception {
		System.out.println("DAO : "+tbno);
		Map<String, Object> map = new HashMap<>();
		map.put("tbno", tbno);
		map.put("id", id);
		return session.selectOne(namespace+".selectCommonRow",map);
	}

	@Override
	public List<Map<String, Object>> selectMainCategory() throws Exception {
		return session.selectList(namespace+".selectMainCategory");
	}

	@Override
	public List<Map<String, Object>> selectSubCategory(int cno) throws Exception {
		System.out.println(cno);
		return session.selectList(namespace+".selectSubCategory",cno);
	}


	@Override
	public List<BoardListVO> selectBoardList(SearchCriteria cri) throws Exception {
		
		RowBounds bounds = new RowBounds(cri.getPageStart(), cri.getPerPageNum());
		return session.selectList(namespace+".selectBoardList", cri, bounds);
	}

	@Override
	public int selectBoardCount(SearchCriteria cri) throws Exception {
		
		return session.selectOne(namespace+".countBoardList", cri);
	}
	

	@Override
	public List<BoardListVO> selectTravelReviewList(SearchCriteria cri) throws Exception {
		
		RowBounds bounds = new RowBounds(cri.getPageStart(), cri.getPerPageNum());
		return session.selectList(namespace+".selectTravelReview", cri, bounds);
	}


	@Override
	public int selectTravelCount(SearchCriteria cri) throws Exception {
		
		return session.selectOne(namespace+".countTravelReview", cri);
	}


	@Override
	public Map<String, String> selectCategory(int csno) throws Exception {
		
		return session.selectOne(namespace+".selectCategory",csno);
		
	}

	@Override
	public void addBookmark(String id, int tbno) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("id", id);
		map.put("tbno", tbno);
		session.insert(namespace+".insertBookmark", map);
		
	}


	@Override
	public void removeBookmark(String id, int tbno) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("id", id);
		map.put("tbno", tbno);
		session.delete(namespace+".deleteBookmark", map);
		
	}


	@Override
	public int selectBookmark(String id, int tbno) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("id", id);
		map.put("tbno", tbno);
		return session.selectOne(namespace+".selectBookmark", map);
		
	}

	@Override
	public int deleteCommonRow(int tbno) throws Exception {
		return session.delete(namespace+".deleteCommonRow", tbno);
	}
//위에 똑같은 메소드 있음 나중에 삭제요망
	@Override
	public List<SelectRegionVO> selectSido() throws Exception {		
		return session.selectList(namespace+".selectSido");
	}
	@Override
	public List<SelectRegionVO> selectGugun(String ds_sido) throws Exception {
		
		return session.selectList(namespace+".selectGugun", ds_sido);
	}
//여기 까지 두개 

	@Override
	public int updateCommonRow(BoardVO vo) throws Exception {
		return session.update(namespace+".updateCommonRow",vo);
	}


	@Override
	public List<Map<String, Object>> selectCnoList(SearchCriteria cri) throws Exception {
		return session.selectList("admin.selectCnoList",cri);
	}


	@Override
	public List<Map<String, Object>> selectCityList(String do1, int cno) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("do1", do1);
		map.put("cno", cno);
		return session.selectList("admin.selectCityList",map);
	}

}
