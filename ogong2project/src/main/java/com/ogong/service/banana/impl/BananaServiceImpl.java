package com.ogong.service.banana.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ogong.service.banana.BananaMapper;
import com.ogong.service.banana.BananaService;
import com.ogong.service.domain.Banana;
import com.ogong.service.domain.User;

@Service
public class BananaServiceImpl implements BananaService{
	
	@Autowired
	BananaMapper bananaMapper;

	
	@Transactional
	@Override
	public void addBanana(Banana banana) throws Exception {

		bananaMapper.addBanana(banana);
		
		if(banana.getBananaAmount() > 0) {
			//바나나 획득
			bananaMapper.updateAcquireBanana(banana);
		} else {
			//바나나 차감
			bananaMapper.updateUseBanana(banana);
		}
	}

	@Override
	public Map<String, Object> getlistBanana(HashMap<String, Object> map) throws Exception {

		List<Banana> list= bananaMapper.getlistBanana(map);
		int totalCount = bananaMapper.getbananaCount(map);
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list", list);
		result.put("totalCount", new Integer(totalCount));
		
		return result;
		
	}
	
	@Override
	public void deleteBanana(int bananaNo) throws Exception{
		
		bananaMapper.deleteBanana(bananaNo);
	}
	
	@Override
	public User adminGetUser(String email) throws Exception {
		return bananaMapper.adminGetUser(email);
	}
	
	
}