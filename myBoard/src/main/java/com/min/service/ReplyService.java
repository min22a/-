package com.min.service;

import java.util.List;

import com.min.domain.BoardVO;
import com.min.domain.ReplyPageVO;
import com.min.domain.ReplyVO;
import com.min.domain.Search;

public interface ReplyService {

	public int register(ReplyVO vo);
	
	public ReplyVO read(Long repnum);
	
	public int modify(ReplyVO vo);
	
	public int remove(Long repnum);
	
	public List<ReplyVO> getList(Search search, Long num);
	
	public ReplyPageVO getListPage(Search search, Long num);
}
