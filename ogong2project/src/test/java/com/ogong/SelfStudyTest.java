package com.ogong;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.ogong.common.Search;
import com.ogong.service.domain.Study;
import com.ogong.service.domain.User;
import com.ogong.service.study.StudyService;

@SpringBootTest
public class SelfStudyTest {

	@Autowired
	private StudyService studyService;
	
	@Test
	void testMyStudy() throws Exception {
		
		//진행중인 자율스터디
		List<Study> mySelfStudyList = studyService.getMySelfStudy("user01");
		//진행중인 그룹스터디
		List<Study> myGroupStudyList = studyService.getMyStudy("user01", "1", "1");
		//참가신청중인 그룹스터디
		List<Study> myApprovalGroupStudyList = studyService.getMyStudy("user01", "1", "0");
		//종료된 그룹스터디
		List<Study> myEndGroupStudyList = studyService.getMyStudy("user01", "2", "1");
	}
	
	//@Test
	@DisplayName("자율 스터디 생성")
	void testAddStudy() throws Exception {
		
		Study study = new Study();
		User user = new User();
		user.setEmail("user06");
		
		study.setStudyMaker(user);
		study.setStudyName("자율스터디3");
		study.setStudyHashtag("#test3");
		study.setStudyThumbnail("j3.jpg");
		study.setStudyStartDate("2021-08-01");
		study.setStudyEndDate("2021-08-07");
		study.setMaxMember(8);
		study.setSelfStudyRule("자율스터디3 규칙입니다.");
		study.setStudyRoomGrade("basic");
		study.setStudyType("self");
		study.setStudyInterest("기타공부");
		
		studyService.addStudy(study);
		
	}
	
	//@Test
	@DisplayName("자율스터디 정보조회")
	void testGetStudy() throws Exception{
		
		Study study = studyService.getStudy(10008);
		
		System.out.println(study);
	}
	
	//@Test
	@DisplayName("자율스터디 목록조회")
	void testlistStudy() throws Exception {
		
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(3);
		search.setSearchCondition("1");
		search.setSearchKeyword("방");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("studyType", "self");
		
		Map<String,Object> result = studyService.getStudyList(search);
		
		List<Object> list = (List<Object>)result.get("list");
		
		Integer totalCount = (Integer)result.get("totalCount");
		
		System.out.println("list 값 : "+list);
		System.out.println("list size : "+list.size());
		System.out.println("total Count : "+totalCount);
		
		System.out.println("================================");
		
	}
	
}
