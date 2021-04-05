package com.dodream.controller.api;
 
import java.io.UnsupportedEncodingException;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.dodream.config.auth.PrincipalDetails;
import com.dodream.dto.ResponseDto;
import com.dodream.model.RoleType;
import com.dodream.model.StatusType;
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
	
	private String rawPassword;

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
	
	@PostMapping("/loginProc")
	public ResponseDto<Integer> login(@RequestBody User loginInfo, @AuthenticationPrincipal PrincipalDetails principalDetails) {		
		if(userService.loginService(loginInfo, principalDetails)) {	// true 리턴시 로그인 처리 
			Authentication authentication = authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(loginInfo.getLoginId(), loginInfo.getLoginPassword()));
			SecurityContextHolder.getContext().setAuthentication(authentication); 		//세션 등록.
		}
		else {	// false 리턴시 에러 송출
			return new ResponseDto<Integer>(HttpStatus.INTERNAL_SERVER_ERROR.value(), 1);
		}
	
		return new ResponseDto<Integer>(HttpStatus.OK.value(), 1);	// 로그인 성공
	}
	
	@PostMapping("/textProc")
	public ResponseDto<String> sendText(@RequestParam(value = "userPhone") String userPhone) {	// verifyCode(스트링) 리턴 
		
		return new ResponseDto<String>(HttpStatus.OK.value(), userService.sendTextService(userPhone) );
	}
	
	@PostMapping("/idCheckProc")
	public ResponseDto<Boolean> idCheck(@RequestParam(value = "userId") String userId) {	// boolean 값 리턴(false: 아이디 중복)
		
		return new ResponseDto<Boolean>(HttpStatus.OK.value(), userService.idCheckService(userId));
	}
	
	@PostMapping("/emailCheckProc")
	public ResponseDto<Boolean> emailCheck(@RequestParam(value = "useremail") String useremail) {	// boolean 값 리턴(false: 이메일 중복)
		return new ResponseDto<Boolean>(HttpStatus.OK.value(), userService.emailCheckService(useremail));
	}
	
	@PostMapping("/passwordCheckProc")
	public ResponseDto<Boolean> passwordCheck(@RequestParam(value = "password") String password, @AuthenticationPrincipal PrincipalDetails principalDetails) {	// boolean 값 리턴(false: 아이디 중복)
	
		Boolean status = userService.passwordCheckService(password, principalDetails.getUser().getLoginPassword());
		rawPassword = password;
		
		return new ResponseDto<Boolean>( HttpStatus.OK.value(), status);
	}
	
	@PutMapping("/updateProc")
	public ResponseDto<Integer> update(@RequestBody User user, @AuthenticationPrincipal PrincipalDetails principalDetails){
		
		int isSocial = principalDetails.getUser().getIsSocial();
		Authentication authentication;

		userService.update(user);
		
		if( isSocial == 0 ) {
			authentication = authenticationManager.
					authenticate(new UsernamePasswordAuthenticationToken(user.getLoginId(), rawPassword));
		}else {
			authentication = authenticationManager.
					authenticate(new UsernamePasswordAuthenticationToken(user.getLoginId(), socialPassword));
		}
		
		SecurityContextHolder.getContext().setAuthentication(authentication); 		//세션 등록.
		
		return new ResponseDto<Integer>(HttpStatus.OK.value(), 1);
	}
	
	@PutMapping("/deleteUserProc")
	public ResponseDto<Integer> deleteUser(@RequestBody User user, @AuthenticationPrincipal PrincipalDetails principalDetails){
		userService.userDelete(user);
		return new ResponseDto<Integer>(HttpStatus.OK.value(), 1);
	}
	
	@PutMapping("/updateUserProc")
	public ResponseDto<Integer> updateUser(@RequestBody User user, @AuthenticationPrincipal PrincipalDetails principalDetails){
		StatusType getStatus = user.getStateFlag();
		String status = getStatus.toString();
		RoleType getRole = user.getUserType();
		String role = getRole.toString();
		
		userService.managerUpdate(user, status, role);
		
		return new ResponseDto<Integer>(HttpStatus.OK.value(), 1);
	}
	
	@PutMapping("/updatepwProc")
	public ResponseDto<Integer> updateUserpw(@RequestParam(value = "password") String password, @AuthenticationPrincipal PrincipalDetails principalDetails){
		
		Authentication authentication;
		String currentId = principalDetails.getUser().getLoginId();
		userService.updatepw(currentId, password);
		
		authentication = authenticationManager.
				authenticate(new UsernamePasswordAuthenticationToken(currentId, password));
		
		SecurityContextHolder.getContext().setAuthentication(authentication); 		//세션 등록.
		
		return new ResponseDto<Integer>(HttpStatus.OK.value(), 1);
	}
	
	@PutMapping("/updateUserPwProc")
	public ResponseDto<Integer> managerUpdateUserpw(@RequestParam(value = "id") String id, @RequestParam(value = "password") String password, @AuthenticationPrincipal PrincipalDetails principalDetails){
		userService.updatepw(id, password);		
		return new ResponseDto<Integer>(HttpStatus.OK.value(), 1);
	}
	
	@PostMapping("/findIdProc")
	public ResponseDto<Boolean> findIdProc(@RequestParam(value = "email") String email) throws UnsupportedEncodingException, MessagingException{
		return new ResponseDto<Boolean>(HttpStatus.OK.value(), userService.findIdService(email));
	}
	
	@PostMapping("/findPwProc")
	public ResponseDto<Boolean> findPwProc(@RequestParam(value = "id") String id, @RequestParam(value = "email") String email) throws UnsupportedEncodingException, MessagingException{
		return new ResponseDto<Boolean>(HttpStatus.OK.value(), userService.findPwService(id, email));
	}
	
}