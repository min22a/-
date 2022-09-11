package com.min.domain;

import lombok.Data;

@Data
public class AttachVO {

	private String fileName;
	private String uploadPath;
	private String uuid;
	private boolean filetype;
	private Long num;
}
