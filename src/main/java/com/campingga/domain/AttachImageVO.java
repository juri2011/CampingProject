package com.campingga.domain;

import lombok.Data;

@Data
public class AttachImageVO {
	
	/* 경로 */
	private String uploadPath;
	
	/* uuid */
	private String uuid;
	
	/* 파일 이름 */
	private String fileName;
	
	/* 상품 번호 */
	private int item_no;
}
