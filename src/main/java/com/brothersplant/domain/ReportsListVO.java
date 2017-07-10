package com.brothersplant.domain;


public class ReportsListVO {
	private int repno;
	private int brno;//게시글 또는 댓글 번호
	private String content;//댓글 내용 또는 게시글 제목 
	private String offender;
	private String reporter;//신고 한놈
	private String senddate;//신고 날짜
	private String reporttype;//신고 유형
	private int reportkind; //신고 종류 1:게시글, 2: 댓글 
	private int tbno;
	
	public int getRepno() {
		return repno;
	}
	public void setRepno(int repno) {
		this.repno = repno;
	}
	public int getBrno() {
		return brno;
	}
	public void setBrno(int brno) {
		this.brno = brno;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
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
	public String getReporttype() {
		return reporttype;
	}
	public void setReporttype(String reporttype) {
		this.reporttype = reporttype;
	}
	public int getReportkind() {
		return reportkind;
	}
	public void setReportkind(int reportkind) {
		this.reportkind = reportkind;
	}
	public String getOffender() {
		return offender;
	}
	public void setOffender(String offender) {
		this.offender = offender;
	}
	
	
	public int getTbno() {
		return tbno;
	}
	public void setTbno(int tbno) {
		this.tbno = tbno;
	}
	@Override
	public String toString() {
		return "ReportsListVO [repno=" + repno + ", brno=" + brno + ", content=" + content + ", offender=" + offender
				+ ", reporter=" + reporter + ", senddate=" + senddate + ", reporttype=" + reporttype + ", reportkind="
				+ reportkind + ", tbno=" + tbno + "]";
	}
	

}