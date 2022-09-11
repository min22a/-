package com.min.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.min.domain.BoardVO;
import com.min.domain.ReplyPageVO;
import com.min.domain.ReplyVO;
import com.min.domain.Search;
import com.min.mapper.BoardMapper;
import com.min.mapper.ReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class ReplyServiceImpl implements ReplyService{
	
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapperboard;
	
	@Transactional
	@Override
	public int register(ReplyVO vo) {
		
		mapperboard.updateReplyCnt(vo.getNum(), 1);
		
		return mapper.insert(vo);
	}

	@Override
	public ReplyVO read(Long repnum) {
	
		return mapper.read(repnum);
	}

	@Override
	public int modify(ReplyVO vo) {
	
		return mapper.update(vo);
	}
	
	@Transactional
	@Override
	public int remove(Long repnum) {
		ReplyVO vo = mapper.read(repnum);
		
		mapperboard.updateReplyCnt(vo.getNum(), -1);
		
		return mapper.delete(repnum);
	}

	@Override
	public List<ReplyVO> getList(Search search, Long num) {
		
		return mapper.getList(search, num);
	}

	@Override
	public ReplyPageVO getListPage(Search search, Long num) {
	
	int total =	mapper.getreplyCount(num);

	List<ReplyVO> replylist	= mapper.getList(search, num);
	
	ReplyPageVO vo = new ReplyPageVO(replylist, total);
	
	return vo;
	
	}

	
	}
