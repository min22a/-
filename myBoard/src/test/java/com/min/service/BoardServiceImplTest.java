package com.min.service;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.min.domain.BoardVO;
import com.min.mapper.BoardMapperTest;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Log4j2
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@RunWith(SpringJUnit4ClassRunner.class)
public class BoardServiceImplTest {

	@Setter(onMethod_ = @Autowired)
	private BoardService service;
	
//	@Test
//	public void getListTest() {
//		List<BoardVO> list = service.getlist();
//		
//		list.forEach(a -> log.info(a));
//	} //ok
	
	@Test
	public void getTest() {
		BoardVO vo = new BoardVO();
		
		vo = service.get(5L);
		
		log.info("get :"+vo);
	} //ok
	
//	@Test
//	public void modifytest() {
//		BoardVO vo  = new BoardVO();
//		
//		vo.setNum(2L);
//		vo.setContent("수정한내용");
//		vo.setTitle("수정된 제목");
//		
//	boolean  a =	service.modify(vo);
//		
//		if(a) {
//			log.info("Test ok...........");
//		} else {
//			log.info("errorr ...........");
//		}
//	}  tes ok && db상 확인 ok
	
//	@Test
//	public void registerTest() {
//		BoardVO vo = new BoardVO();
//		vo.setTitle("새로운 제목3");
//		vo.setContent("새로운 내용3");
//		vo.setUser("유저3");
//		
//		service.register(vo);
//		
//		log.info(service.getlist());
//	} test ok
	
//	@Test
//	public void deleteTest() {
//		boolean a = service.remove(8L);
//		
//		if(a) {
//			log.info("Test ok...........");
//		} else {
//			log.info("errorr ...........");
//		}
//	} // test ok
	
//	@Test
//	public void viewcountTests() {
//		boolean a =	service.viewCount(12L);
//		
//		if(a) {
//			log.info("Test ok...........");
//		} else {
//			log.info("errorr ...........");
//		}
//	} // tests ok
}
