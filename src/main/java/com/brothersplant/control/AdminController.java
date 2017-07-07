package com.brothersplant.control;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.brothersplant.domain.BoardVO;
import com.brothersplant.domain.Criteria;
import com.brothersplant.domain.PageMaker;
import com.brothersplant.domain.SearchCriteria;
import com.brothersplant.domain.TableReportVO;
import com.brothersplant.persistence.BoardInfoDAO;
import com.brothersplant.service.AdminPageService;
import com.brothersplant.service.BoardInfoService;
import com.brothersplant.service.MyPageService;
import com.brothersplant.service.ReportsService;

@Controller
public class AdminController {
	
	@Inject
	private MyPageService service;
	@Inject
	private ReportsService service2;
	@Inject
	private BoardInfoService boardService;
	@Inject
	private AdminPageService adminService;
	
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
	
	//회원현황
	@RequestMapping("/memList")
	public String memList(HttpSession session, Model model, SearchCriteria cri) throws Exception{
		
		System.out.println("관리자페이지-회원현황입장");
		String id = (String) session.getAttribute("id");
		int auth = (int) session.getAttribute("auth");
		System.out.println("아이디: " + id + ", 등급: " + auth);
		
		if(id != null && auth == 2){

			System.out.println("페이지:"+ cri.getPage());
			System.out.println("게시물 수: "+cri.getPerPageNum());
			System.out.println("bounds 시작지점: "+cri.getPageStart());
			System.out.println("searchType: " + cri.getSearchType());
			System.out.println("keyword: " + cri.getKeyword());
			System.out.println("관리자 정보: "+service.myPageInfo(id));
			System.out.println("모든 관리자 정보: " + adminService.selectAdminList());
			System.out.println("모든 회원 정보: " + adminService.selectMemeberList(cri));
			System.out.println("검색된 회원 수: " + adminService.selectMemeberList(cri).size());
			//System.out.println(service.secureCode());
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);
			pageMaker.setTotalCount(adminService.selectMemberCount(cri));
			
			model.addAttribute("admin", service.myPageInfo(id));
			model.addAttribute("adminlist", adminService.selectAdminList());
			model.addAttribute("memlist", adminService.selectMemeberList(cri));
			model.addAttribute("pageMaker", pageMaker);
			model.addAttribute("cri", cri);
			
			return "adminPage/adminMemberList";
			
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
			model.addAttribute("admin", service.myPageInfo(id));
			
			return "adminPage/adPageMessage";
		} else {
			return "redirect:login";
		}
	}
	
	////신고함 - 게시글
	
	@RequestMapping("/reportBox")
	public String reportBox(HttpSession session, String page, Model model)throws Exception{
		if(page == null){
			page = "1";
		}
		model.addAttribute("page", Integer.parseInt(page));	
		System.out.println("관리자페이지-신고함 입장");
		
		String id = (String) session.getAttribute("id");
		int auth = (int) session.getAttribute("auth");
		
		if(id != null && auth == 2){
			System.out.println("아이디: " + id + ", 등급: " + auth);
			model.addAttribute("admin", service.myPageInfo(id));
		
			return "adminPage/adminReport";
			
		} else {
			return "redirect:login";
		}
	}
	
	@RequestMapping("/tableReportBox")
	public String tableReportBox(HttpSession session,Criteria cri,Model model, int page)throws Exception{
		System.out.println("tableReportBox");
		session.setAttribute("msg", "table");
		cri.setPage(page);
		cri.setPerPageNum(20);
		model.addAttribute("tablereport",service2.tableReportListCriteria(cri));
		PageMaker maker = new PageMaker();
		maker.setCri(cri);
		maker.setTotalCount(service2.tableReportCountPaging());
		
		model.addAttribute("pageMaker",maker);
		model.addAttribute("page", page);
		
		return "adminPage/reports/tableReportBox";
	}
	
	@RequestMapping("/tableReportContent")
	public String tableReportContent(int trno, Model model, int page)throws Exception{
		model.addAttribute("tablereport",service2.readTableReport(trno));
		model.addAttribute("page",page);
		return "adminPage/reports/tableReportContent";
	}
	
	@RequestMapping("/tableReportRemove")//receivecontent
	public String tableReportRemove(Model model,int trno,int page)throws Exception{
		model.addAttribute("page",page);
		service2.tableReportRemove(trno);
		return "redirect:reportBox";
	}

	@RequestMapping(value="/tableReport",method=RequestMethod.POST)
	public String tableReportPost(Criteria cri,TableReportVO vo)throws Exception{
	
		System.out.println(vo);
		
		service2.tableReport(vo);
	
		return "redirect:reportBox";
		
	}

	@RequestMapping("/tableDelete")
	public String tableDelete(Model model,int tbno,int page)throws Exception{
		model.addAttribute("page",page);
		service2.tableDelete(tbno);
		return "redirect:reportBox";
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
		
		return "adminPage/reports/replyReportBox";
	}
	
	
	@RequestMapping("/replyRemove")//receivecontent
	public String replyRemove(Model model,int rno,int page)throws Exception{
		System.out.println("삭제될 MNO: "+rno);
		System.out.println("전달된 페이지: "+page);
		model.addAttribute("page",page);
		service2.replyRemove(rno);
		return "redirect:reportBox";
	}
	
	@RequestMapping("/replyContent")
	public String replyContent(int rno, Model model, int page)throws Exception{
		model.addAttribute("messages",service2.readReply(rno));
		model.addAttribute("page",page);
		return "adminPage/reports/replyContent";
	}

	@RequestMapping(value="/adminWrite", method=RequestMethod.GET)
	public String adminWrite(HttpSession session, Model model) throws Exception{
		String id = (String) session.getAttribute("id");
		model.addAttribute("admin", service.myPageInfo(id));
		return "adminPage/adminWrite";
	};
	
	@RequestMapping(value = "admin_regit", method=RequestMethod.POST)
	public String insertBoard2(BoardVO vo, MultipartFile file) throws Exception{
		System.out.println(vo.toString());
		boardService.insertBoard(vo);
		System.out.println("===등록 완료===");
		return "redirect:/admin";
	}

}
