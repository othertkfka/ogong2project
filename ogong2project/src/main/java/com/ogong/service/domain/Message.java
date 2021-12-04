package com.ogong.service.domain;

import java.util.Date;

import lombok.Data;

@Data
public class Message {

	private int messageNo;
	private String messageContents;
	private String sendDate;
	private User receiver;
	private User sender;
	private String messageCategory;
}
