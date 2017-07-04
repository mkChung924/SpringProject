package com.brothersplant.domain;

public class CategoryInfoVO {
	
	private String do1;
	private String si;
	private String dong;
	private String place1;
	private String place2;
	private String cno;
	private String csno;
	private int pageNum;
	
	@Override
	public String toString() {
		return "CategoryInfoVO [do1=" + do1 + ", si=" + si + ", dong=" + dong + ", place1=" + place1 + ", place2="
				+ place2 + ", cno=" + cno + ", csno=" + csno + ", pageNum=" + pageNum + "]";
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
	public int getPageNum() {
		return pageNum;
	}
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}
	
	
	
}
