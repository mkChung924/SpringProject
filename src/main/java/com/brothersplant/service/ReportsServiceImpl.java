package com.brothersplant.service;

import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.brothersplant.domain.Criteria;
import com.brothersplant.domain.ReportsListVO;
import com.brothersplant.domain.SearchCriteria;
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
	public int countPaging(SearchCriteria cri,int kind) throws Exception {
		return dao.countPaging(cri,kind);
	}
	
	@Override
	public List<ReportsListVO> listCriteria(Criteria cri,int kind) throws Exception {		
		return dao.listCriteria(cri,kind);
	}
	
	@Override
	public List<ReportsListVO> listSearchCriteria(SearchCriteria cri, int kind) throws Exception {
		return dao.listSearchCriteria(cri, kind);
	}

	@Override
	public int selectedReprotListDelete(int kind, String[] repno) throws Exception {
		return dao.selectedReprotListDelete(kind, repno);
	}

	@Transactional 
	@Override
	public int selectedReprotListDeletePenalty(int kind, List<String> brnoLists,List<String> uniqueOffenderList) throws Exception{ //신고 삭제 패널티 업음 
		//게시물 또는 댓글을 삭제 시키고 (신고목록은 어쩌피 검색한 값으로 이루어 지므로 게시글 또는 댓글 삭제시 자동으로 제외후 검색이 됨)
		System.out.println(uniqueOffenderList);
		System.out.println(brnoLists);
		dao.deletefromBoard_Reply(kind,brnoLists);
		dao.addUserPenalty(uniqueOffenderList);//유저에게 패널티 주고
		int t = dao.selectPenaltyScore(uniqueOffenderList);
		return t;
	}



}
