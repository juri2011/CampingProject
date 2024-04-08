package com.campingga.security.domain;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.campingga.domain.MemberVO;

import lombok.Getter;

@Getter
public class CustomUser extends User {

  private static final long serialVersionUID = 1L;

  private MemberVO member;

  //Collection<? extends GrantedAuthority> -> GrandAuthority를 상속받은 type만 쓸 수 있다
  public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
    super(username, password, authorities);
  }

  public CustomUser(MemberVO vo) {

    super(vo.getMem_id(), vo.getPwd(), vo.getAuthList().stream()
    .map(auth -> new SimpleGrantedAuthority(auth.getAuth())).collect(Collectors.toList()));

    this.member = vo;
  }
}