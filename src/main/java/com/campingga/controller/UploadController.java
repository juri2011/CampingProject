package com.campingga.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.campingga.common.CommonUtils;
import com.campingga.domain.Goods;
import com.campingga.domain.GoodsImage;
import com.campingga.service.GoodsImageService;
import com.campingga.service.GoodsService;
import com.google.gson.JsonObject;
import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j 
public class UploadController {

	
	@Autowired
	private GoodsImageService imageservice;

	@Value("${file.path}")
	private String filePath;

	
	@Autowired
	GoodsService service;

	@GetMapping("/uploadForm")
	public void uploadForm() {

		log.info("upload form");
	}

	@GetMapping("/uploadAjax")
	public void uploadAjax() {

		log.info("upload ajax");
	}

	@PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<Goods>> uploadAjaxPost(@RequestParam("gno") String gno,
			MultipartFile[] uploadFile) {

		String uploadFolder = filePath + "/main";

		
		System.out.println("상품 번호: ");
		String uploadFolderPath = String.format("%d", gno);

		// make folder ---------
		File uploadPath = new File(uploadFolder, uploadFolderPath); // 상품 번호로 경로를 만듦
		log.info("upload path: " + uploadPath);

		if (uploadPath.exists() == false) { // 해당 상품 폴더가 없으면
			uploadPath.mkdirs(); // 해당 경로에 폴더를 만든다.
		}
		// make gno folder
		List<Goods> list = new ArrayList<Goods>();
		for (MultipartFile multipartFile : uploadFile) {
			Goods goods = new Goods();

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


		return new ResponseEntity<>(list, HttpStatus.OK);
	}

	@PostMapping(value = "/uploadAjaxActionSub", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<Goods>> uploadAjaxPostSub(@RequestParam("gno") Integer gno,
			MultipartFile[] uploadFile) {

		String uploadFolder = filePath + "/sub";

		System.out.println("�궡媛� 諛쏆� �긽�뭹 踰덊샇: ");
		String uploadFolderPath = String.format("%d", gno);

		// make folder ---------
		File uploadPath = new File(uploadFolder, uploadFolderPath); // 상품 번호로 경로를 만듦
		log.info("upload path: " + uploadPath);

		if (uploadPath.exists() == false) { // 해당 상품 폴더가 없으면
			uploadPath.mkdirs(); // 해당 경로에 폴더를 만든다.
		}
		// make gno folder
		List<Goods> list = new ArrayList<Goods>();

		for (MultipartFile multipartFile : uploadFile) {			
			Goods goods = new Goods();
			goods.setGno(gno);
			
			int i = 1;

			log.info("test : i" + i++);

			log.info("-----------------------------------");
			log.info("Upload File Name: " + multipartFile.getOriginalFilename());
			log.info("Upload File Size: " + multipartFile.getSize());



			String uploadFileName = multipartFile.getOriginalFilename();

			// IE has file path
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("/") + 1);
			log.info("only file name: " + uploadFileName);

			UUID uuid = UUID.randomUUID(); // 첨부파일은 randomUUID를 이용해서 임의의 값을 생성할 수 있다.

			uploadFileName = uuid.toString() + "_" + uploadFileName; // 생성된 값은 원래의 파일 이름과 구분할 수 있도록 중간에 '_'를 추가할 수 있음

			// File saveFile = new File(uploadFolder, uploadFileName);

			try {

				File saveFile = new File(uploadPath, uploadFileName); // c:upload/main/{상품 번호 폴더}/파일 이름으로 최종 경로 생성
				multipartFile.transferTo(saveFile); // 파일을 최종 경로로 이동

			//	int gno2 = goods.getGno();
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


		return new ResponseEntity<>(list, HttpStatus.OK);
	}

	
	
	
	// 연.월.일 폴더를 만드는 함수
	private String getFolder() {

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		Date date = new Date();

		String str = sdf.format(date);

		return str.replace("-", File.separator);
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

	// 섬네일 보여주기
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName) {

		log.info("fileName: " + fileName);

		File file = new File("c:\\upload\\" + fileName);

		log.info("file: " + file);

		ResponseEntity<byte[]> result = null;

		try {
			HttpHeaders header = new HttpHeaders();

			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch (IOException e) {

			e.printStackTrace();
		}
		return result;
	}

	@GetMapping(value = "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent, String fileName) {

		log.info("download file: " + fileName);

		FileSystemResource resource = new FileSystemResource("C:\\upload\\" + fileName);

		if (resource.exists() == false) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}

		log.info("resource: " + resource);

		String resourceName = resource.getFilename();

		// remove UUID
		String resourceOriginalName = resourceName.substring(resourceName.indexOf("_") + 1);

		HttpHeaders headers = new HttpHeaders();

		try {
			String downloadName = null;

			if (userAgent.contains("Trident")) {

				log.info("IE browser");

				downloadName = URLEncoder.encode(resourceName, "UTF-8").replaceAll("\\+", " ");
			} else if (userAgent.contains("Edge")) {

				log.info("Edge browser");

				downloadName = URLEncoder.encode(resourceName, "UTF-8");

				log.info("Edge name: " + downloadName);
			} else {

				log.info("Chrome browser");
				downloadName = new String(resourceName.getBytes("UTF-8"), "ISO-8859-1");
			}
			log.info("downloadName: " + downloadName);
			headers.add("Content-Disposition", "attachment; filename=" + downloadName);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}

	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type) {

		log.info("deleteFile: " + fileName);

		File file;

		try {
			file = new File("c:\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));

			file.delete();

			if (type.equals("image")) {

				String largeFileName = file.getAbsolutePath().replace("s_", "");

				log.info("largeFileName: " + largeFileName);

				file = new File(largeFileName);

				file.delete();
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}

		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}

	@RequestMapping(value = "/fileupload.do", method = RequestMethod.POST)
	@ResponseBody
	public String fileUpload(HttpServletRequest req, HttpServletResponse resp, MultipartHttpServletRequest multiFile)
			throws Exception {
		JsonObject json = new JsonObject();
		PrintWriter printWriter = null;
		OutputStream out = null;
		MultipartFile file = multiFile.getFile("upload");
		if (file != null) {
			if (file.getSize() > 0 && StringUtils.isNotBlank(file.getName())) {
				if (file.getContentType().toLowerCase().startsWith("image/")) {
					try {
						String fileName = file.getOriginalFilename();

						System.out.println("fileName=" + fileName);
						byte[] bytes = file.getBytes();
						String uploadPath = filePath;
						//String uploadPath = req.getSession().getServletContext().getRealPath("/file"); // 톰캣서버 경로
						System.out.println("uploadPath=" + uploadPath);
						File uploadFile = new File(uploadPath);

						System.out.println("uploadFile" + uploadFile);
						if (!uploadFile.exists()) {
							uploadFile.mkdirs();
						}

						String fileName1 = fileName.substring(fileName.lastIndexOf(".")); // 확장자
						fileName = CommonUtils.getRandomString() + fileName1;
						// fileName = UUID.randomUUID().toString();
						System.out.println("fileName=" + fileName);
						uploadPath = uploadPath + "/" + fileName;
						System.out.println("uploadPath=" + uploadPath);
						out = new FileOutputStream(new File(uploadPath));
						out.write(bytes);

						printWriter = resp.getWriter();
						System.out.println("printWriter=" + printWriter);

						resp.setContentType("text/html");
						String fileUrl = req.getContextPath() + "/upload/" + fileName;
						System.out.println("fileUrl=" + fileUrl);

						// json 데이터로 등록
						// {"uploaded" : 1, "fileName" : "test.jpg", "url" : "/img/test.jpg"}
						// 이런 형태로 리턴이 나가야함.
						json.addProperty("uploaded", 1);
						json.addProperty("fileName", fileName);
						json.addProperty("url", fileUrl);

						printWriter.println(json);
					} catch (IOException e) {
						e.printStackTrace();
					} finally {
						if (out != null) {
							out.close();
						}
						if (printWriter != null) {
							printWriter.close();
						}
					}
				}
			}
		}

		return null;
	}
	
	
	@PostMapping(value = "/fileReviewUpload.do")
	@ResponseBody
	public String fileReviewUpload(HttpServletRequest req, HttpServletResponse resp, MultipartHttpServletRequest multiFile)
			throws Exception {
		JsonObject json = new JsonObject();
		PrintWriter printWriter = null;
		OutputStream out = null;
		MultipartFile file = multiFile.getFile("upload");
		if (file != null) {
			if (file.getSize() > 0 && StringUtils.isNotBlank(file.getName())) {
				if (file.getContentType().toLowerCase().startsWith("image/")) {
					try {
						String fileName = file.getOriginalFilename();

						System.out.println("fileName=" + fileName);
						byte[] bytes = file.getBytes();
						String uploadPath = filePath;
						//String uploadPath = req.getSession().getServletContext().getRealPath("/file"); // 톰캣서버 경로
						System.out.println("uploadPath=" + uploadPath);
						File uploadFile = new File(uploadPath);

						System.out.println("uploadFile" + uploadFile);
						if (!uploadFile.exists()) {
							uploadFile.mkdirs();
						}

						String fileName1 = fileName.substring(fileName.lastIndexOf(".")); // 확장자
						fileName = CommonUtils.getRandomString() + fileName1;
						// fileName = UUID.randomUUID().toString();
						System.out.println("fileName=" + fileName);
						uploadPath = uploadPath + "/review/" + fileName;
						System.out.println("uploadPath=" + uploadPath);
						out = new FileOutputStream(new File(uploadPath));
						out.write(bytes);

						printWriter = resp.getWriter();
						System.out.println("printWriter=" + printWriter);

						resp.setContentType("text/html");
						String fileUrl = req.getContextPath() + "/upload/review/" + fileName;
						System.out.println("fileUrl=" + fileUrl);

						// json 데이터로 등록
						// {"uploaded" : 1, "fileName" : "test.jpg", "url" : "/img/test.jpg"}
						// 이런 형태로 리턴이 나가야함.
						json.addProperty("uploaded", 1);
						json.addProperty("fileName", fileName);
						json.addProperty("url", fileUrl);

						printWriter.println(json);
					} catch (IOException e) {
						e.printStackTrace();
					} finally {
						if (out != null) {
							out.close();
						}
						if (printWriter != null) {
							printWriter.close();
						}
					}
				}
			}
		}

		return null;
	}

}
