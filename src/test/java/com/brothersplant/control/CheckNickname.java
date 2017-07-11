package com.brothersplant.control;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.brothersplant.persistence.BoardInfoDAO;
import com.brothersplant.persistence.ReportsDAO;
import com.brothersplant.persistence.UserInfoDAO;
import com.brothersplant.service.ReportsService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml" })
public class CheckNickname {
	
	@Inject
	private UserInfoDAO dao;
	
	@Inject
	private BoardInfoDAO dao2;
	
	@Inject
	private ReportsDAO reportDAO;
	
	@Inject
	private ReportsService serviceReport;

	//@Test
	public void nickName() throws Exception{
		if(dao.nickCheck("aaaa")){
			System.out.println("true");
		} else {
			System.out.println("false");
		}
	}
	
	//@Test
	public void category() throws Exception{
		int csno = 2;
		Map<String,String> map = dao2.selectCategory(csno);
		System.out.println(map.size());
		System.out.println("cname: "+map.get("CNAME"));
		System.out.println("csname: "+map.get("CSNAME"));
	}
	
	//@Test
	public void deletefromBoard_Reply() throws Exception{
		int kind=1;
/*
		List<String> brnoList = new ArrayList<>();
		brnoList.add("15");

		int result = reportDAO.deletefromBoard_Reply(kind, brnoList);*/
		//System.out.println(result);

		String offenderList ="a,a,a,a,a,a,b,b,b,c,c,c";
		List<String> offenderLIST = Arrays.asList(offenderList.split(","));
		List<String> uniqueOffenderList = new ArrayList<String>(new HashSet<String>(offenderLIST));//신고자 명단 중복 제거
		System.out.println("중복 제거된 신고자 명단 : "+uniqueOffenderList); // [1, 2, 3]
	}
	
	//@Test
	public void addUserPenalty() throws Exception{
		List<String> uniqueOffenderList = new ArrayList<>();
		uniqueOffenderList.add("asdasd");

		List<String> brnoLists = new ArrayList<>();
		brnoLists.add("90");
		serviceReport.selectedReprotListDeletePenalty(1, brnoLists, uniqueOffenderList);
	}

}
