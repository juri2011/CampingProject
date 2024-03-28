package com.campingga.menu;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.log;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.tiles.Attribute;
import org.apache.tiles.AttributeContext;
import org.apache.tiles.preparer.PreparerException;
import org.apache.tiles.preparer.ViewPreparer;
import org.apache.tiles.request.Request;
import org.apache.tiles.request.servlet.ServletUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.ui.ModelMap;

import com.campingga.mapper.CartMapper;
import com.campingga.mapper.MenuMapper;
import com.campingga.mapper.WishMapper;
 
public class MenuPreparer implements ViewPreparer {
 
	@Autowired
	MenuMapper mapper;
 
	@Autowired
	CartMapper cartMapper;
	
	@Autowired
	WishMapper wishMapper;
	@Override
    public void execute(Request contextrequest, AttributeContext attributeContext) throws PreparerException {
        /*HttpServletRequest servletRequest = ServletUtil.getServletRequest(contextrequest).getRequest();
        String menu = servletRequest.getParameter("menu");
        List<MenuVO> list = mapper.selectMenuList(menu);
        attributeContext.putAttribute("menuList", new Attribute(list), true);
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        int cartCount = 0;
        int wishCount = 0;
        try{
        	String memid = auth.getName();
        	if(!memid.equals("anonymousUser")) {
                cartCount = cartMapper.selectCartCount(memid);
                wishCount = wishMapper.selectWishCount(memid);
        		System.out.println(cartCount);
        	}else {
        		cartCount = 0;
        		wishCount = 0;
        	}
        	attributeContext.putAttribute("cartCount", new Attribute(cartCount), true);
        	attributeContext.putAttribute("wishCount", new Attribute(wishCount), true);
        }catch(Exception e) {
        	
        }*/

    }
}
