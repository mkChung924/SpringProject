package com.brothersplant.persistence;

import java.util.List;

import com.brothersplant.domain.Criteria;
import com.brothersplant.domain.InsertMessageVO;

public interface MsgDAO {
	
	public void senderMessagesCreate(InsertMessageVO vo)throws Exception;
	public void receiverMessagesCreate(InsertMessageVO vo)throws Exception;
	public List<InsertMessageVO> listSender(int page)throws Exception;//수신메일함 
	public List<InsertMessageVO> listReceiver(int page)throws Exception;//발신메일함
	public InsertMessageVO readSender(int mno)throws Exception;
	public InsertMessageVO readReceiver(int mno)throws Exception;
	public boolean sendDelete(int mno)throws Exception;
	public boolean receiveDelete(int mno)throws Exception;
	public List<InsertMessageVO> senderListCriteria(Criteria cri, String id)throws Exception;//조회(여러행-리스트)
	public int senderCountPaging ()throws Exception;//전체레코드수
	public List<InsertMessageVO> receiverListCriteria(Criteria cri, String id)throws Exception;//조회(여러행-리스트)
	public int receiverCountPaging ()throws Exception;//전체레코드수

}
