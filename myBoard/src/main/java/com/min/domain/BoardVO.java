package com.min.domain;

import java.util.Date;
import java.util.List;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;

import lombok.Data;

@Data
public class BoardVO {

	private Long num;
	
	@NotEmpty
	private String title;
	
	private String content;
	
	@NotEmpty
	private String user;
	
	private Date regdate;
	
	private Date updatedate;
	
	private Long  viewcnt;
	
	private int replycnt;
	
	private List<AttachVO> attachList;
}
