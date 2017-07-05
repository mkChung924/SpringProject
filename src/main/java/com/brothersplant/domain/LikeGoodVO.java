package com.brothersplant.domain;

import java.util.Date;

public class LikeGoodVO {
	private int lno;
	private int tbno;
	private String id;
	private Date regdate;
	private Date updatedate;
	public int getLno() {
		return lno;
	}
	public void setLno(int lno) {
		this.lno = lno;
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
		return "LikeGoodVO [lno=" + lno + ", tbno=" + tbno + ", id=" + id + ", regdate=" + regdate + ", updatedate="
				+ updatedate + "]";
	}
	
	
}
