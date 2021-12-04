package com.ogong.service.admin.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ogong.service.admin.AdminMapper;
import com.ogong.service.admin.AdminService;
import com.ogong.service.domain.Report;
import com.ogong.service.domain.User;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	AdminMapper adminMapper;
	
	@Override
	public void addReport(Report report) throws Exception{
		
		adminMapper.addReport(report);
		
	}
	
	@Override
	public Map<String, Object> getlistReport(HashMap<String, Object> map) throws Exception {

		List<Report> list= adminMapper.getlistReport(map);
		int totalCount = adminMapper.getReportTotalCount(map);
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list", list);
		result.put("totalCount", new Integer(totalCount));
		
		return result;
	}
	
	@Override
	public Map<String, Object> getlistUserReport(HashMap<String, Object> map) throws Exception{
		
		List<Report> list= adminMapper.getlistUserReport(map);
		int totalCount = adminMapper.getUserReportTotalCount(map);
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list", list);
		result.put("totalCount", new Integer(totalCount));
		
		return result;
		
	}
	

	@Override
	public Map<String, Object> getlistTotalUser(HashMap<String, Object> map) throws Exception {
		List<User> list= adminMapper.getlistTotalUser(map);
		int totalCount = adminMapper.getUserTotalCount(map);
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list", list);
		result.put("totalCount", new Integer(totalCount));
		
		return result;
	}
	
	@Override
	public void updateUserSuspend(Report report) throws Exception {
		adminMapper.updateUserSuspend(report);
		
	}

	@Override
	public void updateUserRestore(String email) throws Exception {
		adminMapper.updateUserRestore(email);
		
	}
	

	



}
