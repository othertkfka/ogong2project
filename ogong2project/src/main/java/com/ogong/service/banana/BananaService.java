package com.ogong.service.banana;

import java.util.HashMap;
import java.util.Map;

import com.ogong.common.Search;
import com.ogong.service.domain.Banana;
import com.ogong.service.domain.User;

public interface BananaService {

	// 바나나 인서트
	public void addBanana(Banana banana) throws Exception;
	
	// 획득처 리스트
	public Map<String, Object> getlistBanana(HashMap<String, Object> map) throws Exception;
	
	// 바나나 리스트 삭제
	public void deleteBanana(int bananaNo) throws Exception;
	
	// 유저 정보
	public User adminGetUser(String email) throws Exception;
}