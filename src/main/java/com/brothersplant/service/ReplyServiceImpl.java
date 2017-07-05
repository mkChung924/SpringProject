package com.brothersplant.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.brothersplant.domain.ReplyVO;
import com.brothersplant.persistence.ReplyDAO;
@Service
public class ReplyServiceImpl implements ReplyService {

	@Inject
	private ReplyDAO replyDAO;
	
	@Override
	public void addReply(ReplyVO vo) throws Exception {
		replyDAO.addReply(vo);
	}

	@Override
	public List<ReplyVO> listReply(int tbno) throws Exception {
		return replyDAO.listReply(tbno);
	}

	@Override
	public void modifyReply(ReplyVO vo) throws Exception {
		replyDAO.modifyReply(vo);
	}

	@Override
	public void removeReply(int rno) throws Exception {
		replyDAO.removeReply(rno);
	}

	@Override
	public int count(int bno) throws Exception {
		return 0;
	}

}
