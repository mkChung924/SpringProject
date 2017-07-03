package com.brothersplant.domain;

public class BoardListVO {
	
	/*
	 * 
	 * profile, name, tbl_boards.id, tbl_boards.regdate, (15 - (sysdate - tbl_boards.regdate)) ddate, do1, si, dong, cname, csname, tbl_boards.tbno, title, (select count(*) 
	 * from tbl_like where tbno = 1) likes, (select count(*) from tbl_replies where tbno = 1) replies, (select count(*) from bookmark where tbno = 1) myfavor
	 */
	
	private String profile;
	private String name;
	private String id;
	private String regdate;
	private String ddate;
	private String do1;
	private String si;
	private String dong;
	private int cno;
	private int csno;
	private String cname;
	private String csname;
	private String tbno;
	private String title;
	private String likes;
	private String replies;
	private String myfavor;
	
	@Override
	public String toString() {
		return "BoardListVO [profile=" + profile + ", name=" + name + ", id=" + id + ", regdate=" + regdate + ", ddate="
				+ ddate + ", do1=" + do1 + ", si=" + si + ", dong=" + dong + ", cno=" + cno + ", csno=" + csno
				+ ", cname=" + cname + ", csname=" + csname + ", tbno=" + tbno + ", title=" + title + ", likes=" + likes
				+ ", replies=" + replies + ", myfavor=" + myfavor + "]";
	}

	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public String getDdate() {
		return ddate;
	}

	public void setDdate(String ddate) {
		this.ddate = ddate;
	}

	public String getDo1() {
		return do1;
	}

	public void setDo1(String do1) {
		this.do1 = do1;
	}

	public String getSi() {
		return si;
	}

	public void setSi(String si) {
		this.si = si;
	}

	public String getDong() {
		return dong;
	}

	public void setDong(String dong) {
		this.dong = dong;
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

	public String getTbno() {
		return tbno;
	}

	public void setTbno(String tbno) {
		this.tbno = tbno;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getLikes() {
		return likes;
	}

	public void setLikes(String likes) {
		this.likes = likes;
	}

	public String getReplies() {
		return replies;
	}

	public void setReplies(String replies) {
		this.replies = replies;
	}

	public String getMyfavor() {
		return myfavor;
	}

	public void setMyfavor(String myfavor) {
		this.myfavor = myfavor;
	}
	
	
	
	

}
