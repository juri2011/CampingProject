package com.campingga.service;

import java.util.List;

import com.campingga.domain.PagingVO;
import com.campingga.domain.MemberVO;

public interface MemberService {

	//회원가입
	public void memberJoin(MemberVO member) throws Exception;
	
	//아이디 중복 검사
	public int idCheck(String mem_id);
	
	//로그인 
    public MemberVO memberLogin(MemberVO member) throws Exception;

    // 회원 총 
    public int countMember();

    // 페이징 처리 게시글 조회
    public List<MemberVO> selectMember(PagingVO vo);
    
    // 비밀번호 갱신
    boolean checkPassword(String mem_id, String oldPassword);
    
    void updatePassword(String mem_id, String newPassword);
    
    // 회원 상세정보 보기/수정
    public void updateMemberInfo(MemberVO memberVO);
    
    //회원 정보 불러오기(배송용)
    public MemberVO getShippingInfo(String mem_id);
	
}
