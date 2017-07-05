package com.brothersplant.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.brothersplant.persistence.LikeGoodDAO;
@Service
public class LikeGoodServiceImpl implements LikeGoodService {

	@Inject
	private LikeGoodDAO dao;
	
	@Override
	public int selectLike(String id, int tbno) throws Exception {
		return dao.selectLike(id, tbno);
	}

	@Override
	public void addLike(String id, int tbno) throws Exception {
		dao.addLike(id, tbno);
	}

	@Override
	public void removeLike(String id, int tbno) throws Exception {
		dao.removeLike(id, tbno);
	}

	@Override
	public int selectTotLike(int tbno) throws Exception {
		return dao.selectTotLike(tbno);
	}

}
