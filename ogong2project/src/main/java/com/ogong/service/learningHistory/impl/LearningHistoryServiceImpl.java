package com.ogong.service.learningHistory.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ogong.service.domain.LearningHistory;
import com.ogong.service.learningHistory.LearningHistoryMapper;
import com.ogong.service.learningHistory.LearningHistoryService;

@Service
public class LearningHistoryServiceImpl implements LearningHistoryService {

	@Autowired
	LearningHistoryMapper learningHistoryMapper;
	
	@Override
	public void addLearningHistory(LearningHistory learningHistory) throws Exception {
		// TODO Auto-generated method stub
		learningHistoryMapper.addLearningHistory(learningHistory);
	}
	
	@Override
	public List<LearningHistory> getLearningHistoryList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return learningHistoryMapper.getLearningHistoryList(map);
	}
	
	@Override
	public String getTodayLearningTime(String email) {
		// TODO Auto-generated method stub
		return learningHistoryMapper.getTodayLearningTime(email);
	}

	@Override
	public String getAverageLearningTime(String email) throws Exception {
		// TODO Auto-generated method stub
		return learningHistoryMapper.getAverageLearningTime(email);
	}

	@Override
	public String getTotalLearningTime(String email) throws Exception {
		// TODO Auto-generated method stub
		return learningHistoryMapper.getTotalLearningTime(email);
	}

	@Override
	public List<LearningHistory> getlineChartTime(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return learningHistoryMapper.getlineChartTime(map);
	}

	@Override
	public List<LearningHistory> getPieChartTime(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return learningHistoryMapper.getPieChartTime(map);
	}
	
}
