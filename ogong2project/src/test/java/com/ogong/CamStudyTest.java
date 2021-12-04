package com.ogong;

import java.util.List;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.ogong.service.domain.CamStudyMember;
import com.ogong.service.study.CamStudyService;

@SpringBootTest
public class CamStudyTest {

	@Autowired
	CamStudyService camStudyService;
	
	//@Test
	@DisplayName("화상스터디멤버조회")
	void testCamStudyMemberList() throws Exception{
		List<CamStudyMember> list = camStudyService.getCamStudyMemberList(10001);
		
		for(int i=0; i<list.size(); i++) {
			System.out.println("멤버 : "+list.get(i));
		}
	}
	
	//@Test
	@DisplayName("공부시간 업데이트")
	void testUpdateCamStudyMember() throws Exception{
		CamStudyMember csm = new CamStudyMember();
		csm.setEmail("user01");
		csm.setStudyNo(10001);
		csm.setLearningTime("00:15:30");
		
		camStudyService.updateCamStudyMember(csm);
	}
	
	@Test
	@DisplayName("누적공부시간 업데이트")
	void testUpdateCamStudyMemberZero() throws Exception{
		CamStudyMember csm = new CamStudyMember();
		csm.setEmail("user01");
		csm.setStudyNo(10001);
		csm.setLearningType("토익");
		
		camStudyService.updateCamStudyMemberZero(csm);
	}
}
