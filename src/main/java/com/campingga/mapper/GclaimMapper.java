package com.campingga.mapper;

import java.util.List;

import com.campingga.domain.Adminclaim;
import com.campingga.domain.AnswerClaim;
import com.campingga.domain.Common;
import com.campingga.domain.Gclaim;

public interface GclaimMapper {

	/* gclaim n answer_gclaim */
	public List<Adminclaim> selectClaims(Common common);
	
	/* gclaim table */
	public List<Gclaim> selectGclaims();
	
	public Gclaim selectOneGclaim(int glno);
	
	public void insertGclaim(Gclaim claim);
	
	public void updateGclaim(Gclaim claim);
	
	public void deleteGclaim(int glno);
	
	
	/* answer_gclaim table */
	public List<AnswerClaim> selectClaimAnswers();
	
	public AnswerClaim selectOneClaimAnswer(int anscno);
	
	public void insertClaimAnswer(AnswerClaim AClaim);
	
	public void updateClaimStatus(AnswerClaim AClaim);
	
	public void deleteClaimAnswer(int anscno);
}
