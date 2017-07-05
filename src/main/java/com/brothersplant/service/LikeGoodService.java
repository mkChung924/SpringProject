package com.brothersplant.service;

public interface LikeGoodService {
	public int selectLike(String id, int tbno) throws Exception;
	public void addLike(String id, int tbno) throws Exception;
	public void removeLike(String id, int tbno) throws Exception;
	
	public int selectTotLike(int tbno) throws Exception;
}
