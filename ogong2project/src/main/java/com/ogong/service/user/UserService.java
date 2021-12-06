package com.ogong.service.user;


import java.util.List;

import org.springframework.stereotype.Service;

import com.ogong.service.domain.Board;
import com.ogong.service.domain.User;

@Service
public interface UserService {

	//	회원가입

	public void addUser(User user) throws Exception;


	//로그인
	public User getUser(User email) throws Exception;

	//프로필 보기
	public   User getProfile(String email)throws Exception;

	// 프로필 수정 
	public void updateProfile(User user) throws Exception;


	//비밀번호 변경 
	public void Changedpassword(User user) throws Exception;


	//비밀번호 찾기
	User getPassword(String email) throws Exception;

	// 회원탈퇴

	void withdrawreason(User user) throws Exception;

	// 회원복구
	void restore(User user) throws Exception;

	// 이메일 중복확인
	public int mailCheck(String nickname) throws Exception;
	// 닉네임 중복확인
	public int idCheck(String nickname) throws Exception;

	// 닉네임
	public void updateNickname(User user) throws Exception;
	// 관심사
	public void updatestudyInterest(User user) throws Exception;
	// 이름
	public void updatename(User user) throws Exception;
	// 생년월일
	public void updatebirth(User user) throws Exception;
	// 성별
	public void updategender(User user) throws Exception;
	// 목표와 각오
	public void updategoal(User user) throws Exception;

	
	//게시판 조회
	List<Board> list(String email) throws Exception;
}