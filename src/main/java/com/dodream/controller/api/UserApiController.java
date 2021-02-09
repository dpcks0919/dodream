package com.dodream.controller.api;
 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
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
	
	@Autowired
	private AuthenticationManager authenticationManager;
	
	@Value("${social.password}")
	private String socialPassword;
	
	@PostMapping("/joinProc")
	public ResponseDto<Integer> save(@RequestBody User user, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		
		String password;
		
		if(principalDetails != null) {
			password = socialPassword;
		}else {
			password = user.getLoginPassword();
		}
		
		//4가지 경우 나눠서 분리 
		if(user.getUserType().equals(RoleType.INDIVIDUAL)) userService.joinIndividual(user, principalDetails);
		else if(user.getUserType().equals(RoleType.GROUP)) userService.joinGroup(user, principalDetails);
		else if(user.getUserType().equals(RoleType.SOCIAL_WORKER)) userService.joinSocialWorker(user, principalDetails);
		else if(user.getUserType().equals(RoleType.INSTITUTION)) userService.joinInstitution(user, principalDetails);
		else if(user.getUserType().equals(RoleType.ADMIN)) userService.joinGroup(user, principalDetails);
		
		Authentication authentication = authenticationManager.
				authenticate(new UsernamePasswordAuthenticationToken(user.getLoginId(), password));
		SecurityContextHolder.getContext().setAuthentication(authentication); 		//세션 등록.
		
		return new ResponseDto<Integer>(HttpStatus.OK.value(), 1);
	}
	
	@PostMapping("/textProc")
	public String sendText(@RequestParam(value = "userPhone") String userPhone) {	// verifyCode(스트링) 리턴 
		return userService.sendTextService(userPhone);
	}
	
	@PostMapping("/idCheckProc")
	public Boolean idCheck(@RequestParam(value = "userId") String userId) {	// boolean 값 리턴(false: 아이디 중복)
		return userService.idCheckService(userId);
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
