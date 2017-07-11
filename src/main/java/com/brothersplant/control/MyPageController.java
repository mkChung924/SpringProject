package com.brothersplant.control;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.brothersplant.domain.SecureVO;
import com.brothersplant.domain.UserInfoVO;
import com.brothersplant.service.MyPageService;
import com.brothersplant.service.UserInfoService;

@Controller
public class MyPageController {
	
	@Inject
	private MyPageService service;
	
	@Inject
	private UserInfoService userService;
	
	
	@RequestMapping("/mypage")
	public String myPage(HttpSession session, Model model) throws Exception {
		System.out.println("마이페이지-내글보기 입장");
		String id = (String) session.getAttribute("id");
		String pw = service.myPageInfo(id).getPassword();
		
		int auth = (int) session.getAttribute("auth");
		if(id != null && auth != 2){
			List<HashMap<String, String>> isYou = userService.isYoublacklist(id, pw);
			int penalty_cnt =Integer.parseInt(String.valueOf( isYou.get(0).get("PENALTY_CNT")));
			int state =Integer.parseInt(String.valueOf( isYou.get(0).get("STATE")));
			service.myPageInfo(id).setState(state);
			
			model.addAttribute("mypage", service.myPageInfo(id));
			model.addAttribute("userState", state);
			model.addAttribute("userPenaltyCnt", penalty_cnt);
			return "mypage/myInfo";
		} else {
			return "redirect:login";
		}
	}
	
	@RequestMapping("/myContents")
	public String myContents(HttpSession session, Model model) throws Exception {
		System.out.println("마이페이지-내글보기 입장");
		String id = (String) session.getAttribute("id");
		int auth = (int) session.getAttribute("auth");
		if(id != null && auth != 2){
		System.out.println("my정보: "+service.myPageInfo(id));
		System.out.println(service.secureCode());
		System.out.println(id);
		
		model.addAttribute("mypage", service.myPageInfo(id));
		
		return "mypage/myPageTravelList";
		} else {
			return "redirect:login";
		}
	}
	
	@RequestMapping("/message")
	public String myPageMessage(HttpSession session, Model model, String page) throws Exception {
		System.out.println("메시지 입장");
		String id = (String) session.getAttribute("id");
		int auth = (int) session.getAttribute("auth");
		if(id != null && auth != 2){
			System.out.println("my정보: "+service.myPageInfo(id));
			System.out.println(service.secureCode());
			System.out.println(id);
			
			model.addAttribute("mypage", service.myPageInfo(id));
			
			if(page == null){
				System.out.println("null~~");
				page = "1";
			}
			model.addAttribute("page", Integer.parseInt(page));		
			
			return "mypage/myPageMessage";
			
		} else if(id != null && auth == 2){ 
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
	
	@RequestMapping(value = "/mypageEdit", method = RequestMethod.GET)
	public String myPageEditForm(HttpSession session, SecureVO svo, UserInfoVO pvo, Model model) throws Exception {
		System.out.println("정보수정 입장");
		String id = (String) session.getAttribute("id");
		int auth = (int) session.getAttribute("auth");
		System.out.println(auth);
		if(id != null && auth != 2){
			
			System.out.println("my정보: "+service.myPageInfo(id));
			System.out.println(service.secureCode());
			System.out.println(id);
		
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
			return "redirect:mypageEdit";
			
		} else {
			return "redirect:login";
			
		}
	}
	
	
	@RequestMapping("/favorite")
	public String myPageFavorite(HttpSession session, Model model) throws Exception {
		System.out.println("즐겨찾기 입장");
		String id = (String) session.getAttribute("id");
		int auth = (int) session.getAttribute("auth");
		if(id != null && auth != 2){
		System.out.println("my정보: "+service.myPageInfo(id));
		System.out.println(service.secureCode());
		System.out.println(id);
		
		model.addAttribute("mypage", service.myPageInfo(id));
		System.out.println(service.getMyBookmarks(id));
		model.addAttribute("bookmark", service.getMyBookmarks(id));
		
		return "mypage/myPageFavorite";
		} else {
			return "redirect:login";
		}
	}
	
	@RequestMapping("/del")
	public String myPageRemove(HttpSession session, Model model) throws Exception {
		System.out.println("회원탈퇴 입장");
		String id = (String) session.getAttribute("id");
		int auth = (int) session.getAttribute("auth");
		if(id != null && auth != 2){
		System.out.println("my정보: "+service.myPageInfo(id));
		System.out.println(service.secureCode());
		System.out.println(id);
		
		model.addAttribute("mypage", service.myPageInfo(id));
		
		return "mypage/myPageRemove";
		} else {
			return "redirect:login";
		}
	}
	
	@RequestMapping(value= "/del", method = RequestMethod.POST)
	public String remove(HttpSession session, String password) throws Exception {
		System.out.println("회원 삭제 중");
		String id = (String) session.getAttribute("id");
		
		if(id != null){
		service.removeAll(id);
		session.invalidate();
		System.out.println(id + "삭제됨");
		
		return "redirect:login";
		} else {
			return "redirect:login";
		}
	}

	
}
