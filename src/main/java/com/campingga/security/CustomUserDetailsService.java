package com.campingga.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.campingga.domain.MemberVO;
import com.campingga.mapper.MemberMapper;
import com.campingga.security.domain.CustomUser;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailsService implements UserDetailsService{
  
  @Autowired
  private MemberMapper memberMapper;

  @Override
  public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {
    
    log.warn("Load User By UserName : " + userName);
    
    //userName means userid
    MemberVO vo = memberMapper.read(userName);
    
    log.warn(vo);
    
    return vo == null ? null : new CustomUser(vo);
  }
  
}
