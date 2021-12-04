package com.ogong.service.domain;

import lombok.Data;

@Data
public class Calendar {

	private int calendarNo;			
	private Study study;		
	private String calendarTitle;		
	private String calendarContents;	
	private String calendarStartDate;		
	private String calendarEndDate;
	private String calendarColor;
	
}
