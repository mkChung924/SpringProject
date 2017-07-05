package com.brothersplant.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.brothersplant.domain.UserInfoVO;

@Repository
public class UserInfoDAOImpl implements UserInfoDAO {
	
	@Inject
	private SqlSession sql;

	@Override
	public void insert(UserInfoVO vo) throws Exception {
		//System.out.println("dao: " + vo);
		sql.insert("userinfo.insert",vo);

	}

	@Override
	public void update(UserInfoVO vo) throws Exception {
		

	}

	@Override
	public void delete(String id, String pass) throws Exception {
		

	}


	@Override
	public List<String> readId(String name, String birth) throws Exception {
		
		Map<String, String> map = new HashMap<>();
		map.put("name", name);
		map.put("birth", birth);
		return sql.selectList("userinfo.readId",map);
	}

	@Override
	public String checkId(String id, String pass) throws Exception {
		
		return null;
	}

	@Override
	public boolean dupCheck(String id) throws Exception {
		if(sql.selectOne("userinfo.dupCheck",id) == null) return true;
		return false;
	}

	@Override
	public boolean select(String id, String pass) throws Exception {
		String password = sql.selectOne("userinfo.login",id);
		System.out.println("검색된 비밀번호: " + password);
		System.out.println("내가 입력한 비밀번호: " + pass);
		if(password == null) return false;
		if(password.equals(pass)) return true;
		else return false;
	}

	@Override
	public String proove(String id, String name, String secure, String secure_ans) throws Exception {
		Map<String, String> map = new HashMap<>();
		map.put("id", id);
		map.put("name", name);
		List<UserInfoVO> secureList = sql.selectList("userinfo.passChange",map);
		if(secureList.size() > 0){
			if(secureList.get(0).getSecure().equals(secure) && secureList.get(0).getSecure_ans().equals(secure_ans)){
				return "pass";
			} else {
				return "not_pass";
			}
		} else {
			return "no_data";
		}

	}

	@Override
	public void updatePassword(String id, String pass) throws Exception {
		Map<String, String> map = new HashMap<>();
		map.put("id", id);
		map.put("password", pass);
		
		sql.update("userinfo.updatePassword",map);
		
	}

	@Override
	public boolean nickCheck(String nickname) throws Exception {
		
		System.out.println("dao: " + nickname);
		Map<String, String> map = new HashMap<>();
		map.put("nickname", nickname);
		String nick = sql.selectOne("userinfo.nickCheck", map);
		if(nick == null){
			return true;
		} else {
			return false;
		}
		
	}

	@Override
	public String selectprofile(String id) throws Exception {
		Map<String, String> map = new HashMap<>();
		map.put("id", id);
		return sql.selectOne("userinfo.selectprofile",map);
	}

}
