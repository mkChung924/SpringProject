package com.brothersplant.control;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.brothersplant.aop.InterCeptorLoingCheck;
import com.brothersplant.domain.UserInfoVO;
import com.brothersplant.service.UserInfoService;

@RestController
public class HomeRestController {
	
	@Inject
	private UserInfoService service;
	private static final org.slf4j.Logger logger = LoggerFactory.getLogger(InterCeptorLoingCheck.class);
		
	@RequestMapping("/loggingIn")
	public ResponseEntity<String> login(String id, String pass) throws Exception{
		logger.info("로그인 시도중 : " + id);
		ResponseEntity<String> entity = null;
		logger.info(""+service.login(id, pass));
		try {
			if(service.login(id, pass)){
				entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			} else {
				entity = new ResponseEntity<String>("FAIL", HttpStatus.OK);
			}
		} catch (Exception e) {
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
			
		}
		
		return entity;
	}
	
	@RequestMapping("/dupCheck")
	public ResponseEntity<String> dupCheck(String id) throws Exception{
		logger.info("중복확인중 : " + id);
		
		ResponseEntity<String> entity = null;
		logger.info("중복: " + service.dupCheck(id));
		try {
			
			if(service.dupCheck(id))
				entity = new ResponseEntity<String>("possible", HttpStatus.OK);
			else
				entity = new ResponseEntity<String>("impossible", HttpStatus.OK);
			
		} catch (Exception e) {
			entity = new ResponseEntity<String>("FAIL", HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@RequestMapping("/nickCheck")
	public ResponseEntity<String> nickCheck(String nickname) throws Exception{
		logger.info("닉네임 중복확인중: " + nickname);
		ResponseEntity<String> entity = null;
		
		if(service.checkNickname(nickname)){
			entity = new ResponseEntity<String>("OK", HttpStatus.OK);
		} else {
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@RequestMapping("/idFind/{name}/{birth}")
	public ResponseEntity<List<String>> idList(@PathVariable("name") String name, @PathVariable("birth") String birth){
		logger.info("아이디 찾기 시도중");
		logger.info("검색된 이름:" + name + ", 검색된 생년월일: " + birth);
		ResponseEntity<List<String>> entity = null;
		
		
		try {
			logger.info(""+service.findId(name, birth));
			if(service.findId(name, birth).size() > 0){
				entity = new ResponseEntity<List<String>>(service.findId(name, birth), HttpStatus.OK);
			} else {
				entity = new ResponseEntity<List<String>>(HttpStatus.BAD_REQUEST);
			}
		} catch (Exception e) {
			
			entity = new ResponseEntity<List<String>>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@RequestMapping("/passFind/")
	public ResponseEntity<String> passFound(@RequestBody UserInfoVO vo) throws Exception{
		logger.info("비밀번호 찾기중");
		
		ResponseEntity<String> entity = null;
		String result = service.changePassword(vo.getId(), vo.getName(), vo.getSecure(), vo.getSecure_ans());
		logger.info("결과" + result);
		
		try {
			entity = new ResponseEntity<>(result, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;	
	}
	
	@RequestMapping("/passUp")
	public ResponseEntity<String> passUp(String id, String pass){
		logger.info(id);
		logger.info(pass);
		
		ResponseEntity<String> entity = null;
		
		try {
			service.modifyPassword(id, pass);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
			
		}
		
		return entity;
	}

}
