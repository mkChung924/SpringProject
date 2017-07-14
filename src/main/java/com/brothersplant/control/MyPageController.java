package com.brothersplant.control;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.brothersplant.aop.InterCeptorLoingCheck;
import com.brothersplant.domain.Criteria;
import com.brothersplant.domain.PageMaker;
import com.brothersplant.domain.SecureVO;
import com.brothersplant.domain.UserInfoVO;
import com.brothersplant.service.BoardInfoService;
import com.brothersplant.service.MyPageService;
import com.brothersplant.service.UserInfoService;

@Controller
public class MyPageController {
	
	@Inject
	private MyPageService service;
	
	@Inject
	private UserInfoService userService;
	
	@Inject 
	private BoardInfoService boardService;
	
	private static final org.slf4j.Logger logger = LoggerFactory.getLogger(InterCeptorLoingCheck.class);
	
	@RequestMapping("/mypage")
	public String myPage(HttpSession session, Model model) throws Exception {
		logger.info("마이페이지-내글보기 입장");
		String id = (String) session.getAttribute("id");
		
		if(id != null){
				int auth = (int) session.getAttribute("auth");
			
				if(auth != 2){
				
				List<HashMap<String, String>> isYou = userService.isYoublacklist(id);
				int penalty_cnt =Integer.parseInt(String.valueOf( isYou.get(0).get("PENALTY_CNT")));
				int state =Integer.parseInt(String.valueOf( isYou.get(0).get("STATE")));
				service.myPageInfo(id).setState(state);
				
				model.addAttribute("mypage", service.myPageInfo(id));
				model.addAttribute("userState", state);
				model.addAttribute("userPenaltyCnt", penalty_cnt);
				return "mypage/myInfo";
			
			} else {
				return "redirect:index";
			}
		} else {
			return "redirect:login";
		}
	}
	
	@RequestMapping("/myContents")
	public String myContents(HttpSession session, Model model,Criteria cri) throws Exception {
		logger.info("마이페이지-내글보기 입장");
		String id = (String) session.getAttribute("id");
		if(id != null){
			int auth = (int) session.getAttribute("auth");
			
			if(auth != 2){
			
				PageMaker pageMaker = new PageMaker();
				pageMaker.setCri(cri);
				pageMaker.setTotalCount(boardService.iwroteTOTCnt(id));	
					
				model.addAttribute("mypage", service.myPageInfo(id));
				model.addAttribute("myboardList",boardService.iwrote(id,cri));
				model.addAttribute("pageMaker", pageMaker);
				model.addAttribute("cri", cri);
				return "mypage/myPageBoardList";
			} else {
				
				return "redirect:index";
				
			}
		} else {
			return "redirect:login";
		}
	}
	
	@RequestMapping("/message")
	public String myPageMessage(HttpSession session, Model model, String page) throws Exception {
		logger.info("메시지 입장");
		String id = (String) session.getAttribute("id");
		if(id != null){
			
			int auth = (int) session.getAttribute("auth");
			
			if(auth != 2){
				
				logger.info("my정보: "+service.myPageInfo(id));
				logger.info(""+service.secureCode());
				logger.info(id);
				
				model.addAttribute("mypage", service.myPageInfo(id));
				
				String mpage ="";
				if(session.getAttribute("page") != null){
					int npage = (int) session.getAttribute("page");
					mpage = String.valueOf(npage);
				}
				
				if(mpage == null || mpage.isEmpty()){
					page ="1";
				} else {
					page = mpage;
				}

				model.addAttribute("page", Integer.parseInt(page));		
				
				return "mypage/myPageMessage";
				
			} else {
				logger.info("관리자 정보: "+service.myPageInfo(id));
				
				model.addAttribute("admin", service.myPageInfo(id));
				
				if(page == null){
					logger.info("null~~");
					page = "1";
				}
				model.addAttribute("page", Integer.parseInt(page));		
				
				return "adminPage/adPageMessage";
			}

			
		}  else {
			return "redirect:login";
		}
	}
	
	@RequestMapping(value = "/mypageEdit", method = RequestMethod.GET)
	public String myPageEditForm(HttpSession session, SecureVO svo, UserInfoVO pvo, Model model) throws Exception {
		logger.info("정보수정 입장");
		String id = (String) session.getAttribute("id");
		int auth = (int) session.getAttribute("auth");
		logger.info(""+auth);
		if(id != null && auth != 2){
			
			logger.info("my정보: "+service.myPageInfo(id));
			logger.info(""+service.secureCode());
			logger.info(id);
		
			model.addAttribute("mypage", service.myPageInfo(id));
			model.addAttribute("slist", service.secureCode());
		
			return "mypage/myPageEdit";
		
		} else if(auth == 2){
			return "redirect:admin";
		} else {
			return "redirect:login";
		}
	}

	@RequestMapping(value = "/mypageEdit", method = RequestMethod.POST)
	public String myPageEdit(HttpSession session, UserInfoVO vo, 
			String tel1, String tel2, String tel3,
			String postcode, String address, String detailAddress, RedirectAttributes attr) throws Exception {
		
		String id = (String) session.getAttribute("id");
		
		String tel = tel1+"-"+tel2+"-"+tel3;
		String addr = address +"$"+ detailAddress +"$"+postcode;
		
		if(id != null){
			
			vo.setId(id);
			vo.setTel(tel);
			vo.setAddr(addr);
			service.updateUser(vo);
			attr.addFlashAttribute("msg", "SUCCESS");
			session.setAttribute("nick", vo.getNickname());//회원정보 수정 후 오른쪽 상단에 표시되는 닉네임 수정
			return "redirect:mypageEdit";
			
		} else {
			return "redirect:login";
			
		}
	}
	
	
	@RequestMapping("/favorite")
	public String myPageFavorite(HttpSession session, Model model) throws Exception {
		logger.info("즐겨찾기 입장");
		String id = (String) session.getAttribute("id");
		int auth = (int) session.getAttribute("auth");
		
		if(id != null){
			
			if(auth != 2){
				logger.info("my정보: "+service.myPageInfo(id));
				logger.info(""+service.secureCode());
				logger.info(id);
				
				model.addAttribute("mypage", service.myPageInfo(id));
				logger.info(""+service.getMyBookmarks(id));
				model.addAttribute("bookmark", service.getMyBookmarks(id));
				
				return "mypage/myPageFavorite";
			} else {
				return "redirect:index";
			}
			
		} else {
			return "redirect:login";
		}

	}
	
	@RequestMapping("/del")
	public String myPageRemove(HttpSession session, Model model) throws Exception {
		logger.info("회원탈퇴 입장");
		String id = (String) session.getAttribute("id");
		int auth = (int) session.getAttribute("auth");
		if(id != null && auth != 2){
		logger.info("my정보: "+service.myPageInfo(id));
		logger.info(""+service.secureCode());
		logger.info(id);
		
		model.addAttribute("mypage", service.myPageInfo(id));
		
		return "mypage/myPageRemove";
		} else {
			return "redirect:login";
		}
	}
	
	@RequestMapping(value= "/del", method = RequestMethod.POST)
	public String remove(HttpSession session, String password) throws Exception {
		logger.info("회원 삭제 중");
		String id = (String) session.getAttribute("id");
		
		if(id != null){
		service.removeAll(id);
		session.invalidate();
		logger.info(id + "삭제됨");
		
		return "redirect:login";
		} else {
			return "redirect:login";
		}
	}

	
}
