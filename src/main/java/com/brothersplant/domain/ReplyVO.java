package com.brothersplant.domain;

import java.util.Date;

public class ReplyVO {
	private int rno;
	private int tbno;
	private String id;
	private String content;
	private Date regdate;
	private Date updatedate;
	public int getRno() {
		return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
	}
	public int getTbno() {
		return tbno;
	}
	public void setTbno(int tbno) {
		this.tbno = tbno;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
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
	@Override
	public String toString() {
		return "ReplyVO [rno=" + rno + ", tbno=" + tbno + ", id=" + id + ", content=" + content + ", regdate=" + regdate
				+ ", updatedate=" + updatedate + "]";
	}
	
	
}
