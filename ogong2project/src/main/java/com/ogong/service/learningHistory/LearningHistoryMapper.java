package com.ogong.service.learningHistory;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.ogong.service.domain.LearningHistory;

@Repository
@Mapper
public interface LearningHistoryMapper {
	
	void addLearningHistory(LearningHistory learningHistory);
	
	List<LearningHistory> getLearningHistoryList(Map<String, Object> map);
	
	String getTodayLearningTime(String email);
	
	String getAverageLearningTime(String email);
	
	String getTotalLearningTime(String email);
	
	List<LearningHistory> getlineChartTime(Map<String, Object> map);
	
	List<LearningHistory> getPieChartTime(Map<String, Object> map);
}
