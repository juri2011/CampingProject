package com.campingga.service;

import java.util.List;

import com.campingga.domain.AttachImageVO;

public interface AttachService {
    /* 이미지 데이터 반환 */
    public List<AttachImageVO> getAttachList(int item_no);
}
