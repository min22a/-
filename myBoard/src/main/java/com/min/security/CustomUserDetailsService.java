package com.min.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.min.domain.CustomUser;
import com.min.domain.MemberVO;
import com.min.mapper.MemberMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Log4j2
public class CustomUserDetailsService implements UserDetailsService{
	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
		log.info("User:"+username);
		
		MemberVO vo = mapper.read(username);
		
		log.info("v0" + vo);
		return vo == null ? null : new CustomUser(vo);
	}

	
}
