package com.brothersplant.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.brothersplant.aop.InterCeptorLoingCheck;
import com.brothersplant.domain.MyBookmarkVO;
import com.brothersplant.domain.SecureVO;
import com.brothersplant.domain.UserInfoVO;

@Repository
public class MyPageDAOImpl implements MyPageDAO {
	
	@Inject
	private SqlSession sql;
	private static final org.slf4j.Logger logger = LoggerFactory.getLogger(InterCeptorLoingCheck.class);
	
	@Override
	public UserInfoVO myPageInfo(String id) throws Exception {
		
		return sql.selectOne("mypage.userinfo",id);
	}

	@Override
	public List<SecureVO> secureCode() throws Exception {
		
		return sql.selectList("secure.seclist");
	}

	@Override
	public void deleteUser(String id) throws Exception {
		sql.delete("mypage.delete",id);
		
	}

	@Override
	public String passMatch(String id, String pass) throws Exception {
		Map<String, String> map = new HashMap<>();
			map.put("id", id);
			map.put("pass", new PassEncrypt().encrypt(pass));
		int result = sql.selectOne("mypage.auth",map);
		if(result>0){
			return "success";
		} 
		return "fail";
	}

	@Override
	public int updateUser(UserInfoVO vo) throws Exception {
		logger.info("doa: " + vo);
		vo.setSecure_ans(new PassEncrypt().encrypt(vo.getSecure_ans()));
		vo.setPassword(new PassEncrypt().encrypt(vo.getPassword()));
		return sql.update("mypage.update",vo);
		
	}

	@Override
	public List<MyBookmarkVO> selectMyBookmark(String id) throws Exception {
		
		return sql.selectList("mypage.selectMyBookmark", id);
	}

}
