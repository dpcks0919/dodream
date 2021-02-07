package com.dodream.config;

import java.io.IOException;

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
        
    	String targetUrl = determineTargetUrl(request, response, authentication);
        if (response.isCommitted()) {
            logger.debug("Response has already been committed. Unable to redirect to " + targetUrl);
            return;
        }
        
    	PrincipalDetails principal = (PrincipalDetails) authentication.getPrincipal();
    	
    	System.out.println(principal.getUser().getLoginCount());
    	if( principal.getUser().getLoginCount() == 0 ) {
            getRedirectStrategy().sendRedirect(request, response, "/joinFormMain_s");
    	}else {
            getRedirectStrategy().sendRedirect(request, response, targetUrl);
    	}
    	
    }

}
