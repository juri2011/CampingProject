package com.campingga.common;

public class RandomImageString {
	
	private String base = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890";
	private String result = "";
	
	//16자리 난수 문자열 생성 - 이미지 경로
	public String makeRandomString() {
		String[] baseList = base.split("");
		
		for(int i = 0; i < 16; i++) {
			i = (int)(Math.random()*baseList.length) + 1;
			result += baseList[i];
		}
		return result;
	}
}
