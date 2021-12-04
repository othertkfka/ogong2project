package com.ogong.service.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.ogong.common.Search;
import com.ogong.service.domain.Report;
import com.ogong.service.domain.User;


@Repository
@Mapper
public interface AdminMapper {
	
	//신고하기
	public int addReport(Report report);
	
	//신고 목록
	List<Report> getlistReport(HashMap<String, Object> map);
	
	//신고된 사용자 목록
	List<Report> getlistUserReport(HashMap<String, Object> map);
	
	//모든 회원 목록
	List<User> getlistTotalUser(HashMap<String, Object> map);
		
	//회원 정지
	void updateUserSuspend(Report report);
	
	//회원 복구
	void updateUserRestore(String email);
	
	//신고목록 페이지 수
	int getReportTotalCount(HashMap<String, Object> map);
	
	//신고된 사용자 페이지
	int getUserReportTotalCount(HashMap<String, Object> map);
	
	//유저 페이지 수
	int	getUserTotalCount(HashMap<String, Object> map);
	

	
	
	
}
