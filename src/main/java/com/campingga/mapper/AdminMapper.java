package com.campingga.mapper;

import com.campingga.domain.AttachImageVO;
import com.campingga.domain.ItemVO;

public interface AdminMapper {
	
	/* 상품 등록 */
	public void itemEnroll(ItemVO item);
	
	/* 이미지 등록 */
	public void imageEnroll(AttachImageVO vo);

}
