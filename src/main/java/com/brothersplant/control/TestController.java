package com.brothersplant.control;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/test")
public class TestController {

	@RequestMapping("/category")
	public String categoryPage(){
		
		return "test/categoryTest";
	}
	
	@RequestMapping("/mypage")
	public String myPage(HttpSession session){
		String id = (String) session.getAttribute("id");
		
		if(id != null){
			return "test/myPageTestTravelList";
		} else {
			return "redirect:/login";
		}
	}
	
	@RequestMapping("/testdialog")
	public String dialogTest(){
		
		return "test/dialogTest";
	}
	
	@RequestMapping("/boardTest")
	public String boardTest(HttpSession session){
		
		session.setAttribute("cno", 1);
		
		return "test/boardTest";
	}
	
}
