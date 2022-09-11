package com.min.mapper;

import java.util.List;

import com.min.domain.AttachVO;

public interface BoardAttachMapper {

	public void insert(AttachVO vo);
	
	public void delete(String uuid);
	
	public List<AttachVO> getattachlist(Long num);
	
	public void deleteAll(Long num);
}
