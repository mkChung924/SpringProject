package com.brothersplant.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.brothersplant.domain.Criteria;
import com.brothersplant.domain.ReportsListVO;
import com.brothersplant.domain.TableReportVO;
@Repository
public class ReportsDAOImpl implements ReportsDAO {

	@Inject
	private SqlSession sqlSession;
	
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
	public int countPaging(int kind) throws Exception {
		return sqlSession.selectOne(namespace+".countPaging",kind);
	}
	
	@Override //페이징 된 ReportsListVO 검색
	public List<ReportsListVO> listCriteria(Criteria cri,int kind) throws Exception {
		RowBounds bounds = new RowBounds(cri.getPageStart(), cri.getPerPageNum());
		Map<String, Object> map = new HashMap<>();
		map.put("kind", kind);
		System.out.println("@@@@ : "+kind);
		String what =  (kind ==1) ? "board":"reply";
		map.put("what", what);
		return sqlSession.selectList(namespace+".selectReportList2",map,bounds);
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