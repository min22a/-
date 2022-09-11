package com.min.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.min.domain.BoardVO;
import com.min.domain.Search;

public interface BoardMapper {
	
	public void insert(BoardVO vo);
	
	public int update(BoardVO vo);
	
	public int delete(Long num);
	
	public List<BoardVO> getlist(Search search); 
	
	public int getCount(Search search);
	
	public BoardVO read(Long num);
	
	public int viewCount(Long num);
	
	public List<BoardVO> searchList(Search search);
	
	public int gettotalCountSearch(Search search);
	
	public void updateReplyCnt(@Param("num") Long num, @Param("amount") int amount);
}
