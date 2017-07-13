package com.brothersplant.control;

import java.io.File;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.brothersplant.aop.InterCeptorLoingCheck;
import com.brothersplant.domain.BoardVO;
import com.brothersplant.domain.SelectRegionVO;
import com.brothersplant.service.BoardInfoService;


@RestController
@RequestMapping("/rest")
public class BoardRestController {
	
	@Inject
	private BoardInfoService service;
	
	private static final org.slf4j.Logger logger = LoggerFactory.getLogger(InterCeptorLoingCheck.class);
	
	@RequestMapping(value = "{data}", method= RequestMethod.POST)
	public ResponseEntity<List<Map<String,Object>>> list(@PathVariable("data") int mainCategory) {
		ResponseEntity<List<Map<String,Object>>> entity = null;
		try {
			//entity = new ResponseEntity<>(service.selectSi(do1), HttpStatus.OK);
			//logger.info(service.selectSubCategory(mainCategory));
			entity = new ResponseEntity<>(service.selectSubCategory(mainCategory), HttpStatus.OK);
		} catch (Exception e) {
			// TODO: handle exception
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	//이미지 파일 올리기
	@RequestMapping(value = "b/images", method = RequestMethod.POST)
	public @ResponseBody String handleTinyMCEUpload(@RequestParam("files") MultipartFile files[], HttpSession session) {
		logger.info("b/images 들어옴");
	    logger.info("uploading______________________________________MultipartFile " + files.length);
	    String filePath = "/resources/upload/" + session.getAttribute("id")+"/tinyMCE/" + files[0].getOriginalFilename();
	    String result = uploadFilesFromTinyMCE2("tinyMCE", files, false,session);
	    logger.info(result);
	    return "{\"location\":\"" + filePath + "\"}";
	}

	private String uploadFilesFromTinyMCE2(String prefix, MultipartFile files[], boolean isMain,HttpSession session) {
	    logger.info("uploading______________________________________" + prefix);
	    try {
	    	
	        String folder = session.getServletContext().getRealPath("/" ) +"/resources/upload/"+ (String) session.getAttribute("id") + "/" + prefix +"/";
	        StringBuffer result = new StringBuffer();
	        byte[] bytes = null;
	        result.append("Uploading of File(s) ");

	        for (int i = 0; i < files.length; i++) {
	            if (!files[i].isEmpty()) {

	                try {
	                    boolean created = false;

	                    try {
	                    	File idDir = new File(session.getServletContext().getRealPath("/" )+ "/resources/upload/"+session.getAttribute("id")+"/");//아이디 폴더 만들고
	                        File theDir = new File(folder);
	                        idDir.mkdir();
	                        theDir.mkdir();
	                        created = true;
	                        
	                    } catch (SecurityException se) {
	                        se.printStackTrace();
	                    }
	                    if (created) {
	                        logger.info("DIR created");
	                    }
	                    String path = "";
	                    path = folder +files[i].getOriginalFilename();
	                    logger.info("path: " + path);
	                    File destination = new File(path);
	                    logger.info("--> " + destination + "--->" + path);
	                    files[i].transferTo(destination);
	                    result.append(files[i].getOriginalFilename() + " Succsess. ");
	                } catch (Exception e) {
	                    throw new RuntimeException("Product Image saving failed", e);
	                }

	            } else
	                result.append(files[i].getOriginalFilename() + " Failed. ");
	        }

	        return result.toString();

	    } catch (Exception e) {
	        return "Error Occured while uploading files." + " => " + e.getMessage();
	    }
	}
	
	@RequestMapping("/bookmark")
	public ResponseEntity<String> addBookmark(String id, int tbno) throws Exception{
		
		ResponseEntity<String> entity = null;
		
		int count = service.getBookmark(id, tbno);
		if(count == 0){
			entity = new ResponseEntity<String>("OK", HttpStatus.OK);
			service.addBookmark(id, tbno);
		} else {
			entity = new ResponseEntity<String>("NO", HttpStatus.OK);
			service.deleteBookmark(id, tbno);
			
		}
		
		return entity;
	}
	
	@RequestMapping("/selectSido")
	public ResponseEntity<List<SelectRegionVO>> selectSido() throws Exception{
		
		ResponseEntity<List<SelectRegionVO>> entity = null;
		
		logger.info(service.sido().toString());
		entity = new ResponseEntity<List<SelectRegionVO>>(service.sido(), HttpStatus.OK);
		return entity;
	}
	
	@RequestMapping("/selectGugun")
	public ResponseEntity<List<SelectRegionVO>> selectGugun(String ds_sido) throws Exception{
		
		logger.info(ds_sido);
		ResponseEntity<List<SelectRegionVO>> entity = null;
		
		logger.info(service.gugun(ds_sido).toString());
		entity = new ResponseEntity<List<SelectRegionVO>>(service.gugun(ds_sido), HttpStatus.OK);
		return entity;
	}
	
	@RequestMapping("/regionDetail")
	public ResponseEntity<List<BoardVO>> selectRegionList(String place1)throws Exception{
		ResponseEntity<List<BoardVO>> entity = null;
		logger.info("선택된 여행지: "+place1);
		
		entity = new ResponseEntity<List<BoardVO>>(service.selectSpecificTravelRegion(place1), HttpStatus.OK);
		
		return entity;
	}

}
