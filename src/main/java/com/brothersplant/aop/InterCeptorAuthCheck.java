package com.brothersplant.aop;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class InterCeptorAuthCheck extends HandlerInterceptorAdapter{
	private static final org.slf4j.Logger logger = LoggerFactory.getLogger(InterCeptorLoingCheck.class);
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		logger.info("auth 인터셉터");
		if( ((int)session.getAttribute("auth")) ==1){//일반 유저라면
			response.sendRedirect("/index");
			return false;
		}
		return true;
	}
	
}
