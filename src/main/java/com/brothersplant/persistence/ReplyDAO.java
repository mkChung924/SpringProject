package com.brothersplant.persistence;

import java.util.List;

import com.brothersplant.domain.ReplyVO;

public interface ReplyDAO {
	
	public void addReply(ReplyVO vo) throws Exception;

	public List<ReplyVO> listReply(int tbno) throws Exception;

	public void modifyReply(ReplyVO vo) throws Exception;

	public void removeReply(int rno) throws Exception;
	
	public int count(int bno) throws Exception;
}
