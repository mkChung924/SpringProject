package com.brothersplant.persistence;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class LikeGoodDAOImpl implements LikeGoodDAO {

	@Inject
	private SqlSession session;

	private static final String namespace = "likeGood";
	
	@Override
	public int selectLike(String id, int tbno) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("id", id);
		map.put("tbno", tbno);
		System.out.println("like dao : "+tbno);
		return session.selectOne(namespace+".selectLike", map);
	}

	@Override
	public void addLike(String id, int tbno) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("id", id);
		map.put("tbno", tbno);
		session.insert(namespace+".addLike", map);
	}

	@Override
	public int removeLike(String id, int tbno) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("id", id);
		map.put("tbno", tbno);
		System.out.println(id+" : "+tbno);
		return session.delete(namespace+".removeLike", map);
	}

	@Override
	public int selectTotLike(int tbno) throws Exception {
		System.out.println("like dao tot : "+tbno);
		return session.selectOne(namespace+".selectTotLike",tbno);
	}

}
