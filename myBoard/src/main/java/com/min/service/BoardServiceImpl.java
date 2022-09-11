package com.min.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.min.domain.AttachVO;
import com.min.domain.BoardVO;
import com.min.domain.Search;
import com.min.mapper.BoardAttachMapper;
import com.min.mapper.BoardMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class BoardServiceImpl implements BoardService {
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private BoardAttachMapper attachmapper;
	
	@Override
	public List<BoardVO> getlist(Search search) {
		
		return mapper.getlist(search);
	}
	
	@Override
	public int getTotal(Search search) {
		return mapper.getCount(search);
	}

	@Override
	public BoardVO get(Long num) {
		mapper.viewCount(num);
		
		return mapper.read(num);
	}

	@Override
	@Transactional
	public void register(BoardVO vo) {
		mapper.insert(vo);
		
		if(vo.getAttachList() == null || vo.getAttachList().size() <= 0) {
			return;
		}
		
		vo.getAttachList().forEach(attach -> {
			attach.setNum(vo.getNum());
			
			attachmapper.insert(attach);
		});
	}
	
	@Transactional
	@Override
	public boolean modify(BoardVO vo) {
		
		attachmapper.deleteAll(vo.getNum());
		
		boolean modifyResult = mapper.update(vo) == 1;
		
		if(modifyResult && vo.getAttachList() !=null && vo.getAttachList().size()>0) {
			
			vo.getAttachList().forEach(attach -> {
				attach.setNum(vo.getNum());
				
				attachmapper.insert(attach);
			});
		}
		
		return modifyResult;
	}
	
	@Transactional
	@Override
	public boolean remove(Long num) {
		
		attachmapper.deleteAll(num);
		
		return mapper.delete(num) == 1;
	}
	
	@Override
	public List<BoardVO> getsearchlist(Search search){
		return mapper.searchList(search);
	}
	
	@Override
	public int getSearchTotal(Search search) {
		
		return mapper.gettotalCountSearch(search); 
	}

	@Override
	public List<AttachVO> getAttachList(Long num) {
		
		List<AttachVO> list = attachmapper.getattachlist(num);
		
		list.forEach(test -> log.info(test));
		
		return attachmapper.getattachlist(num);
	}

	@Override
	@Transactional
	public void allremove(List<String> boardIdxArray) {
		for(int i=0; i<boardIdxArray.size(); i++) {
			mapper.delete(Long.parseLong(boardIdxArray.get(i)));
		}
	}
	
}
