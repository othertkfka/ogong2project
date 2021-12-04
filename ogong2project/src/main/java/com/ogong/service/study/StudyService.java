package com.ogong.service.study;

import java.util.List;
import java.util.Map;

import com.ogong.common.Search;
import com.ogong.service.domain.GroupStudyMember;
import com.ogong.service.domain.Study;

public interface StudyService {

	public void addStudy(Study study) throws Exception;
	
	public Study getStudy(int studyNo) throws Exception;
	
	public void entranceStudy(int studyNo) throws Exception;
	
	public void leaveStudy(int studyNo) throws Exception;
	
	public Map<String, Object> getStudyList(Search search) throws Exception;
	
	public void deleteStudy(int studyNo) throws Exception;
	
	public void addParticipation(GroupStudyMember gsm) throws Exception;
	
	public List<Study> getMySelfStudy(String email) throws Exception;

	public List<Study> getMyStudy(String email, String endFlag, String approvalFlag) throws Exception;
	
	public void updateNotice(Study study) throws Exception;
}