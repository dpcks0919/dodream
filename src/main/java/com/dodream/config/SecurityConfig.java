package com.dodream.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.Ordered;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.dodream.config.auth.PrincipalDetailsService;
import com.dodream.config.oauth.PrincipalOauth2UserService;
import com.navercorp.lucy.security.xss.servletfilter.XssEscapeServletFilter;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity( securedEnabled = true , prePostEnabled = true) // @Secured 어노테이션 활성화!, preAuthorized 어노테이션 활성화 
public class SecurityConfig extends WebSecurityConfigurerAdapter{
	
	@Autowired
	private PrincipalOauth2UserService principalOauth2UserService;
	
	@Autowired 
	private PrincipalDetailsService principalDetailService;
	
	@Autowired
	private OAuth2AuthenticationSuccessHandler oAuth2AuthenticationSuccessHandler;
	
	@Bean
	public BCryptPasswordEncoder encodePWD() {
		return new BCryptPasswordEncoder();
	}
	
	
	@Bean
	@Override
	public AuthenticationManager authenticationManagerBean() throws Exception {
		return super.authenticationManagerBean();
	}
	
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception{
		auth.userDetailsService(principalDetailService).passwordEncoder(encodePWD());
	}
	
	@Override
	protected void configure(HttpSecurity http) throws Exception{
		http.csrf().disable();		
		http.authorizeRequests()
			.antMatchers("/user/**").access("hasRole('ROLE_INDIVIDUAL_APPROVED') or hasRole('ROLE_GROUP_APPROVED') or hasRole('ROLE_SOCIAL_WORKER_APPROVED') or hasRole('ROLE_INSTITUTION_APPROVED') or hasRole('ROLE_ADMIN_APPROVED')")
			.antMatchers("/social/**").access("hasRole('ROLE_SOCIAL_WORKER_APPROVED') or hasRole('ROLE_INSTITUTION_APPROVED') or hasRole('ROLE_ADMIN_APPROVED')")
			.antMatchers("/manager/**").access("hasRole('ROLE_ADMIN_APPROVED')")
			.anyRequest().permitAll()
			.and()
			.formLogin()
			.loginPage("/loginForm")
			.usernameParameter("loginId") // 해당 설정을 해줘야 PrincipalDetailsService에서 parameter로 이해가능.
			.passwordParameter("loginPassword")
			.loginProcessingUrl("/login") // login 주소가 호출이 되면 시큐리티가 낚아채서 대신 로그인을 진행해준다. --> controller에서 /login이 없어도됨.
			.defaultSuccessUrl("/")
			.and()
			.oauth2Login()
			.loginPage("/loginForm") 
			.userInfoEndpoint()
			.userService(principalOauth2UserService) // 구글 로그인이 완료된 뒤 후처리 필요! --> 구글로그인은 코드가 아니라 액세스토큰 과 사용자 프로필정보를 바로 받아옴
			.and()
			.successHandler(oAuth2AuthenticationSuccessHandler)
			.and()
		    .exceptionHandling().accessDeniedPage("/WEB-INF/views/accessDenied.jsp");
			;
	}
	
	// naver lucy xss filter
	@Bean
    public FilterRegistrationBean<XssEscapeServletFilter> getFilterRegistrationBean(){
        FilterRegistrationBean<XssEscapeServletFilter> registrationBean = new FilterRegistrationBean<>();
        registrationBean.setFilter(new XssEscapeServletFilter());
        registrationBean.setOrder(Ordered.LOWEST_PRECEDENCE);
        registrationBean.addUrlPatterns("*.do", "*.jsp");
        return registrationBean;
    }
}
