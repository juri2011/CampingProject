package com.campingga.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.campingga.domain.MemberVO;
import com.campingga.domain.PagingVO;
import com.campingga.mapper.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberMapper memberMapper;


	@Override
	public void memberJoin(MemberVO member) throws Exception {

		memberMapper.memberJoin(member);

	}

	@Override
	public int idCheck(String mem_id) {

		return memberMapper.idCheck(mem_id);
	}

	@Override
	public MemberVO memberLogin(MemberVO member) throws Exception {

		return memberMapper.memberLogin(member);
	}

	@Override
	public int countMember() {
		return memberMapper.countMember();
	}

	@Override
	public List<MemberVO> selectMember(PagingVO vo) {
		return memberMapper.selectMember(vo);
	}
	
	
	@Override
    public boolean checkPassword(String mem_id, String oldPassword) {
        int count = memberMapper.checkPassword(mem_id, oldPassword);
        return count == 1;
    }

    @Override
    public void updatePassword(String mem_id, String newPassword) {
        memberMapper.updatePassword(mem_id, newPassword);
    }


	@Override
	public void updateMemberInfo(MemberVO memberVO) {
		memberMapper.updateMemberInfo(memberVO);
	}

	

}
