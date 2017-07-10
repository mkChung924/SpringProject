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

import com.brothersplant.domain.ReportsListVO;
import com.brothersplant.domain.SearchCriteria;
import com.brothersplant.persistence.BoardInfoDAO;
import com.brothersplant.persistence.ReportsDAO;
import com.brothersplant.persistence.UserInfoDAO;
import com.brothersplant.service.ReportsService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml" })
public class seach {
	
	@Inject
	private UserInfoDAO dao;
	
	@Inject
	private BoardInfoDAO dao2;
	
	@Inject
	private ReportsDAO reportDAO;
	
	@Inject
	private ReportsService serviceReport;

	
	@Test
	public void seach() throws Exception{
		SearchCriteria cri = new SearchCriteria();
		cri.setKeyword("10");
		cri.setSearchType("n");
		cri.setPage(1);
		cri.setPerPageNum(10);;
		List<ReportsListVO> list = serviceReport.searchReportList(cri, 1);
		System.out.println(serviceReport.searchCountPaging(cri, 1));
		for(ReportsListVO vo : list){
			System.out.println(vo);
			
		}
	}
}
