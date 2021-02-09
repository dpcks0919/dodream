package com.dodream.service;

import java.util.HashMap;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dodream.config.auth.PrincipalDetails;
import com.dodream.model.StatusType;
import com.dodream.model.User;
import com.dodream.repository.UserRepository;

import net.nurigo.java_sdk.api.Message;

@Service
public class UserService {
	
	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private BCryptPasswordEncoder encoder;
	
	@Value("${api.sms.api-key}")
	private String apiKey;
	
	@Value("${api.sms.api-secret}")
	private String apiSecret;
	
	@Value("${api.sms.send-phone}")
	private String sendPhone;
	
	@Transactional
	public void increaseLoginCount(int id) {
		userRepository.increaseLoginCount(id);
	}
	
	@Transactional
	public void joinIndividual(User user, @AuthenticationPrincipal PrincipalDetails principalDetails) {

		if( principalDetails != null ) {
			System.out.println("(개인),소설 회원가입"); 
			user.setLoginId(principalDetails.getUser().getLoginId());
			user.setLoginPassword(principalDetails.getUser().getLoginPassword());
			user.setUserName(principalDetails.getUser().getUserName());
		}else {
			System.out.println("(개인)그냥 회원가입"); 
			String rawPassword = user.getLoginPassword();
			String encPassword =  encoder.encode(rawPassword);
			user.setLoginPassword(encPassword);
		}
		
		user.setStateFlag(StatusType.APPROVED);
		user.setLoginCount(1);

		userRepository.save(user);
	}
	
	@Transactional
	public void joinGroup(User user, @AuthenticationPrincipal PrincipalDetails principalDetails) {	

		if( principalDetails != null ) {
			System.out.println("(그룹)소설 회원가입"); 
			user.setLoginId(principalDetails.getUser().getLoginId());
			user.setLoginPassword(principalDetails.getUser().getLoginPassword());
		}else {
			System.out.println("(그룹)그냥 회원가입"); 
			String rawPassword = user.getLoginPassword();
			String encPassword =  encoder.encode(rawPassword);
			user.setLoginPassword(encPassword);
		}
		
		// 공통 사항 
		user.setOrgPhone(user.getUserPhone());
		user.setOrgName(user.getUserName());
		user.setStateFlag(StatusType.APPROVED);
		user.setLoginCount(1);
		
		System.out.println("OrgPhone: " + user.getOrgPhone());
		System.out.println("OrgName: " + user.getOrgName());

		userRepository.save(user);
	}
	
	@Transactional
	public void joinSocialWorker(User user, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		
		if( principalDetails != null ) {
			System.out.println("(사복)소설 회원가입"); 
			user.setLoginId(principalDetails.getUser().getLoginId());
			user.setLoginPassword(principalDetails.getUser().getLoginPassword());
			user.setUserName(principalDetails.getUser().getUserName());
		}else {
			System.out.println("(사복)그냥 회원가입"); 
			String rawPassword = user.getLoginPassword();
			String encPassword =  encoder.encode(rawPassword);
			user.setLoginPassword(encPassword);
		}
		
		// 공통 사항 
		user.setStateFlag(StatusType.WAITING);
		user.setLoginCount(1);
		
		System.out.println("UserName: " + user.getUserName());
		System.out.println("UserPhone: " + user.getUserPhone());
		System.out.println("OrgName: " + user.getOrgName());
		System.out.println("OrgPhone: " + user.getOrgPhone());

		userRepository.save(user);
		
	}

	@Transactional
	public void joinInstitution(User user, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		
		if( principalDetails != null ) {
			System.out.println("(기관)소설 회원가입"); 
			user.setLoginId(principalDetails.getUser().getLoginId());
			user.setLoginPassword(principalDetails.getUser().getLoginPassword());
		}else {
			System.out.println("(기관)그냥 회원가입"); 
			String rawPassword = user.getLoginPassword();
			String encPassword =  encoder.encode(rawPassword);
			user.setLoginPassword(encPassword);
		}
		
		// 공통 사항 
		user.setOrgPhone(user.getUserPhone());
		user.setOrgName(user.getUserName()); // orgName = userName
		user.setStateFlag(StatusType.WAITING);
		user.setLoginCount(1);
		
		System.out.println("UserName: " + user.getUserName());
		System.out.println("UserPhone: " + user.getUserPhone());
		System.out.println("OrgName: " + user.getOrgName());
		System.out.println("OrgPhone: " + user.getOrgPhone());

		userRepository.save(user);
		
	}
	
	public String sendTextService(String userPhone) {	 //랜덤으로 verifyCode 생성 후 문자 발송 및 리턴하는 메소드 
		System.out.println("코드 생성 후 문자 발송"); 
		
		// rand verifyCode 생성 
		Random rand = new Random();
		String randNum = "";
		for(int i = 0; i < 4; i++) {
			String ran = Integer.toString(rand.nextInt(10));
			randNum += ran;	// random 인증번호 생성
		}

		Message coolsms = new Message(apiKey.toString(), apiSecret.toString()); 
		HashMap<String, String> params = new HashMap<String, String>(); 
		params.put("to", userPhone); 
		params.put("from", sendPhone); //사전에 사이트에서 번호를 인증하고 등록하여야 함 
		params.put("type", "SMS"); 
		params.put("text", "[DoDream]\nHere's your verification code: " + randNum); //메시지 내용 
		params.put("app_version", "test app 1.2"); 
		
//		try { 
//			JSONObject obj = (JSONObject) coolsms.send(params); 
//			System.out.println("전송 결과: " + obj.toString()); //전송 결과 출력 
//		} catch (CoolsmsException e) {
//			System.out.println(e.getMessage()); 
//			System.out.println(e.getCode()); 
//			return null;	//발송불가 시 null 리턴 
//		}
		System.out.println(randNum);
		
		return randNum; // 최종적으로 verifyCode 리턴 
	}

	@Transactional
	public Boolean idCheckService(String userId) {	// 아이디 중복 테스트 
		if(userRepository.findByLoginId(userId) == null) return true;
		else return false;	//있으면(중복) false
	}
	
	

}
