package com.ogong.service.domain;

import java.util.Date;

import lombok.Data;

@Data
public class Report {
	
	private int reportNo; 				
	private Answer reportAnswer;		
	private Comment reportComment;		
	private Board reportBoard;		
	private User receiveReporter;
	private User sendReporter;
	private String reportReason;	
	private String reportDate;		
	private String suspendType;		

}
