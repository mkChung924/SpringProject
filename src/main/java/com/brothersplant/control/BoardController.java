package com.brothersplant.control;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.brothersplant.domain.BoardListVO;
import com.brothersplant.domain.BoardVO;
import com.brothersplant.domain.CategoryInfoVO;
import com.brothersplant.domain.PageMaker;
import com.brothersplant.domain.SearchCriteria;
import com.brothersplant.service.BoardInfoService;
import com.brothersplant.service.LikeGoodService;


@Controller
public class BoardController {
	
	@Inject
	private BoardInfoService service;
	@Inject
	private LikeGoodService service2;
	
	@RequestMapping("/board")
	public String boardList(HttpSession session, Model model, SearchCriteria cri, String page, String tb_kind) throws Exception{
		if(cri.getDo1() == null || session.getAttribute("id") == null || cri.getCno() == null){
			return "redirect:index";
		}
		if(cri.getPageNum() == 0){
			cri.setPageNum(9);
		}
		if(page == null){
			page = "1";
		}
		if(tb_kind == null){
			tb_kind = "1";
		}
		System.out.println("tb_kind : " + tb_kind);
		PageMaker pageMaker = new PageMaker();
		cri.setId((String) session.getAttribute("id")); 
		
		if(tb_kind.equals("1")){
			
			System.out.println("들어온 페이지: " + page);
			cri.setPage(Integer.parseInt(page));
			System.out.println("게시판 입장");
			System.out.println("페이지당 개수: " + cri.getPageNum() +"개씩 보기");
			cri.setPerPageNum(cri.getPageNum());
			System.out.println(cri);
			
			System.out.println("게시글의 총 갯수 by size(): "+service.selectMyInterestList(cri).size());
			System.out.println("게시글 내용: " +service.selectMyInterestList(cri));
			System.out.println("게시글 의 갯수 by sql: " + service.countBoardList(cri));
			
			pageMaker.setCri(cri);
			pageMaker.setTotalCount(service.countBoardList(cri));

			//관심 목록 가져오기
			session.setAttribute("list", service.selectMyInterestList(cri));

		} else {
			
			System.out.println("들어온 페이지: " + page);
			cri.setPage(Integer.parseInt(page));
			System.out.println("게시판 입장");
			System.out.println("페이지당 개수: " + cri.getPageNum() +"개씩 보기");
			cri.setPerPageNum(cri.getPageNum());
			System.out.println(cri);
			
			System.out.println("게시글의 총 갯수 by size(): "+service.showTravelReviewList(cri).size());
			System.out.println("게시글 내용: " +service.showTravelReviewList(cri));
			System.out.println("게시글 의 갯수 by sql: " + service.countTravelReviewList(cri));
			
			pageMaker.setCri(cri);
			pageMaker.setTotalCount(service.countTravelReviewList(cri));

			//여행후기 가져오기
			session.setAttribute("list", service.showTravelReviewList(cri));
			
		}
		
		session.setAttribute("tb_kind", tb_kind);
		session.setAttribute("searchType", cri.getSearchType());
		session.setAttribute("keyword", cri.getKeyword());
		session.setAttribute("pageNum", cri.getPageNum());
		session.setAttribute("page", Integer.parseInt(page));
		session.setAttribute("pageMaker", pageMaker);
		
		//내가 고른 카테고리 이름 가져오기
		session.setAttribute("category", service.selectCategory(Integer.parseInt(cri.getCsno())).get("CNAME"));
		session.setAttribute("subcategory", service.selectCategory(Integer.parseInt(cri.getCsno())).get("CSNAME"));
		
		session.setAttribute("do1", cri.getDo1());
		session.setAttribute("si", cri.getSi());
		session.setAttribute("dong", cri.getDong());
		session.setAttribute("cno", cri.getCno());
		session.setAttribute("csno", cri.getCsno());
		session.setAttribute("p1", cri.getPlace1());
		session.setAttribute("p2", cri.getPlace2());
		
		
		return "board/board";
		//return "redirect:/boards";
		
	}
	
	
//	@RequestMapping("/perPage")
//	public ResponseEntity<List<BoardListVO>> perPage(@RequestBody CategoryInfoVO vo, SearchCriteria cri){
//		
//		ResponseEntity<List<BoardListVO>> entity = null;
//		System.out.println(vo);
//		cri.setPerPageNum(vo.getPageNum());
//		try {
//	         entity = new ResponseEntity<>(service.selectMyInterestList(cri), HttpStatus.OK);
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
	public String CommonRead(int tbno,Model model) throws Exception{
		System.out.println("CommonRead 게시글 내용: "+service.selectCommonRow(tbno));
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
	

	
	@RequestMapping("/like/add")
	public ResponseEntity<Object> addLike(String id, int tbno) throws Exception{
		
		ResponseEntity<Object> entity = null;
		
		int count = service2.selectLike(id, tbno);
		if(count == 0){
			service2.addLike(id, tbno);
			entity = new ResponseEntity<Object>(service2.selectTotLike(tbno), HttpStatus.OK);
		} else {
			service2.removeLike(id, tbno);
			entity = new ResponseEntity<Object>(service2.selectTotLike(tbno), HttpStatus.OK);
			
		}
		
		return entity;
	}
	

}
