package com.ogong.service.domain;

import lombok.Data;

@Data
public class File {
	
	private int fileNo;
	private String fileName;
	private Board fileBoard;
	private Study fileStudy;
	
}
