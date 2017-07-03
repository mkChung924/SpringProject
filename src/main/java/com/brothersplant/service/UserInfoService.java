package com.brothersplant.service;

import java.util.List;

import com.brothersplant.domain.UserInfoVO;

public interface UserInfoService {
	
	//유저입장에서
	
	public void create(UserInfoVO vo) throws Exception; //회원가입
	public void update(UserInfoVO vo) throws Exception; // 정보수정
	public void delete(String id, String pass) throws Exception; //계정 삭제
	public boolean login(String id, String pass) throws Exception; //로그인
	public String changePassword(String id, String name, String secure_code, String secure_ans) throws Exception; //비밀번호 찾기시 보안질문과 답을 담아옴
	public void modifyPassword(String id, String pass) throws Exception;
	public List<String> findId(String name, String birth) throws Exception; //아이디 찾기를 위한 이름과 생년월일
	public String checkId(String id, String pass) throws Exception; //정보수정 및 탈퇴시 본인확인을 위한 아이디 검색
	public boolean dupCheck(String id) throws Exception;
	public boolean checkNickname(String nickname) throws Exception;

}
