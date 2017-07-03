package com.brothersplant.aop;

import java.util.Arrays;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

@Component
@Aspect // 공통관심 사항
public class SampleAdvice {
	
	private static final Logger logger = LoggerFactory.getLogger(SampleAdvice.class);
	 // service패지지에 있는 모든 메소드들(파라미터를 가지는)이 실행되기 Before가 먼저 실행됨
	
	@Around("execution(* com.brothersplant.service.MessageService*.*(..))")
	public Object timeLog(ProceedingJoinPoint joinPoint) throws Throwable{
		logger.info("-------------전처리-------------");
		System.out.println("## [전달 데이터] : " + Arrays.toString(joinPoint.getArgs()));
		long start = System.currentTimeMillis();
		
		Object result = joinPoint.proceed();
		
		long end = System.currentTimeMillis();
		
		System.out.println("## ["+ joinPoint.getSignature().getName()+ "] 메소드 실행시간 >>>> " + (end - start) / 1000.0);
		logger.info("-------------후처리--------------");
		
		
		return result;
	}

}
