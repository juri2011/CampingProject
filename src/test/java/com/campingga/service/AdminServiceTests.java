package com.campingga.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.campingga.domain.ItemVO;
import com.campingga.domain.AttachImageVO;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class AdminServiceTests {
    
    @Autowired
    private AdminService service;
    
    /* 상품 등록 & 상품 이미지 등록 테스트 */
    @Test
    public void itemEnrollTests() {
        ItemVO item = new ItemVO();
        // 상품 정보
        item.setItem_name("service 테스트09999");
        item.setContent("콘텐츠");
        item.setPrice(20000);
        item.setRegdate(new Date()); // 현재 날짜 및 시간으로 설정
        item.setCategory("카테고리");
        item.setStatus("1");

        // 상품 이미지 정보
        List<AttachImageVO> imageList = new ArrayList<>();
        
        AttachImageVO image1 = new AttachImageVO();
        image1.setFileName("test Image 10");
        image1.setUploadPath("test image 10");
        image1.setUuid("test12093");
        
        AttachImageVO image2 = new AttachImageVO();
        image2.setFileName("test Image 11");
        image2.setUploadPath("test image 11");
        image2.setUuid("test33");
        
        imageList.add(image1);
        imageList.add(image2);
        
        // 상품 이미지 리스트를 상품에 설정
        item.setImageList(imageList);
        
        // 상품 등록 메서드 호출
        service.itemEnroll(item);
        
        System.out.println("등록된 VO : " + item);
    }
}
