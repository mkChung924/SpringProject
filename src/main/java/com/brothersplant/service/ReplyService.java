package com.brothersplant.service;

import java.util.List;

import com.brothersplant.domain.ReplyVO;

public interface ReplyService {
	
	public void addReply(ReplyVO vo) throws Exception;

	public List<ReplyVO> listReply(int bno) throws Exception;

	public void modifyReply(ReplyVO vo) throws Exception;

	public void removeReply(int rno) throws Exception;
	
	public int count(int bno) throws Exception;
}
