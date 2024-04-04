package com.campingga.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.campingga.domain.Criteria;
import com.campingga.domain.ReviewPageDTO;
import com.campingga.domain.ReviewVO;
import com.campingga.service.ReviewService;

import lombok.extern.log4j.Log4j;

@RestController
@Log4j
@RequestMapping("/review")
public class ReviewController {
	
	@Autowired
	private ReviewService reviewService;
	
	@GetMapping("/reviewList/{item_no}/{page}")
	public ResponseEntity<ReviewPageDTO> getReviewListWithPaging(
			@PathVariable("item_no") int item_no,
			@PathVariable("page") int page){
		log.info("getList with paging");
		Criteria cri = new Criteria(page,5); //한 페이지에 5개씩 출력
		return new ResponseEntity<>(reviewService.getReviewListWithPaging(cri, item_no),
									HttpStatus.OK);
	}
	
  //리뷰 읽기
    @GetMapping("/{rev_no}")
    public ResponseEntity<ReviewVO> get(@PathVariable("rev_no") int rev_no){
      log.info("get: " + rev_no);
      
      return new ResponseEntity<>(reviewService.get(rev_no),HttpStatus.OK);
    }
	
	//리뷰 등록하기
		@PostMapping("/write")
		public ResponseEntity<String> create(@RequestBody ReviewVO vo){
			
			log.info("ReviewVO: "+vo);
			int insertCount = reviewService.register(vo);
			
			log.info("Review INSERT COUNT : "+insertCount);
			
			return insertCount == 1
					? new ResponseEntity<>("success", HttpStatus.OK)
					: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
			//삼항연산자
		}
		
		@DeleteMapping("/{rev_no}")
	  public ResponseEntity<String> remove(@PathVariable("rev_no") int rev_no){
	    log.info("remove: " + rev_no);
	    
	    return reviewService.remove(rev_no)==1
	        ? new ResponseEntity<>("success", HttpStatus.OK)
	        : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	  }
}
