package com.brothersplant.control;

import java.io.File;
import java.text.DateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.brothersplant.domain.UserInfoVO;
import com.brothersplant.service.UserInfoService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Inject
	private UserInfoService service;
	
	//카테고리 페이지(index.jsp) : 로그인된 상태가 아니라면 로그인 페이지로 redirect 된다.
	@RequestMapping("/index")
	public String index(HttpSession session){
		
		System.out.println("index들어옴");
		String id = (String) session.getAttribute("id");
		if(id != null){
			return "main/index";
		} else {
			return "redirect:login";
		}
	}
	
	/*
	 * 로그인
	 */
	@RequestMapping(value= "/login", method = RequestMethod.GET)
	public String loginPage(HttpSession session, RedirectAttributes attr){
		String id = (String) session.getAttribute("id");
		
		if(id != null){
			
			return "redirect:index";
		} else {
			
			return "main/loginPage";
		}
		 
	}
	
	@RequestMapping(value= "/login", method = RequestMethod.POST)
	public String tryLogin(HttpSession session, String id, String pass){
		
		System.out.println("login post 들어옴");
		System.out.println(id + ", " + pass);
		session.setAttribute("id", id);
	 
		return "redirect:index";
	}
	
	/*
	 * 로그아웃
	 */
	@RequestMapping("/logout")
	public String logout(HttpSession session){
		session.invalidate();
		
		return "redirect:login";
	}
	
	/*
	 * 회원가입
	 */
	@RequestMapping(value="/signUp", method=RequestMethod.POST)
	public String signUp(HttpServletRequest request, UserInfoVO vo, 
			String tel1, String tel2, String tel3,
			String postcode, String address, String detailAddress,
			RedirectAttributes attr) {
		System.out.println("/signUp");
		
		String tel = tel1+"-"+tel2+"-"+tel3;
		String addr = address +"$"+ detailAddress +"$"+postcode;
		
		try {
			MultipartHttpServletRequest m = (MultipartHttpServletRequest) request;
			
			
			Iterator<String> iterator = m.getFileNames();
			System.out.println("getFileNames:::"+ iterator);
			MultipartFile multipartFile = null;
			String filePath = "/Users/myungkyuchung/Documents/workspace/SpringProject/src/main/webapp/resources/upload";
			
			File file = new File(filePath+"/"+vo.getId());
			
			while(iterator.hasNext()){
				System.out.println("폴더 존재 여부: "+file.exists());
				if(!file.exists()) file.mkdirs();
				System.out.println("폴더 존재 여부: "+file.exists());
			    multipartFile = m.getFile(iterator.next());
			    if(!multipartFile.isEmpty()){
			    	File serverFile = new File(filePath + "/" + vo.getId() +"/"+ multipartFile.getOriginalFilename());
			    	multipartFile.transferTo(serverFile);
			    	vo.setProfile(multipartFile.getOriginalFilename());
			    }
			}

			vo.setTel(tel);
			vo.setAddr(addr);

			
			if(vo.getProfile() == null){
				vo.setProfile("default.png");
			}

			System.out.println("회원정보: " + vo);
			
			service.create(vo);
			attr.addFlashAttribute("msg", "SUCCESS");
			
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		
		return "redirect:login";
	}
	
	/*
	 * id 중복확인창
	 */
	@RequestMapping("/idCheck")
	public String idCheck(){
		
		return "main/idCheck";
	}
	
	
}
