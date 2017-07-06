package com.brothersplant.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.brothersplant.domain.Criteria;
import com.brothersplant.domain.InsertMessageVO;

@Repository
public class MsgDAOImpl implements MsgDAO {
	
	@Inject
	private SqlSession sql;

	@Override
	public void senderMessagesCreate(InsertMessageVO vo) throws Exception {
		sql.insert("msg.insertSend",vo);
		
	}

	@Override
	public void receiverMessagesCreate(InsertMessageVO vo) throws Exception {
		sql.insert("msg.insertReceive",vo);
		
	}

	@Override
	public List<InsertMessageVO> listSender(int page) throws Exception {
		if(page < 1) page=1;
		
		page = (page-1)*10;		
		
		RowBounds bounds = new RowBounds(page, 10);
		
		return sql.selectList("msg.senderSelect",null,bounds);
	}

	@Override
	public List<InsertMessageVO> listReceiver(int page) throws Exception {
		if(page < 1) page=1;
		
		page = (page-1)*10;		
		
		RowBounds bounds = new RowBounds(page, 10);

		return sql.selectList("msg.receiverSelect",null,bounds);
	}

	@Override
	public InsertMessageVO readSender(int mno) throws Exception {

		return sql.selectOne("msg.senderContent",mno);
	}

	@Override
	public InsertMessageVO readReceiver(int mno) throws Exception {

		return sql.selectOne("msg.receiverContent",mno);
	}

	@Override
	public boolean sendDelete(int mno) throws Exception {
		int t = sql.delete("msg.sendDelete",mno);
		if(t==1){
			return true;
		}else{			
			return false;
		}
	}

	@Override
	public boolean receiveDelete(int mno) throws Exception {
		int t = sql.delete("msg.receiveDelete",mno);
		if(t==1){
			return true;
		}else{			
			return false;
		}
	}

	@Override
	public List<InsertMessageVO> senderListCriteria(Criteria cri, String id) throws Exception {
		RowBounds bounds = new RowBounds(cri.getPageStart(), cri.getPerPageNum());
		return sql.selectList("msg.senderSelect",id,bounds);
	}

	@Override
	public int senderCountPaging() throws Exception {
		
		return sql.selectOne("senderCountPaging");
	}

	@Override
	public List<InsertMessageVO> receiverListCriteria(Criteria cri, String id) throws Exception {
		RowBounds bounds = new RowBounds(cri.getPageStart(), cri.getPerPageNum());
		System.out.println("받은 메시지함 id: " + id);
		return sql.selectList("msg.receiverSelect",id,bounds);
	}

	@Override
	public int receiverCountPaging() throws Exception {
		// TODO Auto-generated method stub
		return sql.selectOne("msg.receiverCountPaging");
	}
}
