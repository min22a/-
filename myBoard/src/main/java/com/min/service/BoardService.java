package com.min.service;

import java.util.List;

import com.min.domain.AttachVO;
import com.min.domain.BoardVO;
import com.min.domain.Search;

public interface BoardService {

	public List<BoardVO> getlist(Search search);
	
	public int getTotal(Search search);
	
	public BoardVO get(Long num);
	
	public void register(BoardVO vo);
	
	public boolean modify(BoardVO vo);
	
	public boolean remove(Long num);
	
	public List<BoardVO> getsearchlist(Search search);
	
	public int getSearchTotal(Search search);
	
	public List<AttachVO> getAttachList(Long num);
	
	public void allremove(List<String> boardIdxArray);  // 관리자 게시글 전체삭제 
}
