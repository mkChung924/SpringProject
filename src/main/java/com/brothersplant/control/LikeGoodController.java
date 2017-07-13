package com.brothersplant.control;

import javax.inject.Inject;

import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.brothersplant.aop.InterCeptorLoingCheck;
import com.brothersplant.service.LikeGoodService;

@Controller
@RequestMapping("/like/*")
public class LikeGoodController {
	
	@Inject
	private LikeGoodService service;
	private static final org.slf4j.Logger logger = LoggerFactory.getLogger(InterCeptorLoingCheck.class);
	
	@RequestMapping("add")
	public ResponseEntity<Object> addLike(String id, int tbno) throws Exception{
		
		ResponseEntity<Object> entity = null;
		
		int count = service.selectLike(id, tbno);
		if(count == 0){
			service.addLike(id, tbno);
			entity = new ResponseEntity<Object>(service.selectTotLike(tbno), HttpStatus.OK);
		} else {
			service.removeLike(id, tbno);
			entity = new ResponseEntity<Object>(service.selectTotLike(tbno), HttpStatus.OK);
			
		}
		
		return entity;
	}
}
