package com.brothersplant.control;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.brothersplant.domain.ReportsListVO;
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
	
	@RequestMapping(value = "/reportList", method=RequestMethod.POST) //목록 보이기
	public ResponseEntity<List<String>> selectReportList() throws Exception{		
		ResponseEntity<List<String>> entity = null;
		System.out.println(service.selectReportList());
		entity = new ResponseEntity<List<String>>(service.selectReportList(), HttpStatus.OK);
		return entity;
	}
	
	@RequestMapping(value="/selectedReprotListDelete", method=RequestMethod.POST) //신고 목록 삭제만 패널티 없음
	public ResponseEntity<String> reportListDelete(int kind,String repnoList)throws Exception{
		
		ResponseEntity<String> entity=null;
		String repnoListTemp[] = repnoList.split(",");
		try{
			int result = service.selectedReprotListDelete(kind, repnoListTemp);
			System.out.println("삭제된 행의 수 : "+result +" || kind : "+kind);
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
		String repnoListBrno[] = repnoList.split(",");
		String offenderListArr[] = offenderList.split(",");
		String brnoListArr[] = brnoList.split(",");
		List<Map<String, String>> penaltyList = new ArrayList<>();
		
		System.out.println(kind+" ||| "+repnoList+" ||| "+offenderList+" ||| "+brnoList);
		
		for (int i = 0; i < offenderListArr.length; i++) {
			Map<String, String> map = new HashMap<>();
			map.put("offender", offenderListArr[i]);
			map.put("repno", repnoListBrno[i]);
			map.put("brno", brnoListArr[i]);
			penaltyList.add(map);
			//mapper penaltyList[i].map.	offender
		}
		
		try{
			int result = service.selectedReprotListDeletePenalty(kind, penaltyList);
			System.out.println("삭제된 행의 수 : "+result +" || kind : "+kind);
			entity = new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
		}catch(Exception e){
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
