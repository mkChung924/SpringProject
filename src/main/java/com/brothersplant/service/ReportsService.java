package com.brothersplant.service;

import java.util.List;

import com.brothersplant.domain.Criteria;
import com.brothersplant.domain.ReportsListVO;
import com.brothersplant.domain.TableReportVO;

public interface ReportsService {

	public int insertReport(ReportsListVO vo)throws Exception;
	public List<String> selectReportList() throws Exception;
	public int countPaging(int kind) throws Exception;
	
	public List<ReportsListVO> listCriteria(Criteria cri,int kind)throws Exception;
}

/*	public void replyReport(ReportsListVO vo)throws Exception;
	public ReportsListVO readReply(int rno)throws Exception;
	public boolean replyRemove(int repno)throws Exception;
	public void insertReport(ReportsListVO vo)throws Exception; //게시물에서 댓글 신고
	public void removeReply(int rno)throws Exception;
	
	public void tableReport(TableReportVO vo)throws Exception;
	public TableReportVO readTableReport(int tbno)throws Exception;
	public boolean tableReportRemove(int tbno)throws Exception;
	public List<TableReportVO> tableReportListCriteria(Criteria cri)throws Exception;
	public int tableReportCountPaging()throws Exception;
	
	public boolean tableDelete (int tbno)throws Exception;*/