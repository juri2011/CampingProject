package com.campingga.common;


import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.UUID;

@Component
public class FileIO {

    //파일 업로드는 서버에 파일저장 + db에 uuid로 파일 이름 경로 저장

    /**
     * 파일 업로드 후 vo를 리턴
     */
    public void uploadFile(Long bno, MultipartFile multipartFile, String fileDir) {
        //업로드할 파일이 비어있으면 return null
        if(multipartFile.isEmpty()){
            return;
        }

        //사용자가 업로드한 파일 네임
        String originalFileName = multipartFile.getOriginalFilename();
        //서버에 업로드할 파일 네임
        String storedFileName = getStoredFileName(extracteExt(originalFileName));
        //이미지 카테고리 cover=c,book_imgs=i
        String imgCategory = "c";
        //업로드 파일의 확장자
        String ext = extracteExt(originalFileName);
        //업로드 파일의 사이즈
        long size = multipartFile.getSize();

        try {
            //파일 업로드(서버에 저장)
            multipartFile.transferTo(new File(getFullPath(fileDir,storedFileName)));
        } catch (IOException e) {
            throw new RuntimeException("파일 업로드 실패");
        }
        //사용자업로드 파일이름,서버업로드 파일이름 저장한 vo 리턴
    }

    /**
     * 파일목록 업로드
     */
    public void uploadFiles(Long bno,List<MultipartFile> multipartFiles, String fileDir) {
        //업로드한 파일 목록을 저장할 리스트 생성
        /*List<> uploadFilesList = new ArrayList<>();
        //넘어온 multipartfiles를 순회하며 각각 upload 실행후 list에 저장
        for (MultipartFile multipartFile : multipartFiles) {
            ImageVO bookimgVO = uploadFile(bno,multipartFile, fileDir);
            //이미지 카테고리 cover=c,book_imgs=i
            if(bookimgVO!=null){
                bookimgVO.setImgCategory("i");
            }
            uploadFilesList.add(bookimgVO);
        }
        return uploadFilesList;*/
    }


    /**
     * 파일의 fullpath 리턴
     */
    private String getFullPath(String fileDir,String fileName){
        return fileDir+fileName;
    }

    /**
     * 서버에 저장할 파일 네임 추출 메서드
     */
    private String getStoredFileName(String ext) {
        //서버에 저장하는 파일네임(uuid이용) <- book db에 저장될값
        //사용자가 업롤드한 파일의 확장자를 추출한뒤 uuid뒤에 붙임
        //uuid 사용
        String uuid= UUID.randomUUID().toString();
        return uuid+"."+ ext;
    }

    /**
     * 확장자 추출 메서드
     */
    private static String extracteExt(String originalFilename) {
        int pos = Objects.requireNonNull(originalFilename).lastIndexOf(".");
        return originalFilename.substring(pos + 1);
    }


    /*
    cos를 이용해 이미지 저장 디렉토리(경로)를 얻어온다
     */
    public String getFiledDir(HttpServletRequest request) {
        //파일 업로드 경로를 설정
        //세션으로 부터 현재 어플리케이션 컨텍스트를 얻어온다
        ServletContext context = request.getSession().getServletContext();
        //어플리케이션 컨텍스트 루트 바로 아래 /resources/upload라는 경로를 얻어옴
        return context.getRealPath("/resources/upload/images");
    }
}
