package com.brothersplant.control;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.brothersplant.domain.BoardListVO;
import com.brothersplant.domain.BoardVO;
import com.brothersplant.domain.CategoryInfoVO;
import com.brothersplant.domain.PageMaker;
import com.brothersplant.domain.SearchCriteria;
import com.brothersplant.service.BoardInfoService;


@Controller
public class BoardController {
	
	@Inject
	private BoardInfoService service;
	
	@RequestMapping("/board")
	public String boardList(HttpSession session, CategoryInfoVO vo, Model model, SearchCriteria cri, String perPageNum) throws Exception{
		if(vo.getDo1() == null || session.getAttribute("id") == null || vo.getCno() == null){
			return "redirect:index";
		}
		if(perPageNum == null){
			perPageNum = "9";
		}
		cri.setPerPageNum(Integer.parseInt(perPageNum));
		
		System.out.println("페이지당 개수: " + perPageNum);
		System.out.println("게시판 입장");
		System.out.println(vo);
		System.out.println("list size : "+service.selectMyInterestList(vo,cri).size());
		System.out.println(service.selectMyInterestList(vo,cri));
		System.out.println(cri);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(3);
		
		model.addAttribute("pageMaker", pageMaker);
		

		
		//관심 목록 가져오기
		model.addAttribute("list", service.selectMyInterestList(vo,cri));
		//내가 고른 카테고리 이름 가져오기
		session.setAttribute("category", service.selectCategory(Integer.parseInt(vo.getCsno())).get("CNAME"));
		session.setAttribute("subcategory", service.selectCategory(Integer.parseInt(vo.getCsno())).get("CSNAME"));
		
		session.setAttribute("do1", vo.getDo1());
		session.setAttribute("si", vo.getSi());
		session.setAttribute("dong", vo.getDong());
		session.setAttribute("cno", vo.getCno());
		session.setAttribute("csno", vo.getCsno());
		session.setAttribute("p1", vo.getPlace1());
		session.setAttribute("p2", vo.getPlace2());
		
		return "board/board";
		
	}
	
//	@RequestMapping("/perPage")
//	public ResponseEntity<List<BoardListVO>> perPage(@RequestBody CategoryInfoVO vo, SearchCriteria cri){
//		
//		ResponseEntity<List<BoardListVO>> entity = null;
//		System.out.println(vo);
//		cri.setPerPageNum(vo.getPageNum());
//		try {
//	         entity = new ResponseEntity<>(service.selectMyInterestList(vo,cri), HttpStatus.OK);
//	      } catch (Exception e) {
//	         // TODO: handle exception
//	         entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
//	      }
//	      return entity;
//		
//	}
	
	@RequestMapping(value = "regit", method=RequestMethod.GET)
	public String insertBoard(HttpSession session, Model model) throws Exception{
		System.out.println("게시글 작성");
		String do1 = (String) session.getAttribute("do1");
		if(do1 == null){
			
			return null;
		} else {
			
		model.addAttribute("mainCategory",service.selectMainCategory());

			return "board/boardWrite";		
		}
		
	}
	@RequestMapping(value = "common_regit", method=RequestMethod.POST)
	public String insertBoard(BoardVO vo, MultipartFile file) throws Exception{
		System.out.println(vo.toString());
		service.insertBoard(vo);
		System.out.println("===등록 완료===");
		return "selfClose";
	}
	
	@RequestMapping(value = "CommonRead", method=RequestMethod.GET)
	public String CommonRead(int tbno,Model model,HttpSession session) throws Exception{
		model.addAttribute("commonBoard",service.selectCommonRow(tbno));
		return "board/commonRead";
	}
	
	@RequestMapping(value = "CommonUpdate", method=RequestMethod.GET)
	public String CommonUpdate(int tbno,Model model,HttpSession session) throws Exception{
		if(session.getAttribute("user") != null){
			model.addAttribute("commonBoard",service.selectCommonRow(tbno));
			return "board/boardUpdate";
		}else{
			return "selfClose";
		}
	}
	@RequestMapping(value = "CommonUpdate", method=RequestMethod.PUT)
	public String CommonUpdate2(BoardVO vo,Model model,HttpSession session) throws Exception{
		if(session.getAttribute("user") != null){
			model.addAttribute("commonBoard",service.selectCommonRow(vo.getTbno()));
			return "board/boardUpdate";
		}else{
			return "selfClose";
		}
	}
	@RequestMapping(value = "CommonDelete/{data}", method= RequestMethod.DELETE)
	public ResponseEntity<String> CommonDelete(@PathVariable("data") int tbno) throws Exception{
		ResponseEntity<String> entity=null;
		int result = service.deleteCommonRow(tbno);
		try {
			if(result>0){
				entity = new ResponseEntity<>("success", HttpStatus.OK);//해당 게시글 삭제 완료						
			}
		} catch (Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	//===========
	

}
