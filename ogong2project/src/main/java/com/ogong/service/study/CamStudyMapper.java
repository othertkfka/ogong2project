package com.ogong.service.study;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.ogong.service.domain.CamStudyMember;
import com.ogong.service.domain.LearningHistory;
import com.ogong.service.domain.Study;
import com.ogong.service.domain.User;

@Repository
@Mapper
public interface CamStudyMapper {
   
   User getUser(String email);
   
   Study getStudy(int studyNo);
   
   void addCamStudyMember(CamStudyMember csm);
   
   CamStudyMember getCamStudyMember(@Param("studyNo") int studyNo, @Param("email") String email);
   
   List<CamStudyMember> getCamStudyMemberList(int studyNo);
   
   void updateCamStudyMember(CamStudyMember csm);
   
   void updateCamStudyMemberZero(CamStudyMember csm);
   
   void deleteCamStudyMember(LearningHistory learningHistory);
}