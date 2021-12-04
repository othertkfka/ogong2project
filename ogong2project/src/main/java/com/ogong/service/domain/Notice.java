package com.ogong.service.domain;

import java.util.Date;

import lombok.Data;

@Data
public class Notice {

	private int noticeNo;
	private Study noticeStudy;
	private Board noticeBoard;
	private Answer noticeAnswer;
	private GroupStudyMember noticeGroupMember;
	private User noticeUser;
	private User sender;
	private String noticeCategory;
	private String noticeCondition;
	private String noticeDate;
	
}
