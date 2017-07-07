package com.brothersplant.control;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.brothersplant.domain.ReportsListVO;
import com.brothersplant.domain.SelectRegionVO;
import com.brothersplant.service.ReportsService;


@RestController
public class ReportRestController {

	@Inject
	private ReportsService service;
	
	@RequestMapping(value="/addReport", method=RequestMethod.POST)
	public ResponseEntity<String> reportPost(ReportsListVO vo,HttpSession session)throws Exception{	
		System.out.println(vo.toString());
		ResponseEntity<String> entity=null;
		try{
			vo.setReporter((String)session.getAttribute("id"));	
			service.insertReport(vo);
			entity = new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
		}catch(Exception e){
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
/*	@RequestMapping(value="/replydel", method=RequestMethod.GET)
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
	}*/
	
	@RequestMapping(value = "/reportList", method=RequestMethod.POST)
	public ResponseEntity<List<String>> selectReportList() throws Exception{		
		ResponseEntity<List<String>> entity = null;
		System.out.println(service.selectReportList());
		entity = new ResponseEntity<List<String>>(service.selectReportList(), HttpStatus.OK);
		return entity;
	}
}
