package com.brothersplant.domain;


public class InsertMessageVO {
	private int mno;
	private String title;
	private String content;
	private String targetid;
	private String sender;
	private String senddate;
	
	public int getMno() {
		return mno;
	}
	public void setMno(int mno) {
		this.mno = mno;
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
	public String getTargetid() {
		return targetid;
	}
	public void setTargetid(String targetid) {
		this.targetid = targetid;
	}
	public String getSender() {
		return sender;
	}
	public void setSender(String sender) {
		this.sender = sender;
	}
	public void setSenddate(String senddate){
		this.senddate = senddate;
	}
	
	public String getSenddate(){
		return senddate;
	}
	
	@Override
	public String toString() {
		return "insertMessageVO [mno=" + mno + ", title=" + title + ", content=" + content + ", targetid=" + targetid
				+ ", sender=" + sender + ", senddate=" + senddate + "]";
	}
	
}
