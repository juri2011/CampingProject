package com.campingga.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.campingga.domain.AttachImageVO;
import com.campingga.domain.ItemVO;
import com.campingga.domain.MemberPagingVO;
import com.campingga.service.AdminService;
import com.campingga.service.MemberService;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnails;

@Controller
@Log4j
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private MemberService memberService;
	
	 /* 관리자 메인 페이지 이동 */
    @GetMapping("/adminPage")
    public void adminMainGET() throws Exception{
        
        log.info("관리자 페이지 이동");
        
    }

	// 상품등록 페이지 이동
	@GetMapping("/itemEnroll")
	public void EnrollGET() {

		log.info("상품등록 페이지 진입");

	}
	

	// 상품등록
	@PostMapping("/itemEnroll")
		public String itemsEnrollPOST(ItemVO item, RedirectAttributes rttr) {
			
			log.info("itemsEnrollPOST..." + item);
			
			adminService.itemEnroll(item);
			
			rttr.addFlashAttribute("enroll_result", item.getItem_name());
			
			return "redirect:/admin/itemManager";
		}
	
	// 상품관리 페이지 이동
		@GetMapping("/itemManager")
		public void itemManagerGET() {

			log.info("상품관리 페이지 진입");

		}

	/* 첨부 파일 업로드 */
	// 이미지 파일 이름이 한글인 경우, 한글깨짐 방지위한 속성값을 부여(JSON데이터가 UTF8인코딩이 된 채로 전송)
	@PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<AttachImageVO>> uploadAjaxActionPOST(MultipartFile[] uploadFile) {

		log.info("uploadAjaxActionPOST..........");

		/* 이미지 파일 체크 */
		// 전달 받은 파일이 이미지 인지 아닌지 체크를 하기 위해서 파일의 MIME TYPE 속성을 활용
		// 뷰에서는 ajax의 error 속성을 추가하여 상태코드 400을 전달받았을 때
		// 실행이 되는 콜백 함수를 속성 값으로 부여하여 잘못된 형식의 파일이라는 경고 문구를 뜨도록 설계
		for (MultipartFile multipartFile : uploadFile) {

			File checkfile = new File(multipartFile.getOriginalFilename());
			String type = null;

			try {
				type = Files.probeContentType(checkfile.toPath());
				log.info("MIME TYPE : " + type);
			} catch (IOException e) {
				e.printStackTrace();
			}

			if (!type.startsWith("image")) {

				List<AttachImageVO> list = null;
				return new ResponseEntity<>(list, HttpStatus.BAD_REQUEST);
			}

		}

		String uploadFolder = "C:\\upload";

		/* 날짜 폴더 경로 */
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		Date date = new Date();

		String str = sdf.format(date);

		String datePath = str.replace("-", File.separator);

		/* 폴더 생성 */
		File uploadPath = new File(uploadFolder, datePath);

		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}

		/* 이미저 정보 담는 객체 */
		List<AttachImageVO> list = new ArrayList<AttachImageVO>();

		// for문
		for (MultipartFile multipartFile : uploadFile) {

			/* 이미지 정보 객체 */
			AttachImageVO vo = new AttachImageVO();

			/* 파일 이름 */
			String uploadFileName = multipartFile.getOriginalFilename();
			vo.setFileName(uploadFileName);
			vo.setUploadPath(datePath);

			/*
			 * uuid 적용 파일 이름, 각 파일이 저장될 때 고유한 이름을 가지도록 UUID 적용 UUID(범용 고유 식별자)는 쉽게 말해 국제기구에서
			 * 표준으로 정한 식별자(일련번호)
			 */
			String uuid = UUID.randomUUID().toString();
			vo.setUuid(uuid);

			uploadFileName = uuid + "_" + uploadFileName;

			/* 파일 위치, 파일 이름을 합친 File 객체 */
			File saveFile = new File(uploadPath, uploadFileName);

			/* 파일 저장 */
			try {
				multipartFile.transferTo(saveFile);
				// 썸네일 이미지 파일이름 형식 - "thumbs_" + uploadFileName(uuid + "_" + 파일명)
				File thumbnailFile = new File(uploadPath, "thumbs_" + uploadFileName);

				BufferedImage bo_image = ImageIO.read(saveFile);

				// 비율
				double ratio = 1.5;
				// 넓이 높이
				int width = (int) (bo_image.getWidth() / ratio);
				int height = (int) (bo_image.getHeight() / ratio);

				Thumbnails.of(saveFile).size(width, height).toFile(thumbnailFile);

			} catch (Exception e) {
				e.printStackTrace();
			}

			// 이미지 정보가 저장된 AttachImageVO객체를 List의 요소로 추가
			list.add(vo);
		} // for

		ResponseEntity<List<AttachImageVO>> result = new ResponseEntity<List<AttachImageVO>>(list, HttpStatus.OK);

		return result;
	}
	
	/* 이미지 파일 삭제 */
	@PostMapping("/deleteFile")
	public ResponseEntity<String> deleteFile(String fileName){
		
		log.info("deleteFile........" + fileName);
		
		File file = null;
		
		try {
			/* 썸네일 파일 삭제 */
			file = new File("c:\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));
			
			file.delete();
			
			/* 원본 파일 삭제 */
			String originFileName = file.getAbsolutePath().replace("s_", "");
			
			log.info("originFileName : " + originFileName);
			
			file = new File(originFileName);
			
			file.delete();
			
			
		} catch(Exception e) {
			
			e.printStackTrace();
			
			return new ResponseEntity<String>("fail", HttpStatus.NOT_IMPLEMENTED);
			
		}//catch
		
		return new ResponseEntity<String>("success", HttpStatus.OK);
	}
	
		
	@GetMapping("/memberManager")
	public String memberList(MemberPagingVO vo, Model model,
	        @RequestParam(value="nowPage", required=false) String nowPage,
	        @RequestParam(value="cntPerPage", required=false) String cntPerPage) {
	    
	    int total = memberService.countMember();
	    if (nowPage == null && cntPerPage == null) {
	        nowPage = "1";
	        cntPerPage = "5";
	    } else if (nowPage == null) {
	        nowPage = "1";
	    } else if (cntPerPage == null) { 
	        cntPerPage = "5";
	    }
	    vo = new MemberPagingVO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
	    model.addAttribute("paging", vo);
	    model.addAttribute("viewAll", memberService.selectMember(vo));
	    return "admin/memberManager";
	}
	

}
