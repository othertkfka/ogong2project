package com.ogong.service.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ogong.common.Search;
import com.ogong.service.domain.Report;
import com.ogong.service.domain.User;

public interface AdminService {
	
	// 신고하기
	public void addReport(Report report) throws Exception;
	
	// 신고 목록 조회
	public Map<String, Object> getlistReport(HashMap<String, Object> map) throws Exception;
	
	// 신고 사용자 목록 조회
	public Map<String, Object> getlistUserReport(HashMap<String, Object> map) throws Exception;
	
	// 모든 회원 조회
	public Map<String, Object> getlistTotalUser(HashMap<String, Object> map) throws Exception;
	
	// 회원 정지하기
	public void updateUserSuspend(Report report) throws Exception;
	
	// 회원 복구하기
	public void updateUserRestore(String email) throws Exception;
	
	
}
