package com.brothersplant.control;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.brothersplant.service.ReportsService;


@RestController
public class ReportRestController {

	@Inject
	private ReportsService service;
	
	@RequestMapping(value="/reportinsert", method=RequestMethod.GET)
	public ResponseEntity<String> reportPost(int rno)throws Exception{
		
		ResponseEntity<String> entity=null;
		
		
		
		try{
		service.insertReport(rno);
		
			entity = new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
		}catch(Exception e){
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value="/replydel", method=RequestMethod.GET)
	public ResponseEntity<String> replydelete(int rno)throws Exception{
		
		ResponseEntity<String> entity=null;
		System.out.println("�� : "+rno);
		try{
			service.removeReply(rno);
			entity = new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
		}catch(Exception e){
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
