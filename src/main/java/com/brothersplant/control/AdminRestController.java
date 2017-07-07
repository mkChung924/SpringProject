package com.brothersplant.control;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.brothersplant.service.AdminPageService;

@RestController
public class AdminRestController {
	
	@Inject
	private AdminPageService service;
	
	@RequestMapping("/upgrade")
	public ResponseEntity<String> upgrade(String id){
		System.out.println("등업되는 아이디: "+id);
		
		ResponseEntity<String> entity = null;
		
		try {
			service.upgradeAuth(id);
			entity = new ResponseEntity<String>("OK", HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}

	@RequestMapping("/downgrade")
	public ResponseEntity<String> downgrade(String id){
		System.out.println("강등되는 아이디: "+id);
		
		ResponseEntity<String> entity = null;
		
		try {
			service.downgradeAuth(id);
			entity = new ResponseEntity<String>("OK", HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}

}
