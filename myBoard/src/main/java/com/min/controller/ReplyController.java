package com.min.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.min.domain.ReplyPageVO;
import com.min.domain.ReplyVO;
import com.min.domain.Search;
import com.min.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;

@RestController
@Log4j2
@AllArgsConstructor
@RequestMapping("/replies/")
public class ReplyController {

	private ReplyService service;
	
	@PostMapping(value = "/new", consumes = "application/json", 
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> newcontroller(@RequestBody ReplyVO vo){
		log.info(vo);
		
		int count = service.register(vo);
		
		log.info("Reply insert count:" + count);
		
		return count == 1 ? new ResponseEntity<>("success", HttpStatus.OK) :
			new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value = "/pages/{num}/{page}", produces = {
			MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReplyPageVO> getListController(@PathVariable("page") int page,
			@PathVariable("num") Long num) {
		log.info("===========reply list page==========");
		
		Search search = new Search(page,10);
		
		log.info("search:"+search);

		return new ResponseEntity<>(service.getListPage(search, num), HttpStatus.OK);
	}
	
	@RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH},
			value = "/{repnum}", consumes = "application/json", 
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modifyController(@RequestBody ReplyVO vo,
			@PathVariable("repnum") Long repnum){
			
			log.info("repnum:" +repnum);
			vo.setRepnum(repnum);
			
			return service.modify(vo) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
					: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value = "/{repnum}", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE, 
			MediaType.APPLICATION_XML_VALUE}) 
	public ResponseEntity<ReplyVO> getcontroller(@PathVariable("repnum") Long repnum){
			
		log.info("repnum:" +repnum);
		
		return new ResponseEntity<> (service.read(repnum), HttpStatus.OK);
	}
	
	@DeleteMapping(value = "/{repnum}", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> removeController(@PathVariable("repnum") Long repnum){
		log.info("repnum:" +repnum);
		
		return service.remove(repnum) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<> (HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
