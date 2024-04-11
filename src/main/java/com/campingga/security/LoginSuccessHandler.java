package com.campingga.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

import lombok.extern.log4j.Log4j;

@Log4j 
public class LoginSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler  {
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication auth) throws IOException, ServletException {
		log.warn("Login Success");
		List<String> roleNames = new ArrayList<>();
		auth.getAuthorities().forEach(authority -> {
			roleNames.add(authority.getAuthority());
		});
		
		log.warn("Role NAMES: " + roleNames);
		
		HttpSession session = request.getSession();
		Map<String, Object> memberInfo = new HashMap<>();
		
		memberInfo.put("mem_id", null);
		
		//로그인한 사용자라면
		if (auth != null && auth.isAuthenticated()
        && !"anonymousUser".equals(auth.getPrincipal())) {
      //사용자 아이디
		  memberInfo.put("mem_id", auth.getName());
  		
		  //사용자가 관리자 권한을 가지고 있다면
		  if(auth.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"))) {
  		  
  		  memberInfo.put("isAdmin", true);
      }
      else {
 
        memberInfo.put("isAdmin", false);
      }
		}
		//세션에 Map 값 저장
    session.setAttribute("memberInfo", memberInfo);
    
        response.sendRedirect("/");
	}

}
