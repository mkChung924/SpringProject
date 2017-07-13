package com.brothersplant.control;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.brothersplant.aop.InterCeptorLoingCheck;
import com.brothersplant.domain.Criteria;
import com.brothersplant.domain.InsertMessageVO;
import com.brothersplant.domain.PageMaker;
import com.brothersplant.service.MsgService;

@Controller
public class MessageController {
	
	@Inject
	private MsgService service;
	private static final org.slf4j.Logger logger = LoggerFactory.getLogger(InterCeptorLoingCheck.class);
	
	//=======MESSAGE
	@RequestMapping("/mailBox")
	public void mailBox(String page, Model model)throws Exception{
		if(page == null){
			logger.info("null~~");
			page = "1";
		}
		model.addAttribute("page", Integer.parseInt(page));			
	}
	@RequestMapping("/receiveMailBox")
	public String receiveMailBox(HttpSession session, Criteria cri,Model model, int page)throws Exception{
		logger.info("수신함 검색");
		session.setAttribute("msg", "receive");
		cri.setPage(page);
		cri.setPerPageNum(10);
		logger.info("받은 메시지 개수: " + service.receiverListCriteria(cri, (String) session.getAttribute("id")).size());
		model.addAttribute("messages",service.receiverListCriteria(cri, (String) session.getAttribute("id")));
		logger.info(""+service.receiverListCriteria(cri, (String) session.getAttribute("id")));
		PageMaker maker = new PageMaker();
		maker.setCri(cri);
		maker.setTotalCount(service.receiverCountPaging());
		
		model.addAttribute("pageMaker",maker);
		model.addAttribute("page", page);
		
		return "mypage/messages/receiveMailBox";
	}
	
	@RequestMapping("/sendMailBox")
	public String sendMailBox(HttpSession session,Criteria cri,Model model, int page)throws Exception{
		logger.info("발신함 검색");
		session.setAttribute("msg", "send");
		cri.setPage(page);
		cri.setPerPageNum(10);
		model.addAttribute("messages",service.senderListCriteria(cri, (String) session.getAttribute("id")));
		PageMaker maker = new PageMaker();
		maker.setCri(cri);
		maker.setTotalCount(service.senderCountPaging());
		
		model.addAttribute("pageMaker",maker);
		model.addAttribute("page", page);
		
		return "mypage/messages/sendMailBox";
	}
	

	
	@RequestMapping("/sendRemove")//sendcontent
	public ResponseEntity<String> sendRemove(HttpSession session, int mno,int page) {
		ResponseEntity<String> entity = null;
		
		logger.info("삭제될 MNO: "+mno);
		logger.info("전달된 페이지: "+page);
		session.setAttribute("page", page);
		
		try {
			service.sendDelete(mno);
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
			
		}
		return entity;
	}
	
	@RequestMapping("/receiveRemove")//receivecontent
	public ResponseEntity<String> receiveRemove(HttpSession session, int mno,int page) {
		ResponseEntity<String> entity = null;
		
		logger.info("삭제될 MNO: "+mno);
		logger.info("전달된 페이지: "+page);
		session.setAttribute("page", page);	
		
		try {
			service.receiveDelete(mno);
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}	
	
	@RequestMapping(value="/msgSend",method=RequestMethod.GET)
	public String msgSendGet(String id,Model model)throws Exception{
		model.addAttribute("id",id);
		return "mypage/messages/msgSend";
	}
	
	@RequestMapping(value="/msgSend",method=RequestMethod.POST)
	public ResponseEntity<String> msgSendPost(HttpSession session,Criteria cri, InsertMessageVO vo){
		logger.info("메시지 보내는중!!!!");
		ResponseEntity<String> entity = null;
		
		try {
			vo.setSender((String) session.getAttribute("id"));
			logger.info(""+vo);
			service.addMsg(vo);
			entity = new ResponseEntity<>("success",HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>("bad",HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping("/senderContent")
	public String senderContent(int mno, Model model, int page)throws Exception{
		model.addAttribute("messages",service.readSender(mno));
		model.addAttribute("page",page);
		return "mypage/messages/senderContent";
	}
	
	@RequestMapping("/receiverContent")
	public String receiverContent(int mno, Model model,int page)throws Exception{
		model.addAttribute("messages",service.readReceiver(mno));
		model.addAttribute("page",page);
		
		return "mypage/messages/receiverContent";
	}

}
