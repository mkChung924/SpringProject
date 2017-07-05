package com.brothersplant.domain;

import java.util.Date;

public class UserInfoVO {
	
	private String id;
	private String password;
	private String name;
	private String nickname;
	private String birth;
	private String email;
	private String tel;
	private String addr;
	private String profile;
	private String secure;
	private String secure_ans;
	private String regdate;
	private String updatedate;
	private int auth;
	private int myBoards;
	private int replyCount;
	

	
	@Override
	public String toString() {
		return "UserInfoVO [id=" + id + ", password=" + password + ", name=" + name + ", nickname=" + nickname
				+ ", birth=" + birth + ", email=" + email + ", tel=" + tel + ", addr=" + addr + ", profile=" + profile
				+ ", secure=" + secure + ", secure_ans=" + secure_ans + ", regdate=" + regdate + ", updatedate="
				+ updatedate + ", auth=" + auth + ", myBoards=" + myBoards + ", replyCount=" + replyCount + "]";
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	
	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}

	public String getSecure() {
		return secure;
	}
	public void setSecure(String secure) {
		this.secure = secure;
	}
	public String getSecure_ans() {
		return secure_ans;
	}
	public void setSecure_ans(String secure_ans) {
		this.secure_ans = secure_ans;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public String getUpdatedate() {
		return updatedate;
	}
	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}

	public int getAuth() {
		return auth;
	}

	public void setAuth(int auth) {
		this.auth = auth;
	}

	public int getMyBoards() {
		return myBoards;
	}

	public void setMyBoards(int myBoards) {
		this.myBoards = myBoards;
	}

	public int getReplyCount() {
		return replyCount;
	}

	public void setReplyCount(int replyCount) {
		this.replyCount = replyCount;
	}
	
	
	

}
