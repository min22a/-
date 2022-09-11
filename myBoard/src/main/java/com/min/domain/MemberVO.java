package com.min.domain;

import java.util.Date;
import java.util.List;
import lombok.Data;

@Data
public class MemberVO{

	private String ID;
	
	private String PW;
	
	private String user;
	
	private boolean enabled;
	
	private Date regdate;
	
	private Date updatedate;
	
	private List<AuthVO> authlist;
	
	
}
