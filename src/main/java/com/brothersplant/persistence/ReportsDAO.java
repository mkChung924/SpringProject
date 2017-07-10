package com.brothersplant.persistence;

import java.util.List;
import java.util.Map;

import com.brothersplant.domain.Criteria;
import com.brothersplant.domain.ReportsListVO;
import com.brothersplant.domain.TableReportVO;


public interface ReportsDAO {
	
	public int insertReport(ReportsListVO vo)throws Exception;
	
	public List<String> selectReportList() throws Exception; //신고 내역 목록 ("욕설,광고 등등 이런거")
	
	public int countPaging (int kind)throws Exception;	//종류에 따른 총 data 갯수
	public List<ReportsListVO> listCriteria(Criteria cri,int kind)throws Exception; //페이징된 리스트(ReportsListVO들)

	public int selectedReprotListDelete(int kind, String[] repno) throws Exception;// 선택한 신고목록을 삭제 패널티 없음
	public int deletefromBoard_Reply(int kind, List<String> brnoLists) throws Exception; //신고에 해당한 게시글 또는 댓글 삭제 
	public int addUserPenalty(List<String> uniqueOffenderList);//중복이 제거된 불법 유저에게 패널티 점수를 주고
	public int selectPenaltyScore(List<String> uniqueOffenderList) throws Exception; // 해당 유저를 벤먹일지 아닐지 결정 
	
}
/*	//댓글
	public void replyReportsCreate(ReportsListVO vo)throws Exception;
	public List<ReportsListVO> listReply(int page)throws Exception;//���Ÿ����� 
	public ReportsListVO readReply(int rno)throws Exception;
	public boolean replyDelete(int repno) throws Exception;
	
	public void insertReply(ReportsListVO vo)throws Exception; //게시물에서 댓글을 신고
	public void repDelect(int rno)throws Exception;
	
	public void responsAllDelete(int rno)throws Exception;
	
	
	
	
	public void tableReportcreate(TableReportVO vo)throws Exception;
	public List<TableReportVO> listTableReport(int page)throws Exception;//게시글신고함
	public TableReportVO readTableReport(int tbno)throws Exception;
	public boolean tableReportDelete(int tbno)throws Exception;
	public List<TableReportVO> tableReportListCriteria(Criteria cri)throws Exception;//조회(여러행-리스트)
	public int tableReportCountPaging ()throws Exception;//전체레코드수
	

	public boolean tableDelete(int tbno)throws Exception;//게시글삭제
 */	
