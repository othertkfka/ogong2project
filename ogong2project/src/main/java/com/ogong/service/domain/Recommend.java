package com.ogong.service.domain;

import lombok.Data;

@Data
public class Recommend {

	private int recommendNo;
	private Board recommendBoard;
	private User recommender;

}
