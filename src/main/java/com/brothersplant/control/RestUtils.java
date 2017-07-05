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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.brothersplant.service.BoardInfoService;
import com.brothersplant.service.UserInfoService;

@RestController
@RequestMapping("/rest2")
public class RestUtils {
	
	@Inject
	private BoardInfoService bservice;
	
	@Inject UserInfoService userService;
	
	@Autowired
	private ServletContext context;

	@RequestMapping(value = "{data}", method= RequestMethod.POST)//카테고리
	public ResponseEntity<List<Map<String, Object>>>  list(@PathVariable("data") int mainCategory) {
		ResponseEntity<List<Map<String, Object>>> entity = null;
		try {
			//entity = new ResponseEntity<>(bservice.selectSi(do1), HttpStatus.OK);
			entity = new ResponseEntity<>(bservice.selectSubCategory(mainCategory), HttpStatus.OK);
		} catch (Exception e) {
			// TODO: handle exception
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	//게시글 이미지 파일 올리기
	@RequestMapping(value = "/a/images", method = RequestMethod.POST)
	@ResponseBody
	public String handleTinyMCEUpload(@RequestParam("files") MultipartFile files[],HttpSession session) {
	    System.out.println("uploading______________________________________MultipartFile " + files.length);
	    String filePath = "/resources/upload/"+session.getAttribute("id")+"/tinyMCE/" + files[0].getOriginalFilename();
	    String result = uploadFilesFromTinyMCE("tinyMCE", files, false,session);
	    System.out.println(result);
	    return "{\"location\":\"" + filePath + "\"}";

	}

	private String uploadFilesFromTinyMCE(String prefix, MultipartFile files[], boolean isMain,HttpSession session) {
	    System.out.println("uploading______________________________________" + prefix);
	    try {
	        String folder = context.getRealPath("/") + "/resources/upload/"+session.getAttribute("id")+"/" + prefix+"/";
	        StringBuffer result = new StringBuffer();
	        byte[] bytes = null;
	        result.append("Uploading of File(s) ");

	        for (int i = 0; i < files.length; i++) {
	            if (!files[i].isEmpty()) {

	                try {
	                    boolean created = false;

	                    try {	                    	
	                    	File idDir = new File(context.getRealPath("/") + "/resources/upload/"+session.getAttribute("id")+"/");//아이디 폴더 만들고
	                        File theDir = new File(folder);
	                        idDir.mkdir();
	                        theDir.mkdir();
	                        created = true;
	                    } catch (SecurityException se) {
	                        se.printStackTrace();
	                    }
	                    if (created) {
	                        System.out.println("DIR created");
	                    }
	                    String path = "";
	                    path = folder + files[i].getOriginalFilename();
	                    File destination = new File(path);
	                    System.out.println("--> " + destination);
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
	//프로필 이미지 올리기 update용
	@RequestMapping(value = "/profile/image", method = RequestMethod.POST)
	public ResponseEntity<String> updateProfilePicture(MultipartFile file,HttpSession session) throws Exception{
		
		String folder = context.getRealPath("/") + "/resources/upload/"+session.getAttribute("id")+"/profilePicture/";
		File theDir = new File(folder);
		theDir.mkdir();
		
		String path = "";
        path = folder + file.getOriginalFilename();
        File destination = new File(path);
        System.out.println("--> " + destination);
        file.transferTo(destination);
        
        String profile = "/resources/upload/"+session.getAttribute("id")+"/profilePicture/"+file.getOriginalFilename();
        userService.updateProfilePicture(profile,(String)session.getAttribute("id"));
        
    	ResponseEntity<String> entity = null;
    	
        return entity = new ResponseEntity<>(profile, HttpStatus.OK);
		
	}
}