package com.ogong.service.domain;

import java.util.Date;

import lombok.Data;

@Data
public class Study {
	
	private int studyNo; 				
	private User studyMaker;			
	private String studyName;			
	private String studyHashtag;		
	private String studyThumbnail;	
	private String studyStartDate;		
	private String studyEndDate;		
	private Date studyRegDate;					
	private int currentMember;			
	private int maxMember;				
	private String selfStudyRule;				
	private String selfStudyPassword;
	private String groupStudyInfo;		
	private String groupStudyPlan;		
	private String groupStudyCondition;	
	private String recruitmentStartDate;
	private String recruitmentEndDate;	
	private String studyEndFlag;		
	private String studyRoomGrade;		
	private String studyType;			
	private String studyInterest;
	private String groupStudyNotice;

}
