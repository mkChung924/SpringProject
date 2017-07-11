package com.brothersplant.domain;

import java.sql.Date;

public class BoardVO {// 13
	private int tbno;
	private int tb_kind;
	private String id;
	private String nickname;
	private int cno;
	private int csno;
	private String cname;
	private String csname;
	private String do1;
	private String si;
	private String dong;
	private String place1;
	private String place2;
	private String title;
	private String content;
	private String notice;
	private String openchat;
	private int myFavor;
	private int likes;
	private int viewcnt;
	private Date regdate;
	private Date updatedate;
	private String image;
	private int replies;
	private int reviews;

	@Override
	public String toString() {
		return "BoardVO [tbno=" + tbno + ", tb_kind=" + tb_kind + ", id=" + id + ", nickname=" + nickname + ", cno="
				+ cno + ", csno=" + csno + ", cname=" + cname + ", csname=" + csname + ", do1=" + do1 + ", si=" + si
				+ ", dong=" + dong + ", place1=" + place1 + ", place2=" + place2 + ", title=" + title + ", content="
				+ content + ", notice=" + notice + ", openchat=" + openchat + ", myFavor=" + myFavor + ", likes="
				+ likes + ", viewcnt=" + viewcnt + ", regdate=" + regdate + ", updatedate=" + updatedate + ", image="
				+ image + ", replies=" + replies + ", reviews=" + reviews + "]";
	}


	public int getReviews() {
		return reviews;
	}



	public void setReviews(int reviews) {
		this.reviews = reviews;
	}



	public int getReplies() {
		return replies;
	}

	public void setReplies(int replies) {
		this.replies = replies;
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

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public int getTbno() {
		return tbno;
	}

	public void setTbno(int tbno) {
		this.tbno = tbno;
	}

	public int getTb_kind() {
		return tb_kind;
	}

	public void setTb_kind(int tb_kind) {
		this.tb_kind = tb_kind;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
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

	public String getPlace1() {
		return place1;
	}

	public void setPlace1(String place1) {
		this.place1 = place1;
	}

	public String getPlace2() {
		return place2;
	}

	public void setPlace2(String place2) {
		this.place2 = place2;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getNotice() {
		return notice;
	}

	public void setNotice(String notice) {
		this.notice = notice;
	}

	public String getOpenchat() {
		return openchat;
	}

	public void setOpenchat(String openchat) {
		this.openchat = openchat;
	}


	public int getMyFavor() {
		return myFavor;
	}

	public void setMyFavor(int myFavor) {
		this.myFavor = myFavor;
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

	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}

	public Date getUpdatedate() {
		return updatedate;
	}

	public void setUpdatedate(Date updatedate) {
		this.updatedate = updatedate;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}



}
