package com.brothersplant.persistence;

import java.util.List;

import com.brothersplant.domain.UserInfoVO;

public interface UserInfoDAO {
		
	//DB 입장에서
	
	public void insert(UserInfoVO vo) throws Exception; //회원가입
	public void update(UserInfoVO vo) throws Exception; // 정보수정
	public void delete(String id, String pass) throws Exception; //계정 삭제
	public boolean select(String id, String pass) throws Exception; //로그인
	public String proove(String id, String name, String secure_code, String secure_ans) throws Exception; //비밀번호 찾기시 보안질문과 답을 담아옴
	public void updatePassword(String id, String pass) throws Exception;
	public List<String> readId(String name, String birth) throws Exception; //아이디 찾기를 위한 이름과 생년월일
	public String checkId(String id, String pass) throws Exception; //정보수정 및 탈퇴시 본인확인을 위한 아이디 검색
	public boolean dupCheck(String id)throws Exception;
	public boolean nickCheck(String nickname) throws Exception;
	public String selectprofile(String id)throws Exception;
	public int selectAuth(String id) throws Exception;
	public int updateProfilePicture(String profile,String id) throws Exception;

}
