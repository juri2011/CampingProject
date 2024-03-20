package com.campingga.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.campingga.domain.Adminclaim;
import com.campingga.domain.AnswerClaim;
import com.campingga.domain.Common;
import com.campingga.domain.Gclaim;
import com.campingga.mapper.GclaimMapper;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ClaimService {

	@Autowired
	private GclaimMapper mapper;
	
	/* 클레임과 답변 */
	public List<Adminclaim> showlistAll(Common common){
		return mapper.selectClaims(common);
	}
	
	
	/* 클레임 */
	public List<Gclaim> showClaimslist(){
		return mapper.selectGclaims();
	};
	
	public Gclaim showOneClaim(int glno) {
		return mapper.selectOneGclaim(glno);
	};
	
	public void sendClaim(Gclaim claim) {
		mapper.insertGclaim(claim);
	};
	
	public void editClaim(Gclaim claim) {
		mapper.updateGclaim(claim);
	};
	
	public void clearClaim(int glno) {
		mapper.deleteGclaim(glno);
	};
	
	
	/* answer_gclaim table */
	public List<AnswerClaim> showAnswerslist(){
		return mapper.selectClaimAnswers();
	};
	
	public AnswerClaim showOneAnswer(int anscno) {
		return mapper.selectOneClaimAnswer(anscno);
	};
	
	public void answerToClaim(AnswerClaim AClaim) {
		
		log.info("reg answer.......");
		
		mapper.insertClaimAnswer(AClaim);
	};
	
	public void updateprocess(AnswerClaim AClaim) {	//주로 답변 status 업데이트용이나 기능적으로 답변글 제목 및 내용 수정 가능
		mapper.updateClaimStatus(AClaim);
	};	
	
	public void deleteClaimAnswer(int anscno) {
		mapper.deleteClaimAnswer(anscno);
	};
}
