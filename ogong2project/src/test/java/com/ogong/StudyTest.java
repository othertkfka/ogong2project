package com.ogong;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.ogong.common.Search;
import com.ogong.service.domain.Calendar;
import com.ogong.service.domain.GroupStudyMember;
import com.ogong.service.domain.Study;
import com.ogong.service.domain.User;
import com.ogong.service.study.StudyService;
import com.ogong.service.studyroom.StudyroomService;

@SpringBootTest
class StudyTest {

	@Autowired
	private StudyService studyService;
	
	@Autowired
	private StudyroomService studyroomService;
	
	@Test
	@DisplayName("그룹 스터디 생성(3개 테이블  insert)")
	void testAddStudy() throws Exception {
		
		Study study = new Study();
		
		
		User user = new User();
		user.setEmail("user08");
		study.setStudyMaker(user);
		study.setStudyName("야 너두 할수있어");
		study.setStudyHashtag("#toeic");
		study.setStudyThumbnail("toeic.jpg");
		study.setStudyStartDate("2021-05-01");
		study.setStudyEndDate("2021-05-15");
		study.setMaxMember(5);
		study.setRecruitmentStartDate("2021-06-01");
		study.setRecruitmentEndDate("2021-06-31");
		study.setStudyRoomGrade("basic");
		study.setStudyType("group");
		study.setStudyInterest("토익");
		
		studyService.addStudy(study);
		
		System.out.println(" 넘어온 시퀀스 studyNo 값 확인 : "+study.getStudyNo());
		
		System.out.println("== 넘어온 시퀀스 값 groupstudymember 테이블에 insert ==");
		
		GroupStudyMember gsm = new GroupStudyMember();
		gsm.setStudy(study);
		gsm.setMember(user);
		gsm.setStudyRole("3");
		gsm.setDiligenceScore(new Double(0));
		gsm.setParticipationScore(new Double(0));
		gsm.setApprovalFlag("1");
		
		studyService.addParticipation(gsm);
		
		System.out.println("== 스터디 시작날짜로 일정 테이블 insert==");
		
		Calendar calendar = new Calendar();
		calendar.setStudy(study);
		calendar.setCalendarStartDate(study.getStudyStartDate());
		calendar.setCalendarEndDate(study.getStudyEndDate());
		
		studyroomService.addCalendar(calendar);
		
	
	}
	
	//@Test
	//@DisplayName("그룹 스터디 정보 조회")
	void testGetStudy() throws Exception {
		
		Study study = studyService.getStudy(10002);
		
		System.out.println("getStudy 결과 :: "+study);

		
	}
	
	//@Test
	//@DisplayName("그룹스터디 목록 조회")
	void testgetStudyList() throws Exception {
		
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(3);
		search.setSearchCondition("1");
		search.setSearchKeyword("");
		
		
		Map<String,Object> result = studyService.getStudyList(search);
		
		List<Object> list = (List<Object>)result.get("list");
		Integer totalCount = (Integer)result.get("totalCount");
		
		System.out.println("list 값 : "+list);
		System.out.println("list size : "+list.size());
		System.out.println("total Count : "+totalCount);
		
		System.out.println("================================");
		
	}
	
	//@Test
	//@DisplayName("그룹스터디 삭제")
	void testDeleteStudy() throws Exception {
			
		studyService.deleteStudy(10002);
			
	}

}
