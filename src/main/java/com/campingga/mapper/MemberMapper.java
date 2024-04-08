package com.campingga.mapper;

import java.util.List;

import com.campingga.domain.PagingVO;
import com.campingga.domain.Authority;
import com.campingga.domain.MemberVO;

public interface MemberMapper {
	
	// 회원가입
	public void memberJoin(MemberVO member);

	// 아이디 중복 검사
	public int idCheck(String mem_id);
	 
    // 로그인
    public MemberVO memberLogin(MemberVO member);
    
    // 회원 목록
	public List<MemberVO> getList();
	
	// 게시물 총 갯수
	public int countMember();

	// 페이징 처리 게시글 조회
	public List<MemberVO> selectMember(PagingVO vo);
	
	//회원 정보 가져오기
	public MemberVO read(String member_id);
	
	//권한 설정
	public int insertAuth(Authority auth);
	
}
