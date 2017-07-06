package com.brothersplant.control;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.brothersplant.domain.Criteria;
import com.brothersplant.domain.PageMaker;
import com.brothersplant.domain.ReceiverMessagesVO;
import com.brothersplant.domain.SenderMessagesVO;
import com.brothersplant.service.MsgService;

@Controller
public class MessageController {
	
	@Inject
	private MsgService service;
	
	//=======MESSAGE
	@RequestMapping("/mailBox")
	public void mailBox(String page, Model model)throws Exception{
		if(page == null){
			System.out.println("null~~");
			page = "1";
		}
		model.addAttribute("page", Integer.parseInt(page));			
	}
	@RequestMapping("/receiveMailBox")
	public String receiveMailBox(HttpSession session, Criteria cri,Model model, int page)throws Exception{
		System.out.println("수신함 검색");
		session.setAttribute("msg", "receive");
		cri.setPage(page);
		cri.setPerPageNum(20);
		model.addAttribute("messages",service.receiverListCriteria(cri, (String) session.getAttribute("id")));
		PageMaker maker = new PageMaker();
		maker.setCri(cri);
		maker.setTotalCount(service.receiverCountPaging());
		
		model.addAttribute("pageMaker",maker);
		model.addAttribute("page", page);
		
		return "mypage/messages/receiveMailBox";
	}
	
	@RequestMapping("/sendMailBox")
	public String sendMailBox(HttpSession session,Criteria cri,Model model, int page)throws Exception{
		System.out.println("발신함 검색");
		session.setAttribute("msg", "send");
		cri.setPage(page);
		cri.setPerPageNum(20);
		model.addAttribute("messages",service.senderListCriteria(cri, (String) session.getAttribute("id")));
		PageMaker maker = new PageMaker();
		maker.setCri(cri);
		maker.setTotalCount(service.senderCountPaging());
		
		model.addAttribute("pageMaker",maker);
		model.addAttribute("page", page);
		
		return "mypage/messages/sendMailBox";
	}
	

	
	@RequestMapping("/sendRemove")//sendcontent
	public String sendRemove(Model model,int mno,int page)throws Exception{
		System.out.println("삭제될 MNO: "+mno);
		System.out.println("전달된 페이지: "+page);
		model.addAttribute("page",page);
		service.sendDelete(mno);
		return "redirect:/project/mailBox";
	}
	
	@RequestMapping("/receiveRemove")//receivecontent
	public String receiveRemove(Model model,int mno,int page)throws Exception{
		System.out.println("삭제될 MNO: "+mno);
		System.out.println("전달된 페이지: "+page);
		model.addAttribute("page",page);
		service.receiveDelete(mno);
		return "redirect:/project/mailBox";
	}	
	
	@RequestMapping(value="/msgSend",method=RequestMethod.GET)
	public String msgSendGet(String id,Model model)throws Exception{
		model.addAttribute("id",id);
		return "mypage/messages/msgSend";
	}
	@RequestMapping(value="/msgSend",method=RequestMethod.POST)
	public String msgSendPost(Criteria cri,SenderMessagesVO svo,ReceiverMessagesVO rvo)throws Exception{
	
		System.out.println(svo+"+"+rvo);
		
		service.sendMsg(svo);
		service.receiveMsg(rvo);
		return "redirect:/project/mailBox";
		
	}
	
	@RequestMapping("/senderContent")
	public String senderContent(int mno, Model model, int page)throws Exception{
		model.addAttribute("messages",service.readSender(mno));
		model.addAttribute("page",page);
		return "project/senderContent";
	}
	
	@RequestMapping("/receiverContent")
	public String receiverContent(int mno, Model model,int page)throws Exception{
		model.addAttribute("messages",service.readReceiver(mno));
		model.addAttribute("page",page);
		
		return "project/receiverContent";
	}

}
