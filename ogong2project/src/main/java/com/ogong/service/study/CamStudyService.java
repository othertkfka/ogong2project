package com.ogong.service.study;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ogong.service.domain.CamStudyMember;
import com.ogong.service.domain.LearningHistory;
import com.ogong.service.domain.Study;
import com.ogong.service.domain.User;

public interface CamStudyService {
	
	public User getUser(String email) throws Exception;
	
	public Study getStudy(int studyNo) throws Exception;
	
	public void addCamStudyMember(CamStudyMember csm) throws Exception;
	
	public CamStudyMember getCamStudyMember(int studyNo, String email) throws Exception;
	
	public List<CamStudyMember> getCamStudyMemberList(int studyNo) throws Exception;
	
	public void updateCamStudyMember(CamStudyMember csm) throws Exception;
	
	public void updateCamStudyMemberZero(CamStudyMember csm) throws Exception;
	
	public void deleteCamStudyMember(LearningHistory learningHistory) throws Exception;
}
