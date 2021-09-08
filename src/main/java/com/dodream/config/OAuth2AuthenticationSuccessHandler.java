package com.dodream.config;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import com.dodream.config.auth.PrincipalDetails;
@Component
public class OAuth2AuthenticationSuccessHandler extends SimpleUrlAuthenticationSuccessHandler {
	    
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
            	
    	System.out.println("success");
    	
    	String targetUrl = determineTargetUrl(request, response, authentication);
        if (response.isCommitted()) {
            return;
        }
        
    	PrincipalDetails principal = (PrincipalDetails) authentication.getPrincipal();
    	
    	if( principal.getUser().getLoginCount() == 0 ) {
            getRedirectStrategy().sendRedirect(request, response, "/joinForm_privacy_s");
    	}else {
    		response.setContentType("text/html; charset=UTF-8");    		 
    		PrintWriter out = response.getWriter();    		 
    		out.println("<script>alert('로그인 되었습니다.'); location.href='/';</script>");    		
    		out.flush();
    	}
    }

}
