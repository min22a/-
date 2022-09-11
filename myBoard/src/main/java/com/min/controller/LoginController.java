package com.min.controller;

import java.security.Principal;


import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.min.domain.MemberVO;
import com.min.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
@AllArgsConstructor
public class LoginController {
	
	
	private MemberService service;

	@GetMapping("/login/form")
	public void form(Model model,String logout, String error ) {
		log.info("===========login page==========");
		log.info("error:"+error);
		log.info("logout:"+logout);
		
		if (error !=null) {
			model.addAttribute("error" , "LOGIN ERROR CHECK ID");
		}
		
		if(logout != null) {
			model.addAttribute("logout" , "logout!!");
		}
	}

	
	@PostMapping("/login/regi")
	public String regi(MemberVO vo) {
		log.info("===========user register page==========");
		
		log.info("vo:"+vo);
		
		service.register(vo);
		
		return "redirect:/board/list";
	}
	
	@GetMapping("/login/regi")
	public void getregi(MemberVO vo) {
		log.info("===========user register page==========");
		
		
	}
	
	@GetMapping("/accessError")
	public void accessDenied(Authentication auth, Model model) {
		
		log.info("access denied:" + auth);
			
		model.addAttribute("msg","접근 거절");
		
	}
	
	@PostMapping("/Logout")
	public void logout() {
		
		log.info("log out");
	}
	
	@ResponseBody
	@RequestMapping(value = "/IDcheck", method = RequestMethod.POST)
	public int IDcheck(MemberVO vo) {
		
		int result = service.check(vo);
		
		return result;
	}
	
	@PreAuthorize("isAuthenticated() and (#user.name == principal.member.ID )")
	@GetMapping("/memberinfo")
	public String memberinfo(Principal principal) {
			
		return"/login/member";
	}
	
	@GetMapping("/membermodify")
	public String membermodify(Principal principal,Model model) {
		
		String ID = principal.getName();
		
		MemberVO vo =  service.get(ID);	
		
		model.addAttribute("ID", vo);
		
		
		log.info("ID"+vo);
		return"/login/membermodify";
	}
	
	@PostMapping("/membermodify")
	public String postmembermodify(MemberVO vo) {
			
		service.modify(vo);
		
	return "redirect:/board/list";
	}
	
	
	@PostMapping("/deleteid")
	public ResponseEntity<String> deleteid(String ID) {
		
		boolean check = service.remove(ID);
		
		if(check) {
			SecurityContextHolder.clearContext();
		}
		
		return check == true ? new ResponseEntity<>("success", HttpStatus.OK) :
			
						new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
