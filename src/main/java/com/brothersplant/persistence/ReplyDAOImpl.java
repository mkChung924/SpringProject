package com.brothersplant.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.brothersplant.domain.ReplyVO;

@Repository
public class ReplyDAOImpl implements ReplyDAO {

	@Inject
	private SqlSession session;
	
	private static final String namespace = "com.Team26_5.matchingService.ReplyMapper";
	
	@Override
	public void addReply(ReplyVO vo) throws Exception {
		System.out.println(vo.toString());
		session.insert(namespace+".addReply",vo);
	}

	@Override
	public List<ReplyVO> listReply(int tbno) throws Exception {
		return session.selectList(namespace+".listReply", tbno);
	}

	@Override
	public void modifyReply(ReplyVO vo) throws Exception {
		session.update(namespace+".modifyReply",vo);
	}

	@Override
	public void removeReply(int rno) throws Exception {
		session.delete(namespace+".removeReply",rno);
	}

	@Override
	public int count(int bno) throws Exception {
		return 0;
	}

}
