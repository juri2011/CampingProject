package com.campingga.mapper;

import java.util.Date;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.campingga.domain.AttachImageVO;
import com.campingga.domain.ItemVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class AdminMapperTests {

	@Autowired
	private AdminMapper mapper;

	// 상품 등록 테스트
	@Test
	public void itemEnrollTest() throws Exception {
		// 테스트할 ItemVO 객체 생성 및 설정
		ItemVO item = new ItemVO();
		item.setItem_no(777);
		item.setItem_name("Test Item");
		item.setAmount(9);
		item.setContent("Test content");
		item.setPrice(10000);
		item.setRegdate(new Date());
		item.setCategory("Test category");
		item.setStatus("1"); // 상태를 판매중으로 설정

		mapper.itemEnroll(item);
	}

	/* 이미지 등록 */
	@Test
	public void imageEnrollTest() {

		AttachImageVO vo = new AttachImageVO();
		ItemVO item = new ItemVO();
		vo.setItem_no(3);
		vo.setFileName("test.jpg"); // 예시 파일 이름
		vo.setUploadPath("test"); // 예시 업로드 경로
		vo.setUuid("test2"); // 예시 UUID

		try {
	        // 이미지 등록 메서드 호출
	        mapper.imageEnroll(vo);
	        System.out.println("이미지 등록 성공!");
	    } catch (Exception e) {
	        // 데이터베이스 제약 조건 위반 시 발생하는 예외 처리
	        System.err.println("이미지 등록 실패: " + e.getMessage());
	    }

	}

}
