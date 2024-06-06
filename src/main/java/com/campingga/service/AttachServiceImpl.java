package com.campingga.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.campingga.domain.AttachImageVO;
import com.campingga.mapper.AttachMapper;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class AttachServiceImpl implements AttachService {

    @Autowired
    private AttachMapper attachMapper;

    @Override
    public List<AttachImageVO> getAttachList(int item_no) {
        log.info("getAttachList.........");

        return attachMapper.getAttachList(item_no);
    }
}
