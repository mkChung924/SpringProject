package com.brothersplant.service;

import java.util.List;

import com.brothersplant.domain.Criteria;
import com.brothersplant.domain.ReceiverMessagesVO;
import com.brothersplant.domain.SenderMessagesVO;

public interface MsgService {
	
	public void sendMsg(SenderMessagesVO vo)throws Exception;
	public void receiveMsg(ReceiverMessagesVO vo)throws Exception;
	public List<SenderMessagesVO> listSender(int page)throws Exception;//수신메일함 
	public List<ReceiverMessagesVO> listReceiver(int page)throws Exception;//발신메일함
	public SenderMessagesVO readSender(int mno)throws Exception;
	public ReceiverMessagesVO readReceiver(int mno)throws Exception;
	public boolean sendDelete(int mno)throws Exception;
	public boolean receiveDelete(int mno)throws Exception;
	public List<SenderMessagesVO> senderListCriteria(Criteria cri, String id)throws Exception;//조회(여러행-리스트)
	public int senderCountPaging ()throws Exception;//전체레코드수
	public List<ReceiverMessagesVO> receiverListCriteria(Criteria cri, String id)throws Exception;//조회(여러행-리스트)
	public int receiverCountPaging ()throws Exception;//전체레코드수

}
