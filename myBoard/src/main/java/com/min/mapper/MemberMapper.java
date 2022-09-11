package com.min.mapper;

import com.min.domain.MemberVO;


public interface MemberMapper {

	public void insert(MemberVO vo);
	
	public void authinsert(MemberVO vo);
	
	public MemberVO read(String ID);
	
	public void delete(String ID);
	
	public void update(MemberVO vo);
	
	public void authupdate(String ID);
	
	public void delinsert(String ID);
	
	public int IDcheck(MemberVO vo);
	
//	public CustomUser logread(String ID);
}
