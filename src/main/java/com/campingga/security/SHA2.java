package com.campingga.security;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import lombok.NoArgsConstructor;

@NoArgsConstructor
public class SHA2 {

	public static String sha256(String password) {
	    try {
	        MessageDigest digest = MessageDigest.getInstance("SHA-256");
	        byte[] hash = digest.digest(password.getBytes(StandardCharsets.UTF_8));
	
	        // 해시 값을 16진수 문자열로 변환
	        StringBuilder hexString = new StringBuilder();
	        for (byte b : hash) {
	            String hex = Integer.toHexString(0xff & b);
	            if (hex.length() == 1) {
	                hexString.append('0');
	            }
	            hexString.append(hex);
	        }
	
	        return hexString.toString();
	    } catch (NoSuchAlgorithmException e) {
	        e.printStackTrace();
	        return null;
	    }
	}
}
