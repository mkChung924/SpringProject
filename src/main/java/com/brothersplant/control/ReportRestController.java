package com.brothersplant.control;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.brothersplant.aop.InterCeptorLoingCheck;
import com.brothersplant.domain.ReportsListVO;
import com.brothersplant.service.ReportsService;


@RestController
public class ReportRestController {

	@Inject
	private ReportsService service;
	private static final org.slf4j.Logger logger = LoggerFactory.getLogger(InterCeptorLoingCheck.class);
	
	@RequestMapping(value="/addReport", method=RequestMethod.POST)
	public ResponseEntity<String> reportPost(ReportsListVO vo,HttpSession session)throws Exception{	
		logger.info(vo.toString());
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
	
	@RequestMapping(value = "/reportList", method=RequestMethod.POST) //목록 보이기
	public ResponseEntity<List<String>> selectReportList() throws Exception{		
		ResponseEntity<List<String>> entity = null;
		logger.info(""+service.selectReportList());
		entity = new ResponseEntity<List<String>>(service.selectReportList(), HttpStatus.OK);
		return entity;
	}
	
	@RequestMapping(value="/selectedReprotListDelete", method=RequestMethod.POST) //신고 목록 삭제만 패널티 없음
	public ResponseEntity<String> reportListDelete(int kind,String repnoList)throws Exception{
		
		ResponseEntity<String> entity=null;
		String repnoListTemp[] = repnoList.split(",");
		try{
			int result = service.selectedReprotListDelete(kind, repnoListTemp);
			logger.info("삭제된 행의 수 : "+result +" || kind : "+kind);
			entity = new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
		}catch(Exception e){
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value="/selectedReprotListDeletePenalty", method=RequestMethod.POST) //신고목록삭제 유저에게 패널티 있음!!
	public ResponseEntity<String> reportListDeletePenalty(int kind,String repnoList,String offenderList,String brnoList)throws Exception{
		ResponseEntity<String> entity=null;
		String repnoListTemp[] = repnoList.split(",");
		
		//String Array to List
		List<String> offenderLIST = Arrays.asList(offenderList.split(","));
		List<String> brnoLIST =  Arrays.asList(brnoList.split(","));

		//List<String> uniqueOffenderList = new ArrayList<String>(new HashSet<String>(offenderLIST));//신고자 명단 중복 제거
		//logger.info("중복 제거된 신고자 명단 : "+uniqueOffenderList); // [1, 2, 3]
		
		try{
			int result = service.selectedReprotListDeletePenalty(kind, brnoLIST,offenderLIST);
			logger.info("삭제된 행의 수 : "+result +" || kind : "+kind);
			entity = new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
		}catch(Exception e){
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
