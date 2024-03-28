package com.campingga.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.campingga.domain.Adminclaim;
import com.campingga.domain.Common;
import com.campingga.domain.Goods;
import com.campingga.domain.GoodsImage;
import com.campingga.domain.Review;
import com.campingga.service.ClaimService;
import com.campingga.service.GoodsImageService;
import com.campingga.service.GoodsService;
import com.campingga.service.ReviewService;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;


@Controller
@Log4j 
public class GoodsController {
	
	@Autowired
	private GoodsService service;

	
	@Autowired
	private GoodsImageService imageservice;

	
	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private ClaimService claimService;

	@Value("${file.path}")
	private String filePath;

	
	//관리자용 상품 리스트(페이지네이션 없음)
	@GetMapping("/list")
	public String showItemList(Model model, Common common) {
		log.info("show Admin List start...");
		
		List<Goods> goodsList = service.goodsList(common);
		model.addAttribute("goodsList", goodsList);

		
		if(goodsList.size() > 0)
			model.addAttribute("tot", goodsList.get(0).getTotalCount());

		return "/goods/goodsAdminList";
		
	}
	
	//사용자용 상품 리스트 - home에 있던 그 녀석 : list.jsp로 이동
	@RequestMapping("/showlist")
	public String goodslist(Model model,Common common) {

		List<Goods> goodsList = service.goodsList(common);
		model.addAttribute("goodsList", goodsList);

		
		if(goodsList.size() > 0)
			model.addAttribute("tot", goodsList.get(0).getTotalCount());


		
		return "itemlist";
	}

	@GetMapping("/goods/search.do")
	public String searchList(Model model,Common common) {

		System.out.println(common);
		List<Goods> goodsList = service.getSearchGoodsList(common);
		model.addAttribute("goodsList", goodsList);

		return "searchlist";
	}
	
	@GetMapping("/showItem")
	public String showOneItem(Model model) {
		
		log.info("showOneItem start....");
		
		//Goods good = service.showOneItem(pno);
		
		//model.addAttribute("good", good);
		
		return "item";
	}	
	
	
	/*
	 * @GetMapping("/delete/${pno}") public String removeCart(@RequestParam("pno")
	 * int pno, Model model) {
	 * 
	 * 
	 * }
	 */
	/*@RequestParam("price") String price, @RequestParam("pname") String pname, @RequestParam("stock") int stock*/
//	@PostMapping(value = "/registerGoods", consumes = MediaType.APPLICATION_JSON_VALUE)	
	
//	public Goods registerGoods(@RequestParam("sellPrice") String  sellPrice,@RequestParam("originalPrice") String  originalPrice,@RequestParam("pname") String pname, @RequestParam("stock") String stock,
//			@RequestParam("skintype") String skintype, @RequestParam("category") String category, ) {
	@PostMapping("/registerGoods")
	public String registerGoods(Goods goods,@RequestParam("uploadFile") MultipartFile[] uploadFile,@RequestParam("uploadSubFile") MultipartFile[] uploadFilesub) {
		log.info("registerGoods");
		
		log.info(goods); 		
	
		goods.setStatus("1");
		
//		List<Goods> list = new ArrayList<>();

		service.registerItem(goods); 
		

		fileUpload(goods,uploadFile);
		fileUploadSub(goods,uploadFilesub);

		//Goods goods = new Goods();
		
			/*
			 * int gno = service.getGno() + 1; System.out.println("�궡媛� 蹂대궦 gno:" + gno);
			 * goods.setGno(gno); goods.setPname(pname); goods.setStock(stock2); int
			 * realprice = Integer.parseInt(price); // goods.setPrice(realprice);
			 */		 
		 
		return "redirect:/goodsWrite/write";
	}
	
	@GetMapping("/registerGoods")
	public String registerGoods2() {
		log.info("register goods");
		return "registerGoods";
	}
	
