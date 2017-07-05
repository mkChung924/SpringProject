package com.brothersplant.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.brothersplant.domain.Criteria;
import com.brothersplant.domain.ReplyReportsVO;
import com.brothersplant.domain.TableReportVO;
import com.brothersplant.persistence.ReportsDAO;



@Service
public class ReportsServiceImpl implements ReportsService {

	@Inject
	private ReportsDAO dao;
	
	@Override
	public void replyReport(ReplyReportsVO vo) throws Exception {
		dao.replyReportsCreate(vo);
	}

	@Override
	public ReplyReportsVO readReply(int rno) throws Exception {
		
		return dao.readReply(rno);
	}

	@Override
	public boolean replyRemove(int repno) throws Exception {
		
		return dao.replyDelete(repno);
	}

	@Override
	public List<ReplyReportsVO> replyListCriteria(Criteria cri) throws Exception {
		
		return dao.replyListCriteria(cri);
	}

	@Override
	public int replyCountPaging() throws Exception {
		
		return dao.replyCountPaging();
	}


	@Override
	public void insertReport(int rno) throws Exception {
		dao.insertReply(rno);
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
	}

	
	
}
