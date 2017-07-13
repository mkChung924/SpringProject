package com.brothersplant.control;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.brothersplant.aop.InterCeptorLoingCheck;
import com.brothersplant.service.MyPageService;

@RestController
public class MyPageRestController {
	
	@Inject
	private MyPageService service;

	private static final org.slf4j.Logger logger = LoggerFactory.getLogger(InterCeptorLoingCheck.class);
	
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
	@RequestMapping("/alter/{pass}")
	public ResponseEntity<String> update(HttpSession session, @PathVariable("pass") String pass) throws Exception{
		
		ResponseEntity<String> entity = null;
		String id = (String) session.getAttribute("id");
		logger.info("회원정보 수정 시도중, id: "+ id +", pass: " + pass);
		
		String result = service.updateAll(id, pass);
		
		if(result.equals("success")){
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			
		} else if(result.equals("fail")){
			entity = new ResponseEntity<String>("FAIL", HttpStatus.BAD_REQUEST);
		}
		
		return entity;
		
	}
}
