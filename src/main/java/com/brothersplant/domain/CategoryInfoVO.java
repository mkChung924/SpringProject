package com.brothersplant.domain;

public class CategoryInfoVO {
	
	private String do1;
	private String si;
	private String dong;
	private String p1;
	private String p2;
	private String cno;
	private String csno;
	
	@Override
	public String toString() {
		return "TravelInfoVO [do1=" + do1 + ", si=" + si + ", dong=" + dong + ", p1=" + p1 + ", p2=" + p2 + ", cno="
				+ cno + ", csno=" + csno + "]";
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
	public String getP1() {
		return p1;
	}
	public void setP1(String p1) {
		this.p1 = p1;
	}
	public String getP2() {
		return p2;
	}
	public void setP2(String p2) {
		this.p2 = p2;
	}
	public String getCno() {
		return cno;
	}
	public void setCno(String cno) {
		this.cno = cno;
	}
	public String getCsno() {
		return csno;
	}
	public void setCsno(String csno) {
		this.csno = csno;
	}

}
