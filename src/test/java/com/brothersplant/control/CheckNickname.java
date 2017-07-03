package com.brothersplant.control;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.brothersplant.persistence.UserInfoDAO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml" })
public class CheckNickname {
	
	@Inject
	private UserInfoDAO dao;
	
	

	@Test
	public void nickName() throws Exception{
		if(dao.nickCheck("aaaa")){
			System.out.println("true");
		} else {
			System.out.println("false");
		}
	}
}
