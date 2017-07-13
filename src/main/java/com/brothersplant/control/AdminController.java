package com.brothersplant.control;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.brothersplant.domain.BoardVO;
import com.brothersplant.domain.Criteria;
import com.brothersplant.domain.PageMaker;
import com.brothersplant.domain.SearchCriteria;
import com.brothersplant.domain.SecureVO;
import com.brothersplant.domain.UserInfoVO;
import com.brothersplant.service.AdminPageService;
//import com.brothersplant.service.AdminPageService;
import com.brothersplant.service.BoardInfoService;
import com.brothersplant.service.MyPageService;
import com.brothersplant.service.ReportsService;
import com.brothersplant.service.UserInfoService;

@Controller
public class AdminController {
	
	@Inject
	private MyPageService service;
	@Inject
	private ReportsService reportService;
	@Inject
	private BoardInfoService boardService;
	@Inject
	private AdminPageService adminService;
	@Inject
	private UserInfoService userService;
	
	private static final int PERPAGENUM = 10;
	
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
	
	@RequestMapping(value = "/adminEdit", method = RequestMethod.GET)
	public String myPageEditForm(HttpSession session, SecureVO svo, UserInfoVO pvo, Model model) throws Exception {
		System.out.println("관리자페이지-정보수정 입장");
		String id = (String) session.getAttribute("id");
		if(id != null){
			int auth = (int) session.getAttribute("auth");
			System.out.println(auth);
			
			if(auth == 2){
				
				System.out.println("관리자 my정보: "+service.myPageInfo(id));
				System.out.println(service.secureCode());
				System.out.println(id);
			
				model.addAttribute("mypage", service.myPageInfo(id));
				model.addAttribute("slist", service.secureCode());
			
				return "adminPage/adminPageEdit";
				
			} else {
				
				return "redirect:index";
			}

		
		} else {
			return "redirect:login";
		}
	}
	
