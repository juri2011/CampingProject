package com.campingga.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
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
import com.campingga.domain.OrderListVO;
import com.campingga.domain.PagingVO;
import com.campingga.service.AdminService;
import com.campingga.service.ItemService;
import com.campingga.service.MemberService;
import com.campingga.service.OrderService;

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

	@Autowired
	private ItemService itemService;
	
	@Autowired
	public OrderService orderService;
	


	/* 관리자 메인 페이지 이동 */
	@GetMapping("/adminPage")
	public void adminMainGET() throws Exception {

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
	public String itemList(PagingVO vo, Model model, @RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "cntPerPage", required = false) String cntPerPage) {

		int total = itemService.countItem();
		if (nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "5";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (cntPerPage == null) {
			cntPerPage = "5";
		}
		vo = new PagingVO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
		model.addAttribute("paging", vo);
		model.addAttribute("viewAll", itemService.selectItem(vo));
		return "admin/itemManager";
	}

	// 상품수정
	@GetMapping("/itemEdit")
	public String itemEdit(@RequestParam("item_no") int item_no, Model model) {
		// 해당 상품번호에 해당하는 상품 정보를 가져와서 모델에 추가
		ItemVO item = itemService.get(item_no);

		model.addAttribute("item", item);

		// 상품의 카테고리 정보도 가져와서 모델에 추가
		List<String> categories = Arrays.asList("캠핑가구", "조리도구", "랜턴", "전자제품", "텐트", "침낭", "매트", "난로");
		model.addAttribute("categories", categories);

		// 상품의 판매 상태 정보도 가져와서 모델에 추가
		List<String> statuses = Arrays.asList("판매중", "판매중단(품절)");
		model.addAttribute("statuses", statuses);

		// 상품의 수정 시간을 가져와서 모델에 추가
		Date modDate = new Date(); // 현재 시간을 가져오거나, 데이터베이스에서 가져와서 사용할 수 있습니다.
		model.addAttribute("modDate", modDate);

		return "admin/itemEdit"; // 상품 수정 페이지로 이동
	}

	@PostMapping("/itemEdit")
	public String updateItem(@RequestParam("item_no") int item_no, ItemVO item, RedirectAttributes rttr) {
		log.info("updateItem POST..." + item);
		// 상품 번호와 상품 정보를 이용하여 상품 업데이트 서비스 메소드 호출
		item.setItem_no(item_no); // 상품 번호 설정
		int result = itemService.itemUpdate(item);
		if (result == 1) {
			rttr.addFlashAttribute("update_result", "success");
		} else {
			rttr.addFlashAttribute("update_result", "fail");
		}
		return "redirect:/admin/itemManager";
	}

	// 상품삭제
	@PostMapping("/deleteItem")
	public String deleteItem(@RequestParam("item_no") int item_no, RedirectAttributes rttr) {
		log.info("deleteItem POST... item_no: " + item_no);

		// 아이템 서비스를 사용하여 해당 상품을 삭제합니다.
		int result = itemService.deleteItem(item_no);

		if (result == 1) {
			rttr.addFlashAttribute("delete_result", "success");
		} else {
			rttr.addFlashAttribute("delete_result", "fail");
		}

		return "redirect:/admin/itemManager";
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
				double ratio = 1;
				// 넓이 높이
				int width = (int) (bo_image.getWidth() / ratio);
				int height = (int) (bo_image.getHeight() / ratio);

				Thumbnails.of(saveFile).size(width, height).toFile(thumbnailFile);

			} catch (Exception e) {
				e.printStackTrace();
			}
			list.add(vo);
		} // for

		ResponseEntity<List<AttachImageVO>> result = new ResponseEntity<List<AttachImageVO>>(list, HttpStatus.OK);
		return result;
	}

	/* 이미지 파일 삭제 */
	@PostMapping("/deleteFile")
	public ResponseEntity<String> deleteFile(String fileName) {

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

		} catch (Exception e) {

			e.printStackTrace();

			return new ResponseEntity<String>("fail", HttpStatus.NOT_IMPLEMENTED);

		} // catch

		return new ResponseEntity<String>("success", HttpStatus.OK);
	}

	@GetMapping("/memberManager")
	public String memberList(PagingVO vo, Model model,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "cntPerPage", required = false) String cntPerPage) {

		int total = memberService.countMember();
		if (nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "5";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (cntPerPage == null) {
			cntPerPage = "5";
		}
		vo = new PagingVO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
		model.addAttribute("paging", vo);
		model.addAttribute("viewAll", memberService.selectMember(vo));
		return "admin/memberManager";
	}
	
	
	@GetMapping("/orderManager")
    public String getAllOrders(Model model) {
        List<OrderListVO> orders = orderService.getAllOrders();
        model.addAttribute("orders", orders);
        
        //TreeMap은 기본적으로 오름차순이기 때문에 내림차순으로 정렬하도록 지정
  		Map<String, List<OrderListVO>> orderMap = new TreeMap<>(Collections.reverseOrder());
  		Map<String, Integer> totalPriceMap = new HashMap<>(); 
  		
  		//주문번호별로 그룹화
  			for(OrderListVO order : orders) {
  				
  				//order의 item_no를 이용해서 아이템정보(이름, 가격)등을 받아온다.
  				ItemVO item = itemService.get(order.getItem_no());
  				order.setItem_name(item.getItem_name());
  				order.setPrice(item.getPrice());
  				
  				//주문번호로 key 생성
  				String orderKey = order.getOrd_no();
  				
  				//아직 주문번호로 key값이 만들어지지 않았으면 생성 (초기화)
  				if (!orderMap.containsKey(orderKey)) {
  	                orderMap.put(orderKey, new ArrayList<>());
  	                totalPriceMap.put(orderKey, 0);
  	            }
  				log.info("================================"+order.getAmount());
  				//주문번호 key로 ArrayList value에 현재 order를 추가
  				orderMap.get(orderKey).add(order);
  				
  				int totalPrice = totalPriceMap.get(orderKey) + (order.getPrice() * order.getAmount());
  				totalPriceMap.put(orderKey, totalPrice);
  				
  			}
  			
  			
  			//orderList.forEach(order -> log.info(order));
  			model.addAttribute("orderMap",orderMap);
  			model.addAttribute("totalPriceMap", totalPriceMap);
  			//model.addAttribute("orderList",orderList);
  			return "admin/orderManager";
        
    }
	
	
	 @PostMapping("/updateOrderStatus")
	    public String updateOrderStatus(@RequestParam("ord_no") String ord_no,
	    								@RequestParam("cart_no") String cart_no,
	                                    @RequestParam("status") String status) {
	        // 주문 상태 업데이트 로직 수행
	        orderService.updateOrderStatus(ord_no, cart_no, status);
	        
	        // 업데이트 후에는 주문 관리 페이지로 리다이렉트
	        return "redirect:/admin/orderManager";
	    }
	

}
