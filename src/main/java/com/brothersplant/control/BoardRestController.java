package com.brothersplant.control;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.brothersplant.service.BoardInfoService;


@RestController
public class BoardRestController {
	
	@Inject
	private BoardInfoService service;
	
	
	
	@RequestMapping(value = "{data}", method= RequestMethod.POST)
	public ResponseEntity<List<Map<String,Object>>> list(@PathVariable("data") int mainCategory) {
		ResponseEntity<List<Map<String,Object>>> entity = null;
		try {
			//entity = new ResponseEntity<>(service.selectSi(do1), HttpStatus.OK);
			//System.out.println(service.selectSubCategory(mainCategory));
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
		System.out.println("b/images 들어옴");
	    System.out.println("uploading______________________________________MultipartFile " + files.length);
	    String filePath = "/resources/upload/" + session.getAttribute("id")+"/tinyMCE/" + files[0].getOriginalFilename();
	    String result = uploadFilesFromTinyMCE2("tinyMCE", files, false,session);
	    System.out.println(result);
	    return "{\"location\":\"" + filePath + "\"}";
	}

	private String uploadFilesFromTinyMCE2(String prefix, MultipartFile files[], boolean isMain,HttpSession session) {
	    System.out.println("uploading______________________________________" + prefix);
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
	                        File theDir = new File(folder);
	                        if(!theDir.exists()){
	                        	theDir.mkdir();
	                        	created = true;
	                        }
	                    } catch (SecurityException se) {
	                        se.printStackTrace();
	                    }
	                    if (created) {
	                        System.out.println("DIR created");
	                    }
	                    String path = "";
	                    path = folder +files[i].getOriginalFilename();
	                    System.out.println("path: " + path);
	                    File destination = new File(path);
	                    System.out.println("--> " + destination + "--->" + path);
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

}
