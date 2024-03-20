package com.campingga.mapper;
/*package org.zerock.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.AnswerQnA;
import org.zerock.domain.QnA_Q;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class QnAMapperTests {
	
	@Autowired
	private QnAMapper mapper;
	
	@Test
	public void testSelectAllListByQnA_a() {
		List<AnswerQnA> qnA = mapper.selectAllListByQnA_a(1);
		log.info(qnA);
	}

	@Test
	public void testSelectOneQna_q() {
		QnA_Q Qna = mapper.selectOneQna_q(1);
		log.info(Qna);
	}

	@Test
	public void testSelectQna_q() {
		QnA_Q Qna = mapper.selectQna_q(1);
		log.info(Qna);
	}

	@Test
	public void testInsertQna_q() {
		QnA_Q Qna = new QnA_Q();
		Qna.setId("a");
		Qna.setTitle("a");
		Qna.setContent("1");
		mapper.insertQna_q(Qna);
		log.info("inserting");
	}

	@Test
	public void testUpdateQna_q() {
		QnA_Q Qna = new QnA_Q();
		Qna.setTitle("b");
		Qna.setContent("b");
		Qna.setStatus("2");
		mapper.updateQna_q(Qna);
		log.info("updating");
	}

	@Test
	public void testDeleteQna_q() {
		mapper.deleteQna_q(1);
		log.info("deleting");
	}
	
	@Test
	public void testSelectOneQna_a() {
		AnswerQnA qnA = mapper.selectOneQna_a(1);
		log.info(qnA);
	}
	
	@Test
	public void testInsertQna_a() {
		AnswerQnA qnA = new AnswerQnA();
		qnA.setQna_questno(1);
		qnA.setTitle("c");
		qnA.setContent("c");
		qnA.setStatus("1");
		mapper.insertQna_a(qnA);
		log.info("inserting Answer");
	}

	@Test
	public void testUpdateQna_a() {
		AnswerQnA qnA = new AnswerQnA();
		qnA.setTitle("d");
		qnA.setContent("d");
		qnA.setStatus("2");
		mapper.updateQna_a(qnA);
		log.info("updating Answer");
	}

	@Test
	public void testDeleteQna_a() {
		mapper.deleteQna_a(1);
		log.info("deleting Answer");
	}
	
}
*/