package com.brothersplant.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.brothersplant.domain.Criteria;
import com.brothersplant.domain.ReportsListVO;
import com.brothersplant.domain.TableReportVO;
import com.brothersplant.persistence.ReportsDAO;



@Service
public class ReportsServiceImpl implements ReportsService {

	@Inject
	private ReportsDAO dao;
	
	@Override
	public int insertReport(ReportsListVO vo) throws Exception {
		return dao.insertReport(vo);
	}
	
	@Override
	public List<String> selectReportList() throws Exception {
		return dao.selectReportList();
	}

	@Override
	public int countPaging(int kind) throws Exception {
		return dao.countPaging(kind);
	}
	
	@Override
	public List<ReportsListVO> listCriteria(Criteria cri,int kind) throws Exception {		
		return dao.listCriteria(cri,kind);
	}

	@Override
	public int selectedReprotListDelete(int kind, String[] repno) throws Exception {
		return dao.selectedReprotListDelete(kind, repno);
	}

	@Transactional 
	@Override
	public int selectedReprotListDeletePenalty(int kind, List<String> brnoLists,List<String> uniqueOffenderList) throws Exception{ //신고 삭제 패널티 업음 
		//게시물 또는 댓글을 삭제 시키고 (신고목록은 어쩌피 검색한 값으로 이루어 지므로 게시글 또는 댓글 삭제시 자동으로 제외후 검색이 됨)
		dao.deletefromBoard_Reply(kind,brnoLists);
		dao.addUserPenalty(uniqueOffenderList);//유저에게 패널티 주고
		dao.selectPenaltyScore(uniqueOffenderList);
		return 0;
	}

}

/*	@Override
	public void replyReport(ReportsListVO vo) throws Exception {
		dao.replyReportsCreate(vo);
	}

	@Override
	public ReportsListVO readReply(int rno) throws Exception {
		
		return dao.readReply(rno);
	}

	@Override
	public boolean replyRemove(int repno) throws Exception {
		
		return dao.replyDelete(repno);
	}





	@Override
	public void insertReport(ReportsListVO vo) throws Exception {
		dao.insertReply(vo);
	}

	@Override
	public void removeReply(int rno) throws Exception {
		dao.repDelect(rno);
		dao.responsAllDelete(rno);
	}
	@Override
	public void tableReport(TableReportVO vo) throws Exception {
		dao.tableReportcreate(vo);
		
	}

	@Override
	public boolean tableReportRemove(int tbno) throws Exception {
		return dao.tableReportDelete(tbno);

	}


	@Override
	public int tableReportCountPaging() throws Exception {
		
		return dao.tableReportCountPaging();
	}
	

	@Override
	public boolean tableDelete(int tbno) throws Exception {
		
		return dao.tableDelete(tbno);
	}


	@Override
	public List<TableReportVO> tableReportListCriteria(Criteria cri) throws Exception {
		return dao.tableReportListCriteria(cri);
	}

	@Override
	public TableReportVO readTableReport(int tbno) throws Exception {

		return dao.readTableReport(tbno);
	}*/