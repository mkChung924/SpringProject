package com.brothersplant.persistence;

import java.util.List;

import com.brothersplant.domain.Criteria;
import com.brothersplant.domain.ReplyReportsVO;
import com.brothersplant.domain.TableReportVO;


public interface ReportsDAO {
	public void replyReportsCreate(ReplyReportsVO vo)throws Exception;
	public List<ReplyReportsVO> listReply(int page)throws Exception;//���Ÿ����� 
	public ReplyReportsVO readReply(int rno)throws Exception;
	public List<ReplyReportsVO> replyListCriteria(Criteria cri)throws Exception;//��ȸ(������-����Ʈ)
	public int replyCountPaging ()throws Exception;
	public boolean replyDelete(int repno) throws Exception;
	
	public void insertReply(int rno)throws Exception; 
	public void repDelect(int rno)throws Exception;
	
	public void responsAllDelete(int rno)throws Exception;
	
	
	
	
	public void tableReportcreate(TableReportVO vo)throws Exception;
	public List<TableReportVO> listTableReport(int page)throws Exception;//게시글신고함
	public TableReportVO readTableReport(int tbno)throws Exception;
	public boolean tableReportDelete(int tbno)throws Exception;
	public List<TableReportVO> tableReportListCriteria(Criteria cri)throws Exception;//조회(여러행-리스트)
	public int tableReportCountPaging ()throws Exception;//전체레코드수
	

	public boolean tableDelete(int tbno)throws Exception;//게시글삭제
}
