package com.brothersplant.domain;

public class MyBookmarkVO {
	
	private int tbno;
	private String nickname;
	private String title;
	private String regdate;
	private int cno;
	private int csno;
	private String cname;
	private String csname;
	private int likes;
	private int viewcnt;
	
	@Override
	public String toString() {
		return "MyBookmarkVO [tbno=" + tbno + ", nickname=" + nickname + ", title=" + title + ", regdate=" + regdate
				+ ", cno=" + cno + ", csno=" + csno + ", cname=" + cname + ", csname=" + csname + ", likes=" + likes
				+ ", viewcnt=" + viewcnt + ", getClass()=" + getClass() + ", hashCode()=" + hashCode() + ", toString()="
				+ super.toString() + "]";
	}

	public int getTbno() {
		return tbno;
	}

	public void setTbno(int tbno) {
		this.tbno = tbno;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
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

	public int getLikes() {
		return likes;
	}

	public void setLikes(int likes) {
		this.likes = likes;
	}

	public int getViewcnt() {
		return viewcnt;
	}

	public void setViewcnt(int viewcnt) {
		this.viewcnt = viewcnt;
	}
	
	
	
}
