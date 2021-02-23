package com.dodream.config.auth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.dodream.model.User;
import com.dodream.repository.UserRepository;

// 시큐리티 설정에서 loginProcessingUrl("/login");
// login 요청이 오면 자동으로 UserDetailsService 타입으로 IoC 되어 있는 loadUserByUsername 함수가 실행.
// 해당 함수가 종료될 때, @AuthenticationPrincipal 어노테이션이 만들어진다.
@Service
public class PrincipalDetailsService implements UserDetailsService {

	@Autowired
	private UserRepository userRepository;
	
	@Override
	public UserDetails loadUserByUsername(String loginId) throws UsernameNotFoundException {
		User userEntity = userRepository.findByLoginId(loginId);
	    System.out.println("userEntity"+ userEntity);
		if(userEntity != null) {
			return new PrincipalDetails(userEntity);
		}
		return null;
	}

	
}
