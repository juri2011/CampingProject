package com.campingga.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.campingga.domain.MemberVO;
import com.campingga.domain.PagingVO;

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

	// 비밀번호 갱신
	public int checkPassword(@Param("mem_id") String mem_id, @Param("oldPassword") String oldPassword);

	public void updatePassword(@Param("mem_id") String mem_id, @Param("newPassword") String newPassword);

	// 회원 상세정보 보기 / 수정
	public void updateMemberInfo(MemberVO member);

}
