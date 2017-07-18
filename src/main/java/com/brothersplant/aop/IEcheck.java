package com.brothersplant.aop;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class IEcheck extends HandlerInterceptorAdapter {

	private static final org.slf4j.Logger logger = LoggerFactory.getLogger(IEcheck.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		String brower = ieFuckyou(request);

		logger.info("브라우저 종류 : "+brower);
		if (brower.equals("MSIE") || brower.equals("Edge")) {
			response.sendRedirect("/IEgoChrome");
			return false;
		}
		return true;
	}

	private String ieFuckyou(HttpServletRequest request) {
		String header = request.getHeader("User-Agent");
		//logger.info(header);
		if (header != null) {
			if (header.indexOf("Trident") > -1) {
				return "MSIE";
			} else if(header.indexOf("Edge") > -1){
				return "Edge";
			} else if (header.indexOf("Chrome") > -1) {
				return "Chrome";
			} else if (header.indexOf("Opera") > -1) {
				return "Opera";
			} else if (header.indexOf("iPhone") > -1 && header.indexOf("Mobile") > -1) {
				return "iPhone";
			} else if (header.indexOf("Android") > -1 && header.indexOf("Mobile") > -1) {
				return "Android";
			} 
		}
		return "Firefox";
	}

}
