package com.brothersplant.control;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.brothersplant.service.MyPageService;

@RestController
public class MyPageRestController {
	
	@Inject
	private MyPageService service;

	@RequestMapping("/tal")
	public ResponseEntity<String> delete(HttpSession session, String pass) throws Exception{
		
		ResponseEntity<String> entity = null;
		String id = (String) session.getAttribute("id");
		String result = service.deleteAll(id, pass);
		
		if(result.equals("success")){
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			
		} else if(result.equals("fail")){
			entity = new ResponseEntity<String>("FAIL", HttpStatus.BAD_REQUEST);
		}

		return entity;
		
	}
	@RequestMapping("/alter")
	public ResponseEntity<String> update(HttpSession session, String pass) throws Exception{
		
		ResponseEntity<String> entity = null;
		String id = (String) session.getAttribute("id");
		//model.addAttribute("mypage",service.myEditForm(id));
		String result = service.updateAll(id, pass);
		
		if(result.equals("success")){
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			
		} else if(result.equals("fail")){
			entity = new ResponseEntity<String>("FAIL", HttpStatus.BAD_REQUEST);
		}
		
		return entity;
		
	}
}
