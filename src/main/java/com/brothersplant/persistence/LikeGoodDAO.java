package com.brothersplant.persistence;

public interface LikeGoodDAO {
	
	public int selectLike(String id, int tbno) throws Exception;
	public void addLike(String id, int tbno) throws Exception;
	public int removeLike(String id, int tbno) throws Exception;
	
	public int selectTotLike(int tbno) throws Exception;
}
