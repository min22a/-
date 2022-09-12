package com.min.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import javax.validation.constraints.AssertTrue;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.min.domain.AttachVO;
import com.min.domain.BoardVO;
import com.min.domain.PageVO;
import com.min.domain.Search;
import com.min.service.BoardService;
import com.min.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/board")
@Log4j2
@AllArgsConstructor
public class BoardController {
	
	private BoardService service;
	private ReplyService repservice;
	
	
	// 파일삭제메서드 추가
	private void deleteFiles(List<AttachVO> attachList) {
		if(attachList == null || attachList.size() <= 0 ) {
			return;
		}
		log.info("=========첨부파일 삭제합니다");
		
		attachList.forEach(attach ->{
			try {
			Path file = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\"+
					attach.getUuid()+"_"+attach.getFileName());
			
			Files.delete(file);
			
			if(Files.probeContentType(file).startsWith("image")) {
				Path thumbNail = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\s_"+
					attach.getUuid()+"_"+attach.getFileName());
				Files.delete(thumbNail);
			}
				}catch (Exception e) {
					log.error("delete file error:"+e.getMessage());
				}
		});
	}
	
	@GetMapping("/list")
	public void listController(Model model, Search search, String sort) {
		
		log.info("===========list page==========");
		
		List<BoardVO> list = service.getlist(search);
		
		int total = service.getTotal(search);
		
		model.addAttribute("list", list);
		model.addAttribute("pager", new PageVO(search, total, sort));
		
	}
	
	@GetMapping("/read")
	public void readController(@RequestParam("num") Long num,
			Model model, @ModelAttribute("search")Search search, 
			@ModelAttribute("sort")String sort) {
		log.info("===========read page==========");
		
		BoardVO list = service.get(num);
		model.addAttribute("list", list);
	}
	
	@GetMapping("/modify")
	public void modiController(@RequestParam("num") Long num, BoardVO vo,
			Model model,@ModelAttribute("search")Search search,
			@ModelAttribute("sort")String sort) {
		log.info("===========modifyget page==========");
		
		BoardVO list = service.get(num);
		model.addAttribute("list", list);
		
		
		log.info(list);
	}
	@PostMapping("/modify")
	public String modifyController(BoardVO list, RedirectAttributes redi,Model model,
			@ModelAttribute("search")Search search) {
		log.info("===========modify page==========");
		
		
		log.info(list);
			
		
		if(service.modify(list)) {
			redi.addFlashAttribute("result","succes");
			log.info("test:"+list);
		}
		
		redi.addAttribute("pageNum",search.getPageNum());
		redi.addAttribute("amount",search.getAmount());
		
		log.info("a,b" +search.getPageNum()+search.getAmount());
		return "redirect:/board/list";
	}
	
	@GetMapping("/register")
	public void registercontroller() {
		log.info("===========register page==========");
	}
	
	@PostMapping("/register")
	public String registercon(BoardVO vo, RedirectAttributes redi) {
		log.info("===========register post page==========");
		
		if(vo.getAttachList() != null) {
			vo.getAttachList().forEach( at -> log.info(at));
		}
		service.register(vo);
		
		log.info(vo);
		
		return "redirect:/board/list";
	}
	
	@PostMapping("/remove")
	public String removeController(@RequestParam("num") Long num, Search search,
			RedirectAttributes redi) {
		log.info("===========remove page==========");
		
		log.info("num" + num);
		
		List<AttachVO> attachList = service.getAttachList(num);
		
		if(service.remove(num)) {
			
			deleteFiles(attachList);
			
			redi.addFlashAttribute("result","success");
		}
		
		return "redirect:/board/list";
	}
	
	@GetMapping("/search")
	public void searchController(Model model, Search search, String sort) {
		log.info("===========search page==========");
		
		List<BoardVO> list = service.getsearchlist(search);
		
		int total = service.getSearchTotal(search);
		
		model.addAttribute("list", list);
		model.addAttribute("pager", new PageVO(search, total, sort));
	}
	
	//첨부파일 들고오기
	@GetMapping(value = "/getAttachList", 
			produces =  MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachVO>> getAttachListcontroller(Long num){
		log.info("get attachList:"+num);
		
		return new ResponseEntity<>(service.getAttachList(num), HttpStatus.OK);
	}
	
}
