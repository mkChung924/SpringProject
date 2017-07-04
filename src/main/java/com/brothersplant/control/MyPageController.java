package com.brothersplant.control;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.brothersplant.domain.SecureVO;
import com.brothersplant.domain.UserInfoVO;
import com.brothersplant.service.MyPageService;

@Controller
public class MyPageController {
	
	@Inject
	private MyPageService service;
	
	
	@RequestMapping("/mypage")
	public String myPage(HttpSession session, Model model) throws Exception {
		System.out.println("마이페이지-내글보기 입장");
		String id = (String) session.getAttribute("id");
		if(id != null){
			System.out.println("my정보: "+service.myPageInfo(id));
			System.out.println(service.secureCode());
			System.out.println(id);
			
			model.addAttribute("mypage", service.myPageInfo(id));
			
			return "mypage/myInfo";
		} else {
			return "redirect:login";
		}
	}
	
	@RequestMapping("/myContents")
	public String myContents(HttpSession session, Model model) throws Exception {
		System.out.println("마이페이지-내글보기 입장");
		String id = (String) session.getAttribute("id");
		if(id != null){
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
		if(id != null){
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
		} else {
			return "redirect:login";
		}
	}
	
	@RequestMapping(value = "/mypageEdit", method = RequestMethod.GET)
	public String myPageEditForm(HttpSession session, SecureVO svo, UserInfoVO pvo, Model model) throws Exception {
		System.out.println("정보수정 입장");
		String id = (String) session.getAttribute("id");
		if(id != null){
		System.out.println("my정보: "+service.myPageInfo(id));
		System.out.println(service.secureCode());
		System.out.println(id);
		
		model.addAttribute("mypage", service.myPageInfo(id));
		model.addAttribute("slist", service.secureCode());
		
		return "mypage/myPageEdit";
		} else {
			return "redirect:login";
		}
	}

	@RequestMapping(value = "/mypageEdit", method = RequestMethod.POST)
	public String myPageEdit(HttpSession session, UserInfoVO vo, Model model) throws Exception {
		String id = (String) session.getAttribute("id");
		if(id != null){
		vo.setId(id);
		service.updateUser(vo);
				
		return "redirect:myPageEdit";
		} else {
			return "redirect:login";
		}
	}
	
	
	@RequestMapping("/favorite")
	public String myPageFavorite(HttpSession session, Model model) throws Exception {
		System.out.println("즐겨찾기 입장");
		String id = (String) session.getAttribute("id");
		if(id != null){
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
		if(id != null){
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
