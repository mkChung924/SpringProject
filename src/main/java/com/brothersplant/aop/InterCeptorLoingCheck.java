package com.brothersplant.aop;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

public class InterCeptorLoingCheck extends HandlerInterceptorAdapter{
 
	private static final org.slf4j.Logger logger = LoggerFactory.getLogger(InterCeptorLoingCheck.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		logger.info("인터셉터요 전");
		HttpSession session = request.getSession();
		if(session.getAttribute("id") ==null && session.getAttribute("page") ==null){
			session.invalidate();
			response.sendRedirect("/index");
			return false;
		}
		return true;
	}
}
