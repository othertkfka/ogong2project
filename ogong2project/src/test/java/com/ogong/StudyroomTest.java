package com.ogong;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.ogong.service.domain.Calendar;
import com.ogong.service.domain.GroupStudyMember;
import com.ogong.service.domain.Study;
import com.ogong.service.domain.User;
import com.ogong.service.study.StudyService;
import com.ogong.service.studyroom.StudyroomMapper;
import com.ogong.service.studyroom.StudyroomService;

@SpringBootTest
class StudyroomTest {

	@Autowired
	private StudyroomService studyroomService;
	
	@Autowired
	private StudyService studyService;
	
	
	//@Test
	//@DisplayName("스터디 참가신청 목록")
	void testGetParticipationList() throws Exception {
		
		
		Map<String,Object> result = studyroomService.getParticipationList(10000);
		
		List<Object> list = (List<Object>)result.get("list");
		int totalCount = (Integer)result.get("totalCount");
		
		System.out.println("list 값 : "+list);
		System.out.println("list size : "+list.size());
		System.out.println("total Count : "+totalCount);
		
		System.out.println("================================");
		
	}
	
	
	//@Test
	//@DisplayName("스터디 참가신청 ")
	void testAddGSMember() throws Exception {
		
		GroupStudyMember gsm = new GroupStudyMember();
		Study study = new Study();
		User user = new User();
		study.setStudyNo(10000);
		user.setEmail("user03");
		gsm.setStudy(study);
		gsm.setMember(user);
		gsm.setStudyRole("4");
		gsm.setDiligenceScore(new Double(0));
		gsm.setParticipationScore(new Double(0));
		gsm.setApprovalFlag("0");
		
		studyService.addParticipation(gsm);
		
	}
	
	//@Test
	//@DisplayName("스터디 참가신청 승인")
	void testApplyParticipation() throws Exception {
		
		studyroomService.applyParticipation("user03");
			
	}
	
	//@Test
	//@DisplayName("스터디 참가신청 거절")
	void testRejectParticipation() throws Exception {
		
		studyroomService.rejectParticipation("user01");
			
	}
	
	@Test
	@DisplayName("그룹스터디 회원목록")
	void testGetGSMemberList() throws Exception {
		
		List<GroupStudyMember> list = studyroomService.getGSMemberList(10000);
		
		System.out.println("===================================");
		
		System.out.println("list 값 : "+list);
		System.out.println("list 사이즈 : "+list.size());
		
		System.out.println("===================================");
			
	}
	
	
	
	//@Test
	//@DisplayName("스터디룸 정보수정")
	void testUpdateGSMember() throws Exception {
		
		Study study = studyService.getStudy(10002);
		
		study.setStudyName("수정스터디");
		study.setStudyHashtag("#수정");
		study.setStudyThumbnail("update.jpg");
		study.setGroupStudyInfo("수정");
		study.setGroupStudyPlan("수정");
		study.setGroupStudyCondition("수정");
		
		studyroomService.updateStudy(study);
		
		System.out.println("updateStudy 결과 :: "+study);
		
	}
	
	//@Test
	//@DisplayName("스터디룸 출석")
	void testAddAttendance() throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("studyNo", new Integer(10000));
		map.put("email", "user01");
		
		studyroomService.addAttendance(map);
				
	}
	
	//@Test
	//@DisplayName(" 일정 생성 ")
	void testAddCalendar() throws Exception {
		
		Calendar calendar = new Calendar();
		Study study = studyService.getStudy(10000);
		calendar.setStudy(study);
		calendar.setCalendarTitle("꼬미랑 놀아주는 날");
		calendar.setCalendarContents("꼬미 코코");
		calendar.setCalendarStartDate("2021-07-01");
		calendar.setCalendarEndDate("2021-07-03");
		
		studyroomService.addCalendar(calendar);
		
					
	}
	
	//@Test
	//@DisplayName(" 일정 보기 ")
	void testGetCalendar() throws Exception {
		
		Calendar calendar = studyroomService.getCalendar(10000);
		
		System.out.println(" 일정 :: "+calendar);
		
				
	}
	
	//@Test
	//@DisplayName("그룹스터디 일정 리스트")
	void testGetCalendarList() throws Exception {
		
		List<Calendar> list = studyroomService.getCalendarList(10000);
	
	}
	
	//@Test
	//@DisplayName("일정 수정")
	void testUpdateCalendar() throws Exception {
		
		Calendar calendar = studyroomService.getCalendar(10000);
		
		calendar.setCalendarTitle("수정된 일정");
		calendar.setCalendarContents("수정된 일정 내용");
		
		studyroomService.updateCalendar(calendar);
	}
	
	//@Test
	//@DisplayName("일정 삭제")
	void testDeleteCalendar() throws Exception {
		
		List<Calendar> list = studyroomService.getCalendarList(10000);
	
	}
	
	
	

}
