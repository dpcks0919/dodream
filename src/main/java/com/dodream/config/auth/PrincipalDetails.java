package com.dodream.config.auth;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Map;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.oauth2.core.user.OAuth2User;

import com.dodream.model.User;

import lombok.Data;

//시큐리티가 /login 주소 요청이 오면 낚아채서 로그인을 진행시킨다.
// 로그인을 진행이 완료가 되면 시큐리티가 session을 만들어준다. (Security ContextHolder)
// session에 들어갈 수 있는 객체가 정해져 잇음 -> Authentication 타입 객체
// Authentication 안에 user 정보가 있어야 됨.
// User 오브젝트 타입 -> UserDetilas 타입 객체
// Security Session -> Authentication -> UserDetails

@Data
public class PrincipalDetails implements UserDetails, OAuth2User{
	
	private User user; 
	private Map<String, Object> attributes;
	
	public PrincipalDetails(User user) {
		this.user = user;
	}
	
	public PrincipalDetails(User user, Map<String,Object> attributes){
		this.user = user;
		this.attributes = attributes;
	}
	 

	// 해당 유저의 권한을 리턴하는 곳!
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		Collection<GrantedAuthority> collectors = new ArrayList<>();
		
		collectors.add(()->{ return "ROLE_" + user.getUserType() + "_" + user.getStateFlag();});
		
		return collectors;
	}

	@Override
	public String getPassword() {
		// TODO Auto-generated method stub
		return user.getLoginPassword();
	}

	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return user.getLoginId();
	}

	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public Map<String, Object> getAttributes() {
		return attributes;
	}

	@Override
	public String getName() {
		//attributes.get("sub")
		return null ;
	}
	
}
