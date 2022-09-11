package com.min.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.min.domain.ReplyVO;
import com.min.domain.Search;

public interface ReplyMapper {

	public ReplyVO read(Long repnum);
	
	public int update(ReplyVO vo);
	
	public int insert(ReplyVO vo);
	
	public int delete(Long repnum);
	
	public List<ReplyVO> getList(@Param("search") Search search,
			@Param("num") Long num);
	
	public int getreplyCount(Long num);
}
