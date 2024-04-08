package com.campingga.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.campingga.domain.PagingVO;
import com.campingga.domain.MemberVO;
import com.campingga.mapper.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService{

	@Autowired
	MemberMapper membermapper;

	@Override
	public void memberJoin(MemberVO member) throws Exception {
		
		membermapper.memberJoin(member);
		
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
