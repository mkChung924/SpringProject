package com.brothersplant.domain;

public class BoardsCountListVO {
	
	private int cno;
	private int csno;
	private String cname;
	private String csname;
	private int count;
	@Override
	public String toString() {
		return "BoardsCountList [cno=" + cno + ", csno=" + csno + ", cname=" + cname + ", csname=" + csname + ", count="
				+ count + "]";
	}
	public int getCno() {
		return cno;
	}
	public void setCno(int cno) {
		this.cno = cno;
	}
	public int getCsno() {
		return csno;
	}
	public void setCsno(int csno) {
		this.csno = csno;
	}
	public String getCname() {
		return cname;
	}
	public void setCname(String cname) {
		this.cname = cname;
	}
	public String getCsname() {
		return csname;
	}
	public void setCsname(String csname) {
		this.csname = csname;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	
	
	
	

}
