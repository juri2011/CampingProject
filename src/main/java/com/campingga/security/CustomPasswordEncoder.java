package com.campingga.security;

import static com.campingga.security.SHA2.sha256;

import org.springframework.security.crypto.password.PasswordEncoder;

import lombok.extern.log4j.Log4j;

@Log4j 
public class CustomPasswordEncoder implements PasswordEncoder {
	
	@Override
	public String encode(CharSequence rawPassword) {
	
		log.warn("before encode: " + rawPassword);
		
		String encodedPassword=sha256(rawPassword.toString());
	
		return encodedPassword;
	}

	@Override
	public boolean matches(CharSequence rawPassword, String encodedPassword) {
		
		log.warn("rawPassword: " +rawPassword+"/encodedPassword: "+encodedPassword);
		
		String password = sha256(rawPassword.toString());
		
		return password.equals(encodedPassword);
	}
}