	@GetMapping("/goodsWrite/{type}")
	public String goodsWrite(Model model, @PathVariable("type") String type) {
		int gno = service.getGno();
		log.info(gno);
		model.addAttribute("type", type);
		model.addAttribute("gno", gno);
		log.info("goods write");
		return "/goods/goodsWrite";
	}
	
	@PostMapping("/search")	
	public String search(Common common) {
		
		
		return "search";
	} 

	
	private String fileUpload(Goods goods, MultipartFile[] uploadFile) {
		String uploadFolder = filePath + "/main";

		System.out.println("상품 번호: ");
		String uploadFolderPath = String.format("%d", goods.getGno());

		// make folder ---------
		File uploadPath = new File(uploadFolder, uploadFolderPath); // 상품 번호로 경로를 만듦
		log.info("upload path: " + uploadPath);

		if (uploadPath.exists() == false) { // 해당 상품 폴더가 없으면
			uploadPath.mkdirs(); // 해당 경로에 폴더를 만든다.
		}
		// make gno folder

		for (MultipartFile multipartFile : uploadFile) {

			int i = 1;

			log.info("test : i" + i++);

			log.info("-----------------------------------");
			log.info("Upload File Name: " + multipartFile.getOriginalFilename());
			log.info("Upload File Size: " + multipartFile.getSize());



			String uploadFileName = multipartFile.getOriginalFilename();

			// IE has file path
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			log.info("only file name: " + uploadFileName);

			UUID uuid = UUID.randomUUID(); // 첨부파일은 randomUUID를 이용해서 임의의 값을 생성할 수 있다.

			uploadFileName = uuid.toString() + "_" + uploadFileName; // 생성된 값은 원래의 파일 이름과 구분할 수 있도록 중간에 '_'를 추가할 수 있음

			// File saveFile = new File(uploadFolder, uploadFileName);

			try {

				File saveFile = new File(uploadPath, uploadFileName); // c:upload/main/{상품 번호 폴더}/파일 이름으로 최종 경로 생성
				multipartFile.transferTo(saveFile); // 파일을 최종 경로로 이동

				int gno2 = goods.getGno();
				goods.setUuid(uploadFileName);
				goods.setImagepath(uploadFolderPath + "/" + uploadFileName);
				
				service.updateFilePath(goods);
//				list.add(goods);

				// 만일 이미지 타입이라면 섬네일을 생성하도록 한다.
				// check image type file
				if (checkImageType(saveFile)) {
					// FileOutputStream :데이터를 파일에 바이트 스트림으로 저장
					// File 클래스는 파일과 디렉터리를 다룸. 그래서 File 인스턴스는 파일일 수도 있고 디렉터리 일수도 있다.
					// File(String parent, String child) - parent 폴더 경로의 child라는 파일에 대한 File 객체 생성
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));

					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);

					thumbnail.close();

					goods.setUuid(uuid.toString());	
				}

			} catch (Exception e) {
				e.printStackTrace();
			} // end catch
		} // end for

		
		return null;
	}
	
	private String fileUploadSub(Goods goods, MultipartFile[] uploadFile) {
		String uploadFolder = filePath + "/sub";

		System.out.println("�궡媛� 諛쏆� �긽�뭹 踰덊샇: ");
		String uploadFolderPath = String.format("%d", goods.getGno());

		// make folder ---------
		File uploadPath = new File(uploadFolder, uploadFolderPath); // 상품 번호로 경로를 만듦
		log.info("upload path: " + uploadPath);

		if (uploadPath.exists() == false) { // 해당 상품 폴더가 없으면
			uploadPath.mkdirs(); // 해당 경로에 폴더를 만든다.
		}
		// make gno folder

		for (MultipartFile multipartFile : uploadFile) {

			int i = 1;

			log.info("test : i" + i++);

			log.info("-----------------------------------");
			log.info("Upload File Name: " + multipartFile.getOriginalFilename());
			log.info("Upload File Size: " + multipartFile.getSize());



			String uploadFileName = multipartFile.getOriginalFilename();

			// IE has file path
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			log.info("only file name: " + uploadFileName);

			UUID uuid = UUID.randomUUID(); // 첨부파일은 randomUUID를 이용해서 임의의 값을 생성할 수 있다.

			uploadFileName = uuid.toString() + "_" + uploadFileName; // 생성된 값은 원래의 파일 이름과 구분할 수 있도록 중간에 '_'를 추가할 수 있음

			// File saveFile = new File(uploadFolder, uploadFileName);

			try {

				File saveFile = new File(uploadPath, uploadFileName); // c:upload/main/{상품 번호 폴더}/파일 이름으로 최종 경로 생성
				multipartFile.transferTo(saveFile); // 파일을 최종 경로로 이동

				int gno2 = goods.getGno();
				goods.setUuid(uploadFileName);
				goods.setImagepath(uploadFolderPath + "/" + uploadFileName);
				
//				service.updateFilePath(goods);
//				list.add(goods);
				
				GoodsImage goodsImage = new GoodsImage();
				goodsImage.setUuid(uuid.toString());
				goodsImage.setImagepath(uploadFolderPath+"/"+ uploadFileName);
				goodsImage.setGno(goods.getGno());
				imageservice.insertGoodsImage(goodsImage);
//				list.add(goodsImage);


				// 만일 이미지 타입이라면 섬네일을 생성하도록 한다.
				// check image type file
				if (checkImageType(saveFile)) {
					// FileOutputStream :데이터를 파일에 바이트 스트림으로 저장
					// File 클래스는 파일과 디렉터리를 다룸. 그래서 File 인스턴스는 파일일 수도 있고 디렉터리 일수도 있다.
					// File(String parent, String child) - parent 폴더 경로의 child라는 파일에 대한 File 객체 생성
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));

					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);

					thumbnail.close();

					goods.setUuid(uuid.toString());	
				}

			} catch (Exception e) {
				e.printStackTrace();
			} // end catch
		} // end for

		
		return null;
	}
	
	
	
	private boolean checkImageType(File file) {

		try {
			String contentType = Files.probeContentType(file.toPath());

			return contentType.startsWith("image");

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return false;
	}
	
	
	@GetMapping("/goodsDetail/{gno}")
	public String goodsDetail(Model model, Common common, @PathVariable("gno") int gno) {
		log.info("goods detail");
		Common common4 = new Common();
		Goods goods = service.showOneItem(gno);
		log.info("콘텐츠"+goods.getContent());
	
		String optionList = goods.getOption_list();
		String[] optionListAll = optionList.split("\n");
		goods.setOption_list_split(optionListAll);
	
		List<Review> list = reviewService.getReviewList(common, gno);
		model.addAttribute("goods", goods);
		model.addAttribute("reviewList", list);
		model.addAttribute("ReviewCount", list.size());

		List<Review> list2 = new ArrayList<>();
		
		/*
		 * if(list.size() >= 10) { for(int i = 0; i < 10; i++) { Review review =
		 * list.get(i); log.info(review.getContent()); String content =
		 * review.getContent(); int m = content.indexOf("src=\""); if(m!=-1) { String
		 * imagepath = content.substring(m+5); log.info("imagepath"+imagepath);
		 * review.setImagepath(imagepath); }else { review.setImagepath(null); }
		 * list2.add(review); } model.addAttribute("reviewList2", list2); }
		 */
		
		
		
		common4.setGoods_no(gno);
		List<Adminclaim> claimlist = claimService.showlistAll(common4);
		model.addAttribute("claimlist", claimlist);
		
		List<GoodsImage> imagelist = imageservice.getImageList(gno);
		model.addAttribute("imagelist", imagelist);

		if(claimlist.size() > 0)
			model.addAttribute("tot4", claimlist.get(0).getTotal());
	
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String id = auth.getName();
		log.info("id: "+id);
		model.addAttribute("id", id);
		
		
		return "detail";
	}
	
	
}
