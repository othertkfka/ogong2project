package com.ogong;

import java.util.HashMap;
import java.util.List;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.ogong.service.domain.LearningHistory;
import com.ogong.service.learningHistory.LearningHistoryMapper;


@SpringBootTest
public class LearningHistoryTest {

	@Autowired
	LearningHistoryMapper learningHistoryMapper;
	
	@Test
	@DisplayName("공부기록 목록 조회")
	void testGetLearningHistoryList() {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("email", "user01");
		map.put("month", "2021-07");
		
		List<LearningHistory> list = learningHistoryMapper.getLearningHistoryList(map);
		
		System.out.println(list);
	}
	
	//@Test
	@DisplayName("오늘 공부 시간 조회")
	void testGetTodayLearningTime() {
		
		String time = learningHistoryMapper.getTodayLearningTime("user01");
		
		System.out.println("오늘 공부 시간 : " + time);
	}
	
	//@Test
	@DisplayName("일 평균 공부 시간 조회")
	void testGetAverageLearningTime() {
		
		String time = learningHistoryMapper.getAverageLearningTime("user01");
		
		System.out.println("일 평균 공부 시간 : " + time);
	}
	
	//@Test
	@DisplayName("전체 공부 시간 조회")
	void testGetTotalLearningTime() {
		
		String time = learningHistoryMapper.getTotalLearningTime("user01");
		
		System.out.println("전체 공부 시간 : " + time);
	}
	
}
