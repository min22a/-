package com.min.service;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.min.domain.MemberVO;
import com.min.mapper.MemberMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;
@Service
@Log4j2
public class MemberServiceImpl implements MemberService{
	
	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;
	
	BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
	
	@Override
	public MemberVO get(String ID) {
		
		return mapper.read(ID);
	}

	@Override
	@Transactional
	public void register(MemberVO vo) {
	
		String a = encoder.encode(vo.getPW());
		
		vo.setPW(a);
		
		mapper.authinsert(vo);
		
		mapper.insert(vo);
	
	}

	@Override
	public boolean modify(MemberVO vo) {
		
		String a = encoder.encode(vo.getPW());
		
		vo.setPW(a);
		log.info("VO:"+ vo);
		mapper.update(vo);
		
		return true;
	}

	@Override
	@Transactional
	public boolean remove(String id) {
		
		mapper.delinsert(id);
		
		mapper.delete(id);
		
		return true;
	}
	
	@Override
	public int check(MemberVO vo) {
		
		return mapper.IDcheck(vo);
	}
	


}
