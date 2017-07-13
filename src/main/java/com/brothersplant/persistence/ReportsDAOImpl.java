package com.brothersplant.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.brothersplant.aop.InterCeptorLoingCheck;
import com.brothersplant.domain.Criteria;
import com.brothersplant.domain.ReportsListVO;
import com.brothersplant.domain.SearchCriteria;
import com.brothersplant.domain.TableReportVO;
@Repository
public class ReportsDAOImpl implements ReportsDAO {

	@Inject
	private SqlSession sqlSession;
	private static final org.slf4j.Logger logger = LoggerFactory.getLogger(InterCeptorLoingCheck.class);
	
	private static final String namespace = "report";

	@Override
	public int insertReport(ReportsListVO vo) throws Exception {//신고  
		return sqlSession.insert(namespace+".insertReport",vo);
	}

	@Override
	public List<String> selectReportList() throws Exception { //신고 유형 검색
		return sqlSession.selectList("report.selectReportList");
	}

	@Override //게시글인지 댓글인지 종류에 따른 총 갯수 검색 (게시글 1, 댓글 2) 
	public int countPaging(SearchCriteria cri,int kind) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("cri", cri);
		map.put("kind", kind);
		return sqlSession.selectOne(namespace+".countPaging",map);
	}
	
	@Override //페이징 된 ReportsListVO 검색
	public List<ReportsListVO> listCriteria(Criteria cri,int kind) throws Exception {
		RowBounds bounds = new RowBounds(cri.getPageStart(), cri.getPerPageNum());
		Map<String, Object> map = new HashMap<>();
		map.put("kind", kind);
		String what =  (kind ==1) ? "board":"reply";
		map.put("what", what);
		return sqlSession.selectList(namespace+".selectReportList2",map,bounds);
	}
	

	@Override
	public List<ReportsListVO> listSearchCriteria(SearchCriteria cri, int kind) throws Exception {
		RowBounds bounds = new RowBounds(cri.getPageStart(), cri.getPerPageNum());
		Map<String, Object> map = new HashMap<>();
		map.put("kind", kind);
		String what =  (kind ==1) ? "board":"reply";
		map.put("what", what);
		map.put("cri", cri);
		return sqlSession.selectList(namespace+".selectReportList2",map,bounds);
	}


	@Override
	public int selectedReprotListDelete(int kind, String[] repno) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("kind", kind);
		map.put("repnoList", repno);
		return sqlSession.delete(namespace+".selectedReprotListDelete",map);
	}

	@Override
	public int deletefromBoard_Reply(int kind, List<String> brnoLists) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("kind", kind);
		map.put("brnoLists", brnoLists);  //penaltyList [map(offender repno brno), ..]
		return sqlSession.delete(namespace+".deletefromBoard_Reply",map);
	}

	@Override //패널티를 줄 유저들
	public int addUserPenalty(List<String> uniqueOffenderList) {
		Map<String, List<String>> map = new HashMap<>();
		map.put("penaltyUserList", uniqueOffenderList);
		return sqlSession.insert(namespace+".addUserPenalty",map);
	}

	@Override
	public int selectPenaltyScore(List<String> uniqueOffenderList) throws Exception {
		Map<String, List<String>> map = new HashMap<>();
		map.put("penaltyUserList", uniqueOffenderList);
		List<String> list = sqlSession.selectList(namespace+".selectPenaltyScore",map);
		int result=0;
		for(int i=0; i<list.size();i++){
			logger.info("현재 패널티 값은 : "+list.get(i));
			if(Integer.parseInt(list.get(i)) == 10){
				Map<String, String> map2 = new HashMap<>();
				map2.put("user",uniqueOffenderList.get(i) );
				result += sqlSession.update(namespace+".addBlackList",map2);
				
			} else if(Integer.parseInt(list.get(i)) >= 20){ // 벤을 먹임
				Map<String, String> map2 = new HashMap<>();
				map2.put("user",uniqueOffenderList.get(i) );
				result += sqlSession.update(namespace+".addBlackList",map2);
			}
		}
		return result;
	}


}

/*	@Override
	public void replyReportsCreate(ReportsListVO vo) throws Exception {
		sqlSession.insert("report.insertReply", vo);
	}

	@Override
	public List<ReportsListVO> listReply(int page) throws Exception {
		if(page < 1) page=1;
		
		page = (page-1)*10;		
		
		RowBounds bounds = new RowBounds(page, 10);
		
		return sqlSession.selectList("report.replySelect",null,bounds);
	}
	
	@Override
	public ReportsListVO readReply(int rno) throws Exception {
		
		return sqlSession.selectOne("report.replyContent",rno);
	}
	@Override
	public boolean replyDelete(int repno) throws Exception {
		int t = sqlSession.delete("report.reportsDelete",repno);
		if(t==1){
			return true;
		}else{			
			return false;
		}
	}

	@Override
	public List<ReportsListVO> replyListCriteria(Criteria cri) throws Exception {
		RowBounds bounds = new RowBounds(cri.getPageStart(), cri.getPerPageNum());
		return sqlSession.selectList("report.replySelect",null,bounds);
	}



	@Override
	public void insertReply(ReportsListVO vo) throws Exception {
		sqlSession.insert("report.insertReply",vo);
	}

	@Override
	public void repDelect(int rno) throws Exception {
		sqlSession.delete("report.replyDelete",rno);
		
	}

	@Override
	public void responsAllDelete(int rno) throws Exception {
		sqlSession.delete("report.responsAllDelete",rno);
		
	}
	
	@Override
	public void tableReportcreate(TableReportVO vo) throws Exception {
		sqlSession.insert("report.reportTableInsert",vo);
		
	}
	
	@Override
	public List<TableReportVO> listTableReport(int page) throws Exception {
		if(page < 1) page=1;
		
		page = (page-1)*10;		
		
		RowBounds bounds = new RowBounds(page, 10);
		
		return sqlSession.selectList("report.tableRepoertSelect",null,bounds);
	}
	
	@Override
	public TableReportVO readTableReport(int tbno) throws Exception {
		return sqlSession.selectOne("report.tableReportContent",tbno);
	}
	
	@Override
	public boolean tableReportDelete(int tbno) throws Exception {
		int t = sqlSession.delete("report.tablereportDelete",tbno);
		if(t==1){
			return true;
		}else{			
			return false;
		}
	}
	

	@Override
	public List<TableReportVO> tableReportListCriteria(Criteria cri) throws Exception {
		RowBounds bounds = new RowBounds(cri.getPageStart(), cri.getPerPageNum());
		return sqlSession.selectList("report.tableRepoertSelect",null,bounds);
	}

	@Override
	public int tableReportCountPaging() throws Exception {
		return sqlSession.selectOne("report.tablereportCountPaging");
	}


	@Override
	public boolean tableDelete(int tbno) throws Exception {
		int t = sqlSession.delete("report.tableDelete",tbno);
		if(t==1){
			return true;
		}else{
			return false;			
		}
				
	}

	@Override
	public List<String> selectReportList() throws Exception {
		return sqlSession.selectList("report.selectReportList");
	}*/