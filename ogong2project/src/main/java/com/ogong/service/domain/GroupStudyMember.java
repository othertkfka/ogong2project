package com.ogong.service.domain;

import lombok.Data;

@Data
public class GroupStudyMember {

	private int groupStudyMemberNo;
	private Study study;
	private User member;
	private String studyRole;
	private Double diligenceScore;
	private Double participationScore;
	private String participationReason;
	private String determination;
	private String approvalFlag;
	private double attendanceRate;
}
