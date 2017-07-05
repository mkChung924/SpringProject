package com.brothersplant.domain;

import java.sql.Date;

public class ReplyReportsVO {
	int repno;
	int rno;
	String content;
	String offender;
	String reporter;
	Date senddate;
	String id;
	@Override
	public String toString() {
		return "ReplyReportsVO [repno=" + repno + ", rno=" + rno + ", content=" + content + ", offender=" + offender
				+ ", reporter=" + reporter + ", senddate=" + senddate + ", id=" + id + "]";
	}
	public int getRepno() {
		return repno;
	}
	public void setRepno(int repno) {
		this.repno = repno;
	}
	public int getRno() {
		return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getOffender() {
		return offender;
	}
	public void setOffender(String offender) {
		this.offender = offender;
	}
	public String getReporter() {
		return reporter;
	}
	public void setReporter(String reporter) {
		this.reporter = reporter;
	}
	public Date getSenddate() {
		return senddate;
	}
	public void setSenddate(Date senddate) {
		this.senddate = senddate;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	
}