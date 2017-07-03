package com.brothersplant.control;

import java.util.ArrayList;
import java.util.Map;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.brothersplant.persistence.BoardInfoDAO;
import com.brothersplant.persistence.UserInfoDAO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml" })
public class CheckNickname {
	
	@Inject
	private UserInfoDAO dao;
	
	@Inject
	private BoardInfoDAO dao2;
	
	

	@Test
	public void nickName() throws Exception{
		if(dao.nickCheck("aaaa")){
			System.out.println("true");
		} else {
			System.out.println("false");
		}
	}
	
	@Test
	public void category() throws Exception{
		int csno = 2;
		Map<String,String> map = dao2.selectCategory(csno);
		System.out.println(map.size());
		System.out.println("cname: "+map.get("CNAME"));
		System.out.println("csname: "+map.get("CSNAME"));
	}
}
