package com.min.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyVO {

	private Long repnum;
	
	private Long num;
	
	private String reply;
	
	private String replyer;
	
	private Date replydate;
	
	private Date updatedate;
}
