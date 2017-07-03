package com.brothersplant.control;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.brothersplant.domain.BoardVO;
import com.brothersplant.domain.CategoryInfoVO;
import com.brothersplant.service.BoardInfoService;


@Controller
public class BoardController {
	
	@Inject
	private BoardInfoService service;
	
	@RequestMapping("/board")
	public String boardList(HttpSession session, CategoryInfoVO vo, Model model){
		if(vo.getDo1() == null){
			return "redirect:index";
		}
		System.out.println("게시판 입장");
		System.out.println(vo);
		model.addAttribute("travel",vo);
		session.setAttribute("do1", vo.getDo1());
		session.setAttribute("si", vo.getSi());
		session.setAttribute("dong", vo.getDong());
		session.setAttribute("category", vo.getCno());
		session.setAttribute("subcategory", vo.getCsno());
		session.setAttribute("cno", vo.getCno());
		session.setAttribute("csno", vo.getCsno());
		session.setAttribute("p1", vo.getP1());
		session.setAttribute("p2", vo.getP2());
		
		return "board/board";
		
	}
	
	@RequestMapping(value = "regit", method=RequestMethod.GET)
	public String insertBoard(HttpSession session, Model model) throws Exception{
		String do1 = (String) session.getAttribute("do1");
		if(do1 == null){
			
			return null;
		} else {
			
		model.addAttribute("mainCategory",service.selectMainCategory());

			return "board/boardWrite";		
		}
		
	}
	@RequestMapping(value = "common_regit", method=RequestMethod.POST)
	public void insertBoard(BoardVO vo, MultipartFile file) throws Exception{
		System.out.println(vo.toString());
		service.insertBoard(vo);
		System.out.println("===등록 완료===");
	}
	
	@RequestMapping(value = "CommonRead", method=RequestMethod.GET)
	public String CommonRead(int tbno,Model model) throws Exception{
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
	//===========
	

}
