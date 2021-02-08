package com.dodream.controller.api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.dodream.config.auth.PrincipalDetails;
import com.dodream.dto.ResponseDto;
import com.dodream.model.RoleType;
import com.dodream.model.User;
import com.dodream.service.UserService;

@RestController
public class UserApiController {
	
	@Autowired
	private UserService userService;
	
	@PostMapping("/joinProc")
	public ResponseDto<Integer> save(@RequestBody User user, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		
		System.out.println("usrAPi");
		//4가지 경우 나눠서 분리 
		if(user.getUserType().equals(RoleType.INDIVIDUAL)) userService.joinIndividual(user, principalDetails);
		else if(user.getUserType().equals(RoleType.GROUP)) userService.joinGroup(user, principalDetails);
		else if(user.getUserType().equals(RoleType.SOCIAL_WORKER)) userService.joinSocialWorker(user, principalDetails);
		else if(user.getUserType().equals(RoleType.INSTITUTION)) userService.joinInstitution(user, principalDetails);
		else if(user.getUserType().equals(RoleType.ADMIN)) userService.joinGroup(user, principalDetails);
		
		return new ResponseDto<Integer>(HttpStatus.OK.value(), 1);
	}
	
	@PostMapping("/addrSearchProc")
	public ResponseDto<Integer> addrSearch(@RequestBody User user, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		
		return new ResponseDto<Integer>(HttpStatus.OK.value(), 1);
	}
	
//	@PutMapping("/user")
//	public ResponseDto<Integer> update(@RequestBody User user){
//		userService.회원수정(user);
//		// 서비스가 종료되면서 트랜잭션이 종료되어서 db 값은 변경되었지만
//		// 세션값은 변경되지 않은 상태이기 때문에 변경 필요
//		
//		Authentication authentication = authenticationManager.
//				authenticate(new UsernamePasswordAuthenticationToken(user.getUsername(), user.getPassword()));
//		SecurityContextHolder.getContext().setAuthentication(authentication); 		//세션 등록.
//
//		
//		return new ResponseDto<Integer>(HttpStatus.OK.value(), 1);
//	}

}
