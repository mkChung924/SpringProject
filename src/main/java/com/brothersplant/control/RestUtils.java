package com.brothersplant.control;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.brothersplant.service.BoardInfoService;

@RestController
@RequestMapping("/rest")
public class RestUtils {
	
	@Inject
	private BoardInfoService bservice;
	
	
	@RequestMapping(value = "{data}", method= RequestMethod.POST)
	public ResponseEntity<List<Map<String,Object>>> list(@PathVariable("data") int mainCategory) {
		ResponseEntity<List<Map<String,Object>>> entity = null;
		try {
			//entity = new ResponseEntity<>(bservice.selectSi(do1), HttpStatus.OK);
			//System.out.println(bservice.selectSubCategory(mainCategory));
			entity = new ResponseEntity<>(bservice.selectSubCategory(mainCategory), HttpStatus.OK);
		} catch (Exception e) {
			// TODO: handle exception
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	//이미지 파일 올리기
	@RequestMapping(value = "a/images", method = RequestMethod.POST)
	public @ResponseBody String handleTinyMCEUpload(@RequestParam("files") MultipartFile files[],HttpSession session) {
	    System.out.println("uploading______________________________________MultipartFile " + files.length);
	    String filePath = "/resources/uploads/tinyMCE" + files[0].getOriginalFilename();
	    String result = uploadFilesFromTinyMCE("tinyMCE", files, false,session);
	    System.out.println(result);
	    return "{\"location\":\"" + filePath + "\"}";
	}

	private String uploadFilesFromTinyMCE(String prefix, MultipartFile files[], boolean isMain,HttpSession session) {
	    System.out.println("uploading______________________________________" + prefix);
	    try {
	    	//session.getServletContext().getRealPath("/")
	    	String folder = session.getServletContext().getRealPath("/") + "/resources/uploads/" + prefix;
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
	                    System.out.println("folder : "+folder);
	                    path = folder+ files[i].getOriginalFilename();
	                    System.out.println("path :"+path);
	                    File destination = new File(path);
	                    System.out.println("--> " + destination);
	                    files[i].transferTo(destination);
	                    result.append(files[i].getOriginalFilename() + " Succsess. ");
	                } catch (Exception e) {
	                	e.printStackTrace();
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
}
