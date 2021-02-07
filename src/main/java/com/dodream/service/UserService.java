package com.dodream.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dodream.config.auth.PrincipalDetails;
import com.dodream.model.StatusType;
import com.dodream.model.User;
import com.dodream.repository.UserRepository;

@Service
public class UserService {
	
	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private BCryptPasswordEncoder encoder;
	
	@Transactional
	public void increaseLoginCount(int id) {
		userRepository.increaseLoginCount(id);
	}
	
	@Transactional
	public void joinUser(User user, @AuthenticationPrincipal PrincipalDetails principalDetails) {

		if( principalDetails != null ) {
			System.out.println("소설 회원가입"); 
			user.setLoginId(principalDetails.getUser().getLoginId());
			user.setLoginPassword(principalDetails.getUser().getLoginPassword());
			user.setUserName(principalDetails.getUser().getUserName());
		}else {
			System.out.println("그냥 회원가입"); 
			String rawPassword = user.getLoginPassword();
			String encPassword =  encoder.encode(rawPassword);
			user.setLoginPassword(encPassword);
		}
		
		user.setStateFlag(StatusType.WAITING);
		user.setLoginCount(1);

		userRepository.save(user);
	}
	

}
