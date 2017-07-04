package com.brothersplant.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.brothersplant.domain.Criteria;
import com.brothersplant.domain.ReceiverMessagesVO;
import com.brothersplant.domain.SenderMessagesVO;

@Repository
public class MsgDAOImpl implements MsgDAO {
	
	@Inject
	private SqlSession sql;

	@Override
	public void senderMessagesCreate(SenderMessagesVO vo) throws Exception {
		sql.insert("msg.insertSend",vo);
		
	}

	@Override
	public void receiverMessagesCreate(ReceiverMessagesVO vo) throws Exception {
		sql.insert("msg.insertReceive",vo);
		
	}

	@Override
	public List<SenderMessagesVO> listSender(int page) throws Exception {
		if(page < 1) page=1;
		
		page = (page-1)*10;		
		
		RowBounds bounds = new RowBounds(page, 10);
		
		return sql.selectList("msg.senderSelect",null,bounds);
	}

	@Override
	public List<ReceiverMessagesVO> listReceiver(int page) throws Exception {
		if(page < 1) page=1;
		
		page = (page-1)*10;		
		
		RowBounds bounds = new RowBounds(page, 10);

		return sql.selectList("msg.receiverSelect",null,bounds);
	}

	@Override
	public SenderMessagesVO readSender(int mno) throws Exception {

		return sql.selectOne("msg.senderContent",mno);
	}

	@Override
	public ReceiverMessagesVO readReceiver(int mno) throws Exception {

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
	public List<SenderMessagesVO> senderListCriteria(Criteria cri, String id) throws Exception {
		RowBounds bounds = new RowBounds(cri.getPageStart(), cri.getPerPageNum());
		return sql.selectList("msg.senderSelect",id,bounds);
	}

	@Override
	public int senderCountPaging() throws Exception {
		
		return sql.selectOne("senderCountPaging");
	}

	@Override
	public List<ReceiverMessagesVO> receiverListCriteria(Criteria cri, String id) throws Exception {
		RowBounds bounds = new RowBounds(cri.getPageStart(), cri.getPerPageNum());
		return sql.selectList("msg.receiverSelect",id,bounds);
	}

	@Override
	public int receiverCountPaging() throws Exception {
		// TODO Auto-generated method stub
		return sql.selectOne("msg.receiverCountPaging");
	}
}
