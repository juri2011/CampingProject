package com.campingga.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.campingga.domain.Member;
import com.campingga.mapper.MemberMapper;
import com.campingga.security.domain.CustomUser;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailsService implements UserDetailsService {

	@Autowired
	private MemberMapper mapper;


	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
		log.warn("Load User By UserName: " + username);
		
		Member member = mapper.selectMemberaslogin(username);
		
		log.warn("queried by member mapper: " + member);
		
		if (member == null) {
            throw new UsernameNotFoundException("User not found");
        }

		return member == null ? null : new CustomUser(member);
	}
	
}
