package com.ogong.service.user.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ogong.service.domain.Board;
import com.ogong.service.domain.User;
import com.ogong.service.user.UserMapper;
import com.ogong.service.user.UserService;

@Service
public class UserServiceImpl implements UserService{

	@Autowired
	UserMapper userDAO;

	@Override
	public void addUser(User user) throws Exception {
		// TODO 자동 생성된 메소드 스텁
		userDAO.addUser(user);
	}
	
	
	  @Override public User getUser(User email) throws Exception {
	  
	  return userDAO.getUser(email); }
	 
	@Override
	public User getProfile(String email) throws Exception {
		// TODO 자동 생성된 메소드 스텁
		return userDAO.getProfile(email);
	}

	@Override
	public void updateProfile(User user) throws Exception {
		userDAO.updateProfile(user);
	}

	  @Override public void Changedpassword(User user) throws Exception {
		  userDAO.Changedpassword(user);
	  
	  }
	 
	@Override
	public User getPassword(String email) throws Exception {
		// TODO Auto-generated method stub
		return userDAO.getPassword(email);
	}

	@Override
	public void updateNickname(User user) throws Exception {
		userDAO.updateNickname(user);
		
	}

	@Override
	public void updatestudyInterest(User user) throws Exception {
		userDAO.updatestudyInterest(user);
		
	}

	@Override
	public void updatename(User user) throws Exception {
		userDAO.updatename(user);
		
	}

	@Override
	public void updatebirth(User user) throws Exception {
		userDAO.updatebirth(user);
		
	}

	@Override
	public void updategender(User user) throws Exception {
		userDAO.updategender(user);
		
	}

	@Override
	public void updategoal(User user) throws Exception {
		userDAO.updategoal(user);

		
	}

	//회원탈퇴
	@Override
	public void withdrawreason(User user) throws Exception {
		userDAO.withdrawreason(user);
		
	}


	@Override
	public void restore(User user) throws Exception {
		// TODO Auto-generated method stub
		userDAO.restore(user);
	}


	public List<Board> list(String email) throws Exception {
		
		
		return userDAO.list(email);
	}


	@Override
	public int idCheck(String nickname) throws Exception {
		// TODO Auto-generated method stub
		return userDAO.idCheck(nickname);
	}
}






















	



	
	

