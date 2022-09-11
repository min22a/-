package com.min.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.min.domain.BoardVO;
import com.min.domain.Search;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Log4j2
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@RunWith(SpringJUnit4ClassRunner.class)
public class BoardMapperTest {

	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
//	@Test
//	public void insertTest() {
//		BoardVO vo  = new BoardVO();
//		vo.setContent("테스트내용");
//		vo.setTitle("테스트제목");
//		vo.setUser("usertest");
//		
//		mapper.insert(vo);
//		
//		List<BoardVO> list = mapper.getlist();
//		
//		list.forEach( a-> log.info(a));
//	} ok
	
//	@Test
//	public void updateTest() {
//		BoardVO vo = new BoardVO();
//		
//		vo.setNum(5L);
//		vo.setTitle("수정제목");
//		vo.setContent("내용수정");
//		
//		mapper.update(vo);
//		
//		List<BoardVO> list = mapper.getlist();
//		
//		list.forEach( a-> log.info(a));
//	} test ok
	
//	@Test
//	public void deleteTest() {
//		
//		mapper.delete(3L);
//		
//		List<BoardVO> list = mapper.getlist();
//		
//		list.forEach( a-> log.info(a));
//	} test ok
	
	@Test
	public void readTest() {
		BoardVO vo = new BoardVO();
		
		vo =	mapper.read(5L);
	
		
		log.info("vo:"+vo);
	} //ok
	
//	@Test
//	public void viewcnttest() {
//		BoardVO vo = new BoardVO();
//		
//		mapper.viewCount(13L);
//		
//		vo = mapper.read(13L);
//		
//		log.info(vo);
//	} ok
	
//	@Test
//	public void testselet() {
//		Search vo = new Search();
//		vo.setPageNum(3);
//		vo.setAmount(10);
//		
//		List<BoardVO> list = mapper.getlist(vo);
//		
//		list.forEach(a-> log.info(a));
//	}
}
