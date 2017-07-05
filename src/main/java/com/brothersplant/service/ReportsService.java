package com.brothersplant.service;

import java.util.List;

import com.brothersplant.domain.Criteria;
import com.brothersplant.domain.ReplyReportsVO;
import com.brothersplant.domain.TableReportVO;

public interface ReportsService {
	public void replyReport(ReplyReportsVO vo)throws Exception;
	public ReplyReportsVO readReply(int rno)throws Exception;
	public boolean replyRemove(int repno)throws Exception;
	public List<ReplyReportsVO> replyListCriteria(Criteria cri)throws Exception;
	public int replyCountPaging ()throws Exception;
	public void insertReport(int rno)throws Exception;
	public void removeReply(int rno)throws Exception;
	
	public void tableReport(TableReportVO vo)throws Exception;
	public TableReportVO readTableReport(int tbno)throws Exception;
	public boolean tableReportRemove(int tbno)throws Exception;
	public List<TableReportVO> tableReportListCriteria(Criteria cri)throws Exception;
	public int tableReportCountPaging()throws Exception;
	
	public boolean tableDelete (int tbno)throws Exception;
}
