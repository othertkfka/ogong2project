package com.ogong.service.learningHistory;

import java.util.List;
import java.util.Map;

import com.ogong.service.domain.LearningHistory;

public interface LearningHistoryService {
	
	public void addLearningHistory(LearningHistory learningHistory) throws Exception;
	
	public List<LearningHistory> getLearningHistoryList(Map<String, Object> map) throws Exception;
	
	public String getTodayLearningTime(String email) throws Exception;
	
	public String getAverageLearningTime(String email) throws Exception;
	
	public String getTotalLearningTime(String email) throws Exception;
	
	public List<LearningHistory> getlineChartTime(Map<String, Object> map) throws Exception;
	
	public List<LearningHistory> getPieChartTime(Map<String, Object> map) throws Exception;
}
