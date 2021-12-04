package com.ogong.service.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class Answer {

	private int answerNo;
	private String answerContents;
	private String answerRegDate;
	private String email;
	private String nickname;
	private String userImage;
	private int boardNo;
	private String adoptionFlag;
	private Date adoptionDate;
	private int adoptionCount;
	
}
