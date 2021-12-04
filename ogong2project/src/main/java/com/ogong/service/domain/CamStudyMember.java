package com.ogong.service.domain;


import lombok.Data;

@Data
public class CamStudyMember {

	private int camStudyMemberNo;
	private String email;
	private String nickname;
	private int studyNo;
	private String learningTime;
	private String learningType;
	private String entranceTime;
	private String totalLearningTime;

}
