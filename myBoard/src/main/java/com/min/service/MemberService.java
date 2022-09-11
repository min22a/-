package com.min.service;

import org.springframework.security.core.userdetails.UserDetailsService;
import com.min.domain.MemberVO;

public interface MemberService{
	
	public MemberVO get(String ID);
	
	public void register(MemberVO vo);
	
	public boolean modify(MemberVO vo);
	
	public boolean remove(String id);
	
	public int check(MemberVO vo);
}
