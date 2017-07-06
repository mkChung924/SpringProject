package com.brothersplant.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.brothersplant.domain.Criteria;
import com.brothersplant.domain.ReplyReportsVO;
import com.brothersplant.domain.TableReportVO;
@Repository
public class ReportsDAOImpl implements ReportsDAO {

	@Inject
	private SqlSession sqlSession;
	
	@Override
	public void replyReportsCreate(ReplyReportsVO vo) throws Exception {
		sqlSession.insert("report.insertReply", vo);
	}

	@Override
	public List<ReplyReportsVO> listReply(int page) throws Exception {
		if(page < 1) page=1;
		
		page = (page-1)*10;		
		
		RowBounds bounds = new RowBounds(page, 10);
		
		return sqlSession.selectList("report.replySelect",null,bounds);
	}
	
	@Override
	public ReplyReportsVO readReply(int rno) throws Exception {
		
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
	public List<ReplyReportsVO> replyListCriteria(Criteria cri) throws Exception {
		RowBounds bounds = new RowBounds(cri.getPageStart(), cri.getPerPageNum());
		return sqlSession.selectList("report.replySelect",null,bounds);
	}


	@Override
	public int replyCountPaging() throws Exception {
		
		return sqlSession.selectOne("report.replyCountPaging");
	}

	@Override
	public void insertReply(int rno) throws Exception {
		
		sqlSession.insert("report.insertReply",rno);
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

}
