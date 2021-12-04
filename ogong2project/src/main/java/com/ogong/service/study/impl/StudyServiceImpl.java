package com.ogong.service.study.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ogong.common.Search;
import com.ogong.service.domain.GroupStudyMember;
import com.ogong.service.domain.Study;
import com.ogong.service.study.StudyMapper;
import com.ogong.service.study.StudyService;

@Service
public class StudyServiceImpl implements StudyService {

	@Autowired
	StudyMapper studyMapper;
	
	@Override
	@Transactional
	public void addStudy(Study study) throws Exception {
		
		studyMapper.addStudy(study);
		
	}

	@Override
	public Study getStudy(int studyNo) throws Exception {
		
		return studyMapper.getStudy(studyNo);
		
	}

	@Override
	public void entranceStudy(int studyNo) throws Exception {
		
		studyMapper.updateMember(studyNo, 1);
	}
	
	@Override
	public void leaveStudy(int studyNo) throws Exception {
		// TODO Auto-generated method stub
		studyMapper.updateMember(studyNo, -1);
	}

	@Override
	public Map<String, Object> getStudyList(Search search) throws Exception {
		
		List<Study> list= studyMapper.getStudyList(search);
		int totalCount = studyMapper.getTotalCount(search);
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list", list);
		result.put("totalCount", new Integer(totalCount));
		
		return result;
	}
	
	@Override
	public void deleteStudy(int studyNo) throws Exception {
		studyMapper.deleteStudy(studyNo);
		
	}
	
	@Override
	public void addParticipation(GroupStudyMember gsm) throws Exception {
		// TODO Auto-generated method stub
		studyMapper.addParticipation(gsm);
	}

	@Override
	public List<Study> getMySelfStudy(String email) throws Exception {
		// TODO Auto-generated method stub
		return studyMapper.getMySelfStudy(email);
	}

	@Override
	public List<Study> getMyStudy(String email, String endFlag, String approvalFlag) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("email", email);
		map.put("endFlag", endFlag);
		map.put("approvalFlag", approvalFlag);
		
		return studyMapper.getMyStudy(map);
	}
	
	@Override
	public void updateNotice(Study study) throws Exception {
		// TODO Auto-generated method stub
		studyMapper.updateNotice(study);
	}

}