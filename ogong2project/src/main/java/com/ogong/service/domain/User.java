package com.ogong.service.domain;

import java.util.Date;

import lombok.Data;

@Data
public class User {

	private String email;
	private String role;
	private String condition;
	private String nickname;
	private String password;
	private String name;
	private String birth;
	private String gender;
	private String userImage;
	private String goal;
	private String withdrawDate;
	private String restoreDate;
	private String restoreReason;
	private Double diligenceRate;
	private Double participationRate;
	private int userTargetTime;
	private String regDate;
	private int bananaCount;
	private String suspendStartDate;
	private String suspendEndDate;
	private String studyInterest1;
	private String studyInterest2;
	private String studyInterest3;
	private String withdrawReason;



}
