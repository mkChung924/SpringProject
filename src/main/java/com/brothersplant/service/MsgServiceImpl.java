package com.brothersplant.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.brothersplant.domain.Criteria;
import com.brothersplant.domain.ReceiverMessagesVO;
import com.brothersplant.domain.SenderMessagesVO;
import com.brothersplant.persistence.MsgDAO;

@Service
public class MsgServiceImpl implements MsgService {
	
	@Inject
	private MsgDAO dao; 

	@Override
	public void sendMsg(SenderMessagesVO vo) throws Exception {
		dao.senderMessagesCreate(vo);
		
	}
	
	@Override
	public void receiveMsg(ReceiverMessagesVO vo) throws Exception {
		dao.receiverMessagesCreate(vo);
		
	}

	@Override
	public SenderMessagesVO readSender(int mno) throws Exception {
		
		return dao.readSender(mno);
	}

	@Override
	public ReceiverMessagesVO readReceiver(int mno) throws Exception {

		return dao.readReceiver(mno);
	}

	@Override
	public boolean sendDelete(int mno) throws Exception {
		
		return dao.sendDelete(mno);
	}

	@Override
	public boolean receiveDelete(int mno) throws Exception {

		return dao.receiveDelete(mno);
	}

	@Override
	public List<SenderMessagesVO> senderListCriteria(Criteria cri, String id) throws Exception {
		
		return dao.senderListCriteria(cri,id);
	}

	@Override
	public int senderCountPaging() throws Exception {
		
		return dao.senderCountPaging();
	}

	@Override
	public List<ReceiverMessagesVO> receiverListCriteria(Criteria cri, String id) throws Exception {
		
		return dao.receiverListCriteria(cri,id);
	}

	@Override
	public int receiverCountPaging() throws Exception {
		
		return dao.receiverCountPaging();
	}

	@Override
	public List<SenderMessagesVO> listSender(int page) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<ReceiverMessagesVO> listReceiver(int page) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

}
