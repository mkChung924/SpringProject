package com.brothersplant.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.brothersplant.aop.InterCeptorLoingCheck;
import com.brothersplant.domain.Criteria;
import com.brothersplant.domain.InsertMessageVO;
import com.brothersplant.persistence.MsgDAO;

@Service
public class MsgServiceImpl implements MsgService {
	
	@Inject
	private MsgDAO dao; 

	private static final org.slf4j.Logger logger = LoggerFactory.getLogger(InterCeptorLoingCheck.class);
	
	@Transactional
	@Override
	public void addMsg(InsertMessageVO vo) throws Exception {
		dao.senderMessagesCreate(vo);
		dao.receiverMessagesCreate(vo);
		
	}

	@Override
	public InsertMessageVO readSender(int mno) throws Exception {
		
		return dao.readSender(mno);
	}

	@Override
	public InsertMessageVO readReceiver(int mno) throws Exception {

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
	public List<InsertMessageVO> senderListCriteria(Criteria cri, String id) throws Exception {
		
		return dao.senderListCriteria(cri,id);
	}

	@Override
	public int senderCountPaging() throws Exception {
		
		return dao.senderCountPaging();
	}

	@Override
	public List<InsertMessageVO> receiverListCriteria(Criteria cri, String id) throws Exception {
		
		return dao.receiverListCriteria(cri,id);
	}

	@Override
	public int receiverCountPaging() throws Exception {
		
		return dao.receiverCountPaging();
	}

	@Override
	public List<InsertMessageVO> listSender(int page) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<InsertMessageVO> listReceiver(int page) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}



}
