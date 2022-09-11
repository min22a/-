package com.min.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.min.domain.BoardVO;
import com.min.domain.PageVO;
import com.min.domain.Search;
import com.min.service.BoardService;
import com.min.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Log4j2
@Controller
@AllArgsConstructor
public class AdminController {

	private BoardService service;
	private ReplyService repservice;
	
	@GetMapping("/admin")
	public void listController(Model model, Search search) {
		
		log.info("===========admin page==========");
		
		List<BoardVO> list = service.getlist(search);
		
		int total = service.getTotal(search);
		
		model.addAttribute("list", list);
		model.addAttribute("pager", new PageVO(search, total));
		
	}
	
	@PostMapping(value = "/admindel")
	@ResponseBody
	public List<String> deleteSubmit(@RequestBody List<String> boardIdxArray) {
		
		log.info("boardIdxArray={}", boardIdxArray);
		
		 service.allremove(boardIdxArray);
		
		return boardIdxArray;
	}
}
