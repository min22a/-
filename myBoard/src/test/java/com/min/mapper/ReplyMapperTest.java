package com.min.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.min.domain.ReplyVO;
import com.min.domain.Search;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Log4j2
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@RunWith(SpringJUnit4ClassRunner.class)
public class ReplyMapperTest {

	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
//	
//	@Test
//	public void inserttest() {
//		ReplyVO vo = new ReplyVO();
//		
//		vo.setNum(120L);
//		vo.setReply("댓글내용");
//		vo.setReplyer("user");
//		
//		mapper.insert(vo);
//		
//		
//	} //ok
	
//	@Test
//	public void updateTest() {
//		Long repnum = 1L;
//		ReplyVO	vo = mapper.read(repnum);
//		
//		vo.setReply("수정");
//		
//		 mapper.update(vo);
//		 
//		log.info(mapper.read(repnum));
//	} read update oK
	
//	@Test
//	public void deletTest() {
//		mapper.delete(1L);
//	} ok
	
	@Test
	public void getlistTest() {
		
		mapper.read(1L);
	}
	
}