	@RequestMapping(value = "/adminEdit", method = RequestMethod.POST)
	public String adminPageEditUpdate(HttpSession session, UserInfoVO vo, 
			String tel1, String tel2, String tel3,
			String postcode, String address, String detailAddress, RedirectAttributes attr) throws Exception {
		System.out.println("관리자페이지-정보수정 입장");
		String id = (String) session.getAttribute("id");
		
		String tel = tel1+"-"+tel2+"-"+tel3;
		String addr = address +"$"+ detailAddress +"$"+postcode;
		
		if(id != null){
			
			vo.setId(id);
			vo.setTel(tel);
			vo.setAddr(addr);
			
			service.updateUser(vo);
			attr.addFlashAttribute("msg", "SUCCESS");
			
			return "redirect:adminEdit";
			
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

/*			System.out.println("페이지:"+ cri.getPage());
			System.out.println("게시물 수: "+cri.getPerPageNum());
			System.out.println("bounds 시작지점: "+cri.getPageStart());
			System.out.println("searchType: " + cri.getSearchType());
			System.out.println("keyword: " + cri.getKeyword());
			System.out.println("관리자 정보: "+service.myPageInfo(id));
			System.out.println("모든 관리자 정보: " + adminService.selectAdminList());
			System.out.println("모든 회원 정보: " + adminService.selectMemeberList(cri));
			System.out.println("검색된 회원 수: " + adminService.selectMemeberList(cri).size());*/
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
	public String reportBox(HttpSession session, SearchCriteria cri, Model model)throws Exception{
		
		System.out.println("관리자페이지-신고함 입장");
		
		String id = (String) session.getAttribute("id");
		int auth = (int) session.getAttribute("auth");
		
		if(id != null){
			
			if(auth == 2){
				
			System.out.println("아이디: " + id + ", 등급: " + auth);
			model.addAttribute("admin", service.myPageInfo(id));
			System.out.println(cri);
			//model.addAttribute("page", cri.getPage());	
			model.addAttribute("cri", cri);
			System.out.println("page: " + cri.getPage());
			System.out.println("perPageNum :" + cri.getPerPageNum());
		
			return "adminPage/adminReport";
			
			} else {
				return "redirect:index";
			}
			
		} else {
			return "redirect:login";
		}
	}
	//신고 목록이 댓글일때
	@RequestMapping(value="/replyReportBox" ,method=RequestMethod.POST)
	public String replyReportsBox(HttpSession session,SearchCriteria cri, Model model, int page)throws Exception{
		session.setAttribute("msg", "reply");
		System.out.println("댓글 신고 목록 가져오는 중");
		System.out.println("cri: " + cri);
		System.out.println("페이지:"+ cri.getPage());
		System.out.println("게시물 수: "+cri.getPerPageNum());
		System.out.println("bounds 시작지점: "+cri.getPageStart());
		System.out.println("searchType: " + cri.getSearchType());
		System.out.println("keyword: " + cri.getKeyword());
		cri.setPage(page);
		cri.setPerPageNum(PERPAGENUM);
		model.addAttribute("messages",reportService.listSearchCriteria(cri,2));
		System.out.println(reportService.listSearchCriteria(cri,2));
		PageMaker maker = new PageMaker();
		maker.setCri(cri);
		maker.setTotalCount(reportService.countPaging(cri,2));
		
		model.addAttribute("pageMaker",maker);
		model.addAttribute("page", page);
		model.addAttribute("cri", cri);
		
		return "adminPage/reports/replyReportBox";
	}
	
	//신고 목록이 게시글일때
	@RequestMapping(value="/tableReportBox",method=RequestMethod.POST)
	public String tableReportBox(HttpSession session,SearchCriteria cri,Model model, int page)throws Exception{
		session.setAttribute("msg", "table");
		System.out.println("게시글");
		System.out.println("cri: " + cri);
		System.out.println("페이지:"+ cri.getPage());
		System.out.println("게시물 수: "+cri.getPerPageNum());
		System.out.println("bounds 시작지점: "+cri.getPageStart());
		System.out.println("searchType: " + cri.getSearchType());
		System.out.println("keyword: " + cri.getKeyword());
		cri.setPage(page);
		cri.setPerPageNum(PERPAGENUM);
		model.addAttribute("tablereport",reportService.listSearchCriteria(cri,1));
		System.out.println(reportService.listSearchCriteria(cri,1));
		PageMaker maker = new PageMaker();
		maker.setCri(cri);
		maker.setTotalCount(reportService.countPaging(cri,1));
		
		model.addAttribute("pageMaker",maker);
		model.addAttribute("page", page);
		model.addAttribute("cri", cri);
		
		
		return "adminPage/reports/tableReportBox";
	}

	@RequestMapping(value="/adminWrite", method=RequestMethod.GET)
	public String adminWrite(HttpSession session, Model model) throws Exception{
		String id = (String) session.getAttribute("id");
		model.addAttribute("admin", service.myPageInfo(id));
		return "adminPage/adminWrite";
	};
	@RequestMapping(value = "admin_regit", method=RequestMethod.POST)
	public String insertBoard2(BoardVO vo, MultipartFile file) throws Exception{
		String content = vo.getContent();
		int start = content.indexOf("/resources/");
		int end = content.indexOf(" alt=\"/")-1;
		vo.setImage(content.substring(start,end));
		System.out.println(vo.toString());
		boardService.insertBoard(vo);
		System.out.println("===등록 완료===");
		return "redirect:/admin";
	}
	
	@RequestMapping("/adminBoardsList")
	public String adminBoardsList(HttpSession session, Model model) throws Exception{
		
		String id = (String) session.getAttribute("id");
		int auth = (int) session.getAttribute("auth");
		
		if(id != null){
			
			if(auth == 2){
				model.addAttribute("admin", service.myPageInfo(id));
				model.addAttribute("list",adminService.selectBoardsCountList());
				
				return "adminPage/adminBoardsList";
				
				
			} else { //회원이 관리자 페이지를 임의로 접속하였을시
				return "redirect:index";
			}
			
		} else { //세션이 없으면 로그인화면
			return "redirect:login";
		}
	}
	
	@RequestMapping("/categoryDetail")
	public String listCategory(HttpSession session, Model model,SearchCriteria cri) throws Exception{
		System.out.println("카테고리 디테일 페이지 입장");
		String id = (String) session.getAttribute("id");
		int auth = (int) session.getAttribute("auth");
		System.out.println("아이디: " + id + ", 등급: " + auth);
		
		if(id != null){
			
			if(auth == 2){
				
				System.out.println("cri: " + cri);
				System.out.println("페이지:"+ cri.getPage());
				System.out.println("게시물 수: "+cri.getPerPageNum());
				System.out.println("bounds 시작지점: "+cri.getPageStart());
				System.out.println("searchType: " + cri.getSearchType());
				System.out.println("keyword: " + cri.getKeyword());
				System.out.println("선택된 카테고리 디테일: " + cri.getCno());
				System.out.println("카테고리의 게시글 수: "+ adminService.selectCategoryDetail(cri).size());
				System.out.println("카테고리: "+ adminService.selectCnoList(cri).size());
				
				PageMaker pageMaker = new PageMaker();
				pageMaker.setCri(cri);
				pageMaker.setTotalCount(adminService.selectCategoryDetailCount(cri));
				
				model.addAttribute("list", adminService.selectCategoryDetail(cri));
				model.addAttribute("map", adminService.selectCnoList(cri));
				model.addAttribute("cno",cri.getCno());
				model.addAttribute("pageMaker", pageMaker);
				model.addAttribute("cri", cri);
				
				return "adminPage/detail/detail";
				
			} else {
				return "redirect:index";
			}
			
			
		} else {
			return "redirect:login";
		}
				
	}
	
	@RequestMapping("/adminWroteContents")
	public String myContents(HttpSession session, Model model,Criteria cri) throws Exception {
		System.out.println("관리자-내글보기 입장");
		String id = (String) session.getAttribute("id");
		int auth = (int) session.getAttribute("auth");
		if(id != null){
			
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(boardService.iwroteTOTCnt(id));	
			
		model.addAttribute("mypage", service.myPageInfo(id));
		model.addAttribute("myboardList",boardService.iwrote(id,cri));
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("cri", cri);
		return "adminPage/adminMyboardList";
		} else {
			return "redirect:login";
		}
	}
	//관리자가 쓴 여행 추천 게시글 보기
	@RequestMapping(value="/adminTravelRead",method=RequestMethod.GET)
	public String adminTravel(HttpSession session, Model model,int tbno,SearchCriteria cri) throws Exception {
		model.addAttribute("commonBoard",boardService.selectCommonRow(tbno,(String)session.getAttribute("id")));
		model.addAttribute("profile",userService.selectprofile((String)session.getAttribute("id")));
		
		//페이징 버튼만 만들어 주고 데이터는 ajax로 
		String id = (String) session.getAttribute("id");
		cri.setId(id);
		cri.setPerPageNum(3);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(boardService.countTravelReviewList(cri));				
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("cri", cri);
		
		//조회수
		boardService.addViewCnt(tbno);
		
		return "adminPage/adminTravelRead";
	}

	@RequestMapping(value="/adminTravelUpdate",method=RequestMethod.GET)
	public String adminTravelUpdate(int tbno,HttpSession session,Model model) throws Exception{
		model.addAttribute("travelRow",boardService.selectCommonRow(tbno, (String)session.getId()));
		return "adminPage/adminTravelUpdate";
	}
	
	@RequestMapping("/adminFavorite")
	public String myPageFavorite(HttpSession session, Model model) throws Exception {
		System.out.println("즐겨찾기 입장");
		String id = (String) session.getAttribute("id");
		int auth = (int) session.getAttribute("auth");
		
		if(id != null){
			
			if(auth == 2){
				System.out.println("my정보: "+service.myPageInfo(id));
				System.out.println(service.secureCode());
				System.out.println(id);
				
				model.addAttribute("mypage", service.myPageInfo(id));
				System.out.println(service.getMyBookmarks(id));
				model.addAttribute("bookmark", service.getMyBookmarks(id));
				
				return "adminPage/adminFavorite";
				
			} else {
				return "redirect:index";
			}
			
		} else {
			return "redirect:login";
		}

	}
}
