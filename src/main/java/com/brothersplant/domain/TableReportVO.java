package com.brothersplant.domain;

import java.sql.Date;

public class TableReportVO {
	private int tbno;
	private int trno;
	private String title;
	private String content;
	private String offender;
	private String reporter;
	private String senddate;
	private String id;
	
	@Override
	public String toString() {
		return "tableReportVO [tbno=" + tbno + ", trno=" + trno + ", title=" + title + ", content=" + content
				+ ", offender=" + offender + ", reporter=" + reporter + ", senddate=" + senddate + ", id=" + id + "]";
	}

	public int getTbno() {
		return tbno;
	}

	public void setTbno(int tbno) {
		this.tbno = tbno;
	}

	public int getTrno() {
		return trno;
	}

	public void setTrno(int trno) {
		this.trno = trno;
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

	public String getSenddate() {
		return senddate;
	}

	public void setSenddate(String senddate) {
		this.senddate = senddate;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	
	
}
