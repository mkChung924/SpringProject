package com.brothersplant.control;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.brothersplant.domain.Criteria;
import com.brothersplant.domain.PageMaker;
import com.brothersplant.domain.TableReportVO;
import com.brothersplant.service.MyPageService;
import com.brothersplant.service.ReportsService;

@Controller
public class AdminController {
	
	@Inject
	private MyPageService service;
	@Inject
	private ReportsService service2;
	
	@RequestMapping("/admin")
	public String admin(HttpSession session, Model model) throws Exception{
		
		System.out.println("관리자페이지-입장");
		String id = (String) session.getAttribute("id");
		int auth = (int) session.getAttribute("auth");
		System.out.println("아이디: " + id + ", 등급: " + auth);
		
		if(id != null && auth == 2){
			System.out.println("관리자 정보: "+service.myPageInfo(id));
			//System.out.println(service.secureCode());
			
			model.addAttribute("admin", service.myPageInfo(id));
			
			return "adminPage/adminInfo";
			
		} else {
			return "redirect:login";
		}

	}
	
	@RequestMapping("/admessage")
	public String myPageMessage(HttpSession session, Model model, String page) throws Exception {
		System.out.println("메시지 입장");
		String id = (String) session.getAttribute("id");
		int auth = (int) session.getAttribute("auth");
		System.out.println("아이디: " + id + ", 등급: " + auth);
		
		if(id != null && auth == 2){
			System.out.println("관리자 정보: "+service.myPageInfo(id));
			
			model.addAttribute("admin", service.myPageInfo(id));
			
			if(page == null){
				System.out.println("null~~");
				page = "1";
			}
			model.addAttribute("page", Integer.parseInt(page));		
			
			return "adminPage/adPageMessage";
		} else {
			return "redirect:login";
		}
	}
	
	
	
	
	
	
	
	
	
	
	////신고함 - 게시글
	
	@RequestMapping("/reportBox")
	public void reportBox(String page, Model model)throws Exception{
		if(page == null){
			page = "1";
		}
		model.addAttribute("page", Integer.parseInt(page));			
	}
	
	@RequestMapping("/tableReportBox")
	public String tableReportBox(HttpSession session,Criteria cri,Model model, int page)throws Exception{
		session.setAttribute("msg", "table");
		cri.setPage(page);
		cri.setPerPageNum(20);
		model.addAttribute("tablereport",service2.tableReportListCriteria(cri));
		PageMaker maker = new PageMaker();
		maker.setCri(cri);
		maker.setTotalCount(service2.tableReportCountPaging());
		
		model.addAttribute("pageMaker",maker);
		model.addAttribute("page", page);
		
		return "project/tableReportBox";
	}
	
	@RequestMapping("/tableReportContent")
	public String tableReportContent(int trno, Model model, int page)throws Exception{
		model.addAttribute("tablereport",service2.readTableReport(trno));
		model.addAttribute("page",page);
		return "project/tableReportContent";
	}
	
	@RequestMapping("/tableReportRemove")//receivecontent
	public String tableReportRemove(Model model,int trno,int page)throws Exception{
		model.addAttribute("page",page);
		service2.tableReportRemove(trno);
		return "redirect:/project/reportBox";
	}

	@RequestMapping(value="/tableReport",method=RequestMethod.POST)
	public String tableReportPost(Criteria cri,TableReportVO vo)throws Exception{
	
		System.out.println(vo);
		
		service2.tableReport(vo);
	
		return "redirect:/project/reportBox";
		
	}

	@RequestMapping("/tableDelete")
	public String tableDelete(Model model,int tbno,int page)throws Exception{
		model.addAttribute("page",page);
		service2.tableDelete(tbno);
		return "redirect:/project/reportBox";
	}

	
	@RequestMapping("/replyReportBox")
	public String replyReportsBox(HttpSession session,Criteria cri,Model model, int page)throws Exception{
		session.setAttribute("msg", "reply");
		cri.setPage(page);
		cri.setPerPageNum(20);
		model.addAttribute("messages",service2.replyListCriteria(cri));
		PageMaker maker = new PageMaker();
		maker.setCri(cri);
		maker.setTotalCount(service2.replyCountPaging());
		
		model.addAttribute("pageMaker",maker);
		model.addAttribute("page", page);
		
		return "project/replyReportBox";
	}
	
	
	@RequestMapping("/replyRemove")//receivecontent
	public String replyRemove(Model model,int rno,int page)throws Exception{
		System.out.println("삭제될 MNO: "+rno);
		System.out.println("전달된 페이지: "+page);
		model.addAttribute("page",page);
		service2.replyRemove(rno);
		return "redirect:/project/reportBox";
	}
	
	@RequestMapping("/replyContent")
	public String replyContent(int rno, Model model, int page)throws Exception{
		model.addAttribute("messages",service2.readReply(rno));
		model.addAttribute("page",page);
		return "project/replyContent";
	}

}
