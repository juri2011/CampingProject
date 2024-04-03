package com.campingga.mapper;

import java.util.List;

import com.campingga.domain.AttachImageVO;

public interface AttachMapper {
	/* 이미지 데이터 반환 */
	public List<AttachImageVO> getAttachList(int item_no);
}
