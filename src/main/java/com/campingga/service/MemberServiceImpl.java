package com.campingga.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.campingga.domain.PagingVO;
import com.campingga.domain.Authority;
import com.campingga.domain.MemberVO;
import com.campingga.mapper.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService{

	@Autowired
	MemberMapper membermapper;

	@Autowired
	private PasswordEncoder pwencoder;
	
	@Override
	public void memberJoin(MemberVO member) throws Exception {
		
		
		
		//사용자 권한
		Authority auth = new Authority();
		auth.setAuth("ROLE_MEMBER");
		auth.setMem_id(member.getMem_id());
		String pwd = member.getPwd();
		member.setPwd(pwencoder.encode(pwd));
		
		membermapper.memberJoin(member);
		membermapper.insertAuth(auth); //사용자 권한 추가
		
	}

	@Override
	public int idCheck(String mem_id) {
		
		return membermapper.idCheck(mem_id);
	}
	
    
    @Override
    public MemberVO memberLogin(MemberVO member) throws Exception {
        
        return membermapper.memberLogin(member);
    }

    @Override
    public int countMember() {
    	return membermapper.countMember();
    }

    @Override
    public List<MemberVO> selectMember(PagingVO vo) {
    	return membermapper.selectMember(vo);
    }
	
	
	
	
	
}
