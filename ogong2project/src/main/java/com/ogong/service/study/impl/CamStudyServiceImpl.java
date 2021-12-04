package com.ogong.service.study.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ogong.service.domain.CamStudyMember;
import com.ogong.service.domain.LearningHistory;
import com.ogong.service.domain.Study;
import com.ogong.service.domain.User;
import com.ogong.service.study.CamStudyMapper;
import com.ogong.service.study.CamStudyService;

@Service
public class CamStudyServiceImpl implements CamStudyService {

	@Autowired
	CamStudyMapper camStudyMapper;
	
	@Override
	public User getUser(String email) throws Exception {
		// TODO Auto-generated method stub
		return camStudyMapper.getUser(email);
	}

	@Override
	public Study getStudy(int studyNo) throws Exception {
		// TODO Auto-generated method stub
		return camStudyMapper.getStudy(studyNo);
	}

	@Override
	public void addCamStudyMember(CamStudyMember csm) throws Exception {
		// TODO Auto-generated method stub
		camStudyMapper.addCamStudyMember(csm);
	}

	@Override
	public CamStudyMember getCamStudyMember(int studyNo, String email) throws Exception {
		// TODO Auto-generated method stub
		return camStudyMapper.getCamStudyMember(studyNo, email);
	}

	@Override
	public List<CamStudyMember> getCamStudyMemberList(int studyNo) throws Exception {
		// TODO Auto-generated method stub
		return camStudyMapper.getCamStudyMemberList(studyNo);
	}

	@Override
	public void updateCamStudyMember(CamStudyMember csm) throws Exception {
		// TODO Auto-generated method stub
		camStudyMapper.updateCamStudyMember(csm);
	}

	@Override
	public void updateCamStudyMemberZero(CamStudyMember csm) throws Exception {
		// TODO Auto-generated method stub
		camStudyMapper.updateCamStudyMemberZero(csm);
	}
	
	@Override
	public void deleteCamStudyMember(LearningHistory learningHistory) throws Exception {
		// TODO Auto-generated method stub
		camStudyMapper.deleteCamStudyMember(learningHistory);
	}

}
