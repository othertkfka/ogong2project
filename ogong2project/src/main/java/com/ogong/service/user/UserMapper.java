package com.ogong.service.user;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.ogong.service.domain.Board;
import com.ogong.service.domain.User;

@Repository
@Mapper
public interface UserMapper {
	
	//회원가입
	void addUser(User user);
	
	//로그인
	User getUser(User email);
//	User getUser (String email);
	
	//프로필보기
	User getProfile(String email);
	
	//프로필수정
	void updateProfile(User user);
	
	//비밀번호 변경
	void Changedpassword(User user);
	
	//비밀번호 찾기
	User getPassword(String email);
	
	// 이메일 중복체크
	public int mailCheck(String email);
	// 닉네임 중복체크
	public int idCheck(String nickname);
	
	//회원탈퇴
	void withdrawreason(User user);
	
	//회원복구
	public void restore(User user);

	
	List<Board> list(String email);
	
	// 닉네임
	void updateNickname(User user) throws Exception;
	// 관심사
	void updatestudyInterest(User user) throws Exception;
	// 이름
	void updatename(User user) throws Exception;
	// 생년월일
	void updatebirth(User user) throws Exception;
	// 성별
	void updategender(User user) throws Exception;
	// 목표와 각오
	void updategoal(User user) throws Exception;
}