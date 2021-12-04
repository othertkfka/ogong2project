package com.ogong.service.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class Comment {

	private int commentNo;
	private int boardNo;
	private User commentWriter;
	private String nickname;
	private String commentContents;
	private String commentRegDate;
	

}
