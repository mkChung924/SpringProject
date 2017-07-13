package com.brothersplant.control;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.brothersplant.aop.InterCeptorLoingCheck;
import com.brothersplant.domain.BoardListVO;
import com.brothersplant.domain.BoardVO;
import com.brothersplant.domain.PageMaker;
import com.brothersplant.domain.SearchCriteria;
import com.brothersplant.service.BoardInfoService;
import com.brothersplant.service.LikeGoodService;
import com.brothersplant.service.UserInfoService;



@Controller
public class BoardController {
	
	@Inject
	private BoardInfoService service;
	@Inject
	private LikeGoodService service2;
	
	@Inject
	private UserInfoService userService;
	
	private static final org.slf4j.Logger logger = LoggerFactory.getLogger(InterCeptorLoingCheck.class);
	@RequestMapping("/board")
	public String boardList(HttpSession session, Model model, SearchCriteria cri, String page, String tb_kind) throws Exception{
		if(cri.getDo1() == null || session.getAttribute("id") == null || cri.getCno() == null){
			return "redirect:index";
		}
		if(cri.getPageNum() == 0){
			cri.setPageNum(9);
		}

		cri.setId((String)session.getAttribute("id")); 

		if(page == null){
			page = "1";
		}
		if(tb_kind == null){
			tb_kind = "1";
		}
		logger.info("tb_kind : " + tb_kind);
		PageMaker pageMaker = new PageMaker();
		cri.setId((String) session.getAttribute("id")); 
		
		if(tb_kind.equals("1")){
			
			logger.info("들어온 페이지: " + page);
			cri.setPage(Integer.parseInt(page));
			logger.info("게시판 입장");
			logger.info("페이지당 개수: " + cri.getPageNum() +"개씩 보기");
			cri.setPerPageNum(cri.getPageNum());
			logger.info(cri.toString());
			
			logger.info("게시글의 총 갯수 by size(): "+service.selectMyInterestList(cri).size());
			logger.info("게시글 내용: " +service.selectMyInterestList(cri));
			logger.info("게시글 의 갯수 by sql: " + service.countBoardList(cri));
			
			pageMaker.setCri(cri);
			pageMaker.setTotalCount(service.countBoardList(cri));
			
			//관리자 여행글 가져오기
			if(Integer.parseInt(cri.getCno()) == 1){
				logger.info("관리자 여행 정보: "+service.selectAdminTravel(cri));
				session.setAttribute("travelList", service.selectAdminTravel(cri));
			}

			//관심 목록 가져오기
			session.setAttribute("list", service.selectMyInterestList(cri));
			logger.info(service.selectCnoList(cri).toString());
			session.setAttribute("cnoMap", service.selectCnoList(cri));


		} else {
			
			logger.info("들어온 페이지: " + page);
			cri.setPage(Integer.parseInt(page));
			logger.info("게시판 입장");
			logger.info("페이지당 개수: " + cri.getPageNum() +"개씩 보기");
			cri.setPerPageNum(cri.getPageNum());
			logger.info(cri.toString());
			
			logger.info("게시글의 총 갯수 by size(): "+service.showTravelReviewList(cri).size());
			logger.info("게시글 내용: " +service.showTravelReviewList(cri));
			logger.info("게시글 의 갯수 by sql: " + service.countTravelReviewList(cri));
			
			pageMaker.setCri(cri);
			pageMaker.setTotalCount(service.countTravelReviewList(cri));
			
			//관리자 추천 여행 가져오기
			//관리자 여행글 가져오기
			if(Integer.parseInt(cri.getCno()) == 1){
				logger.info("관리자 여행 정보: "+service.selectAdminTravel(cri));
				session.setAttribute("travelList", service.selectAdminTravel(cri));
			}

			//여행후기 가져오기
			session.setAttribute("list", service.showTravelReviewList(cri));
			session.setAttribute("cnoMap", service.selectCnoList(cri));

			
		}
		List<BoardListVO>  list = (List<BoardListVO>)session.getAttribute("list");
		logger.info(list.toString());
		
		session.setAttribute("tb_kind", tb_kind);
		session.setAttribute("searchType", cri.getSearchType());
		session.setAttribute("keyword", cri.getKeyword());
		session.setAttribute("pageNum", cri.getPageNum());
		session.setAttribute("page", Integer.parseInt(page));
		session.setAttribute("pageMaker", pageMaker);
		
		//후기 및 게시글 갯수 가져오기
		session.setAttribute("boardCount", service.selectNonReviewBoardCount(cri));
		if(cri.getPlace1() != null){
			session.setAttribute("reviewBoardCount", service.selectReviewBoardCount(cri));
		}
		
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
//		logger.info(vo);
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
		logger.info("게시글 작성");
		String do1 = (String) session.getAttribute("do1");
		if(do1 == null){
			
			return null;
		} else {
			
		model.addAttribute("mainCategory",service.selectMainCategory());

			return "board/boardWrite";		
		}
		
	}
	@RequestMapping(value = "common_regit", method=RequestMethod.POST)

	public String insertBoard(BoardVO vo, MultipartFile file, Model model) throws Exception{
		logger.info(""+vo.getTb_kind());
		logger.info(vo.toString());
		service.insertBoard(vo);
		logger.info("===등록 완료===");
		model.addAttribute("tb_kind", vo.getTb_kind());
		return "selfClose";
	}
	
	@RequestMapping(value = "CommonRead", method=RequestMethod.GET)
	public String CommonRead(int tbno,Model model,HttpSession session) throws Exception{
		model.addAttribute("commonBoard",service.selectCommonRow(tbno,(String)session.getAttribute("id")));
		model.addAttribute("profile",userService.selectprofile((String)session.getAttribute("id")));
		
		//조회수
		service.addViewCnt(tbno);
		
		return "board/commonRead";
	}
	
	@RequestMapping(value = "CommonUpdate", method=RequestMethod.GET)//페이지는 보여주고
	public String CommonUpdate(int tbno,Model model,HttpSession session) throws Exception{
		if(session.getAttribute("id") != null){
			logger.info(service.selectCommonRow(tbno,(String)session.getAttribute("id")).toString());
			model.addAttribute("commonBoard",service.selectCommonRow(tbno,(String)session.getAttribute("id")));
			return "board/boardUpdate";
		}else{
			return "selfClose";
		}
	}
	@RequestMapping(value = "CommonUpdate", method=RequestMethod.POST)
	public String CommonUpdate(BoardVO vo,Model model,HttpSession session) throws Exception{
		if(session.getAttribute("id") != null){
			logger.info("수정될 내용: "+vo);
			 if(service.updateCommonRow(vo) > 0){
				 logger.info("수정 성공");
				 return "selfClose2";				 
			 }else{
				 logger.info("수정 실패");
				 return "selfClose2";				 				 
			 }
		}else{
			return "selfClose2";
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
	
	@RequestMapping("/allTrip")
	public String allTrip(HttpSession session, Model model) throws Exception{
		String id =	(String) session.getAttribute("id");
		
		if(id != null){

			logger.info(service.selectAllTravelRegionCount().toString());
			model.addAttribute("regionCount", service.selectAllTravelRegionCount());

			
		} else {
			return "redirect:login";
		}
		
		
		return "board/allTravelList";
	}
}
