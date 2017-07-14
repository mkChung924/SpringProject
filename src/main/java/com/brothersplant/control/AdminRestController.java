package com.brothersplant.control;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.brothersplant.aop.InterCeptorLoingCheck;
import com.brothersplant.domain.BoardListVO;
import com.brothersplant.domain.BoardVO;
import com.brothersplant.domain.PageMaker;
import com.brothersplant.domain.ReplyVO;
import com.brothersplant.domain.SearchCriteria;
import com.brothersplant.service.AdminPageService;
import com.brothersplant.service.BoardInfoService;

@RestController
public class AdminRestController {

	@Inject
	private AdminPageService service;

	@Inject
	private BoardInfoService boardService;
	
	private static final org.slf4j.Logger logger = LoggerFactory.getLogger(InterCeptorLoingCheck.class);

	@RequestMapping("/upgrade")
	public ResponseEntity<String> upgrade(String id) {
		logger.info("등업되는 아이디: " + id);

		ResponseEntity<String> entity = null;

		try {
			service.upgradeAuth(id);
			entity = new ResponseEntity<String>("OK", HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}

		return entity;
	}

	@RequestMapping("/downgrade")
	public ResponseEntity<String> downgrade(String id) {
		logger.info("강등되는 아이디: " + id);

		ResponseEntity<String> entity = null;

		try {
			service.downgradeAuth(id);
			entity = new ResponseEntity<String>("OK", HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}

		return entity;
	}

	@RequestMapping("/citylist")
	public ResponseEntity<List<Map<String, Object>>> cityList(SearchCriteria cri) {
		logger.info("cityList 불러오기");
		logger.info(cri.toString());

		ResponseEntity<List<Map<String, Object>>> entity = null;

		try {
			entity = new ResponseEntity<List<Map<String, Object>>>(service.selectCityList(cri), HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<List<Map<String, Object>>>(HttpStatus.BAD_REQUEST);
		}

		return entity;
	}

	@RequestMapping(value = "adminTravelRie/{page}", method = RequestMethod.POST)
	public ResponseEntity<List<BoardListVO>> list(SearchCriteria cri, @PathVariable("page") int page,
			HttpSession session) {
		logger.info(cri.toString());
		ResponseEntity<List<BoardListVO>> entity = null;
		try {
			cri.setPerPageNum(3); // 페이지 그려주는 쪽은 AdminController.java
									// adminTravel메소드에 있음
			cri.setId((String) session.getAttribute("id"));
			cri.setPage(page);

			entity = new ResponseEntity<>(boardService.showTravelReviewList(cri), HttpStatus.OK);
		} catch (Exception e) {
			// TODO: handle exception
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "admin_update", method = RequestMethod.POST)
	public ResponseEntity<String> insertBoard3(BoardVO vo, MultipartFile file) {

		ResponseEntity<String> entity = null;
		String content = vo.getContent();
		System.out.println("content: "+content);
		int start = content.indexOf("resources/");
		int end = content.indexOf(" alt=\"/")-1;
		vo.setImage(content.substring(start, end));
		logger.info(vo.toString());
		try {
			boardService.adminBoardUpdate(vo);
			entity = new ResponseEntity<>("success", HttpStatus.OK);
			logger.info("===수정 완료===");
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "deleteAdminBoard", method = RequestMethod.POST)
	public ResponseEntity<String> deleteAdminBoard(String deleteList) throws Exception {
		ResponseEntity<String> entity = null;

		String listArr[] = deleteList.split(",");
		try {
			int result = boardService.deleteAdminBoard(listArr);
			entity = new ResponseEntity<>("success", HttpStatus.OK);
			logger.info("===삭제 완료==="+result);
		} catch (Exception e) {		
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
