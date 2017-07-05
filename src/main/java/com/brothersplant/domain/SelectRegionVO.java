package com.brothersplant.domain;

public class SelectRegionVO {

	  private int ds_id;
	  private String ds_sido;
	  private String ds_gugun;
	  private String ds_dong;
	
	@Override
	public String toString() {
		return "SelectRegionVO [ds_id=" + ds_id + ", ds_sido=" + ds_sido + ", ds_gugun=" + ds_gugun + ", ds_dong="
				+ ds_dong + "]";
	}
	public int getDs_id() {
		return ds_id;
	}
	public void setDs_id(int ds_id) {
		this.ds_id = ds_id;
	}
	public String getDs_sido() {
		return ds_sido;
	}
	public void setDs_sido(String ds_sido) {
		this.ds_sido = ds_sido;
	}
	public String getDs_gugun() {
		return ds_gugun;
	}
	public void setDs_gugun(String ds_gugun) {
		this.ds_gugun = ds_gugun;
	}
	public String getDs_dong() {
		return ds_dong;
	}
	public void setDs_dong(String ds_dong) {
		this.ds_dong = ds_dong;
	}
	
	  
	
}
