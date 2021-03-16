package com.dodream.service;

import java.util.HashMap;
import java.util.Random;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dodream.config.auth.PrincipalDetails;
import com.dodream.model.RoleType;
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
	public Page<User> readUserList(Pageable pageable) {
		System.out.println("유저서비스");
		return userRepository.findAll(pageable); 
	}
	
	
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
			user.setIsSocial(principalDetails.getUser().getIsSocial());
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
			user.setIsSocial(principalDetails.getUser().getIsSocial());
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
			user.setIsSocial(principalDetails.getUser().getIsSocial());
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
			user.setIsSocial(principalDetails.getUser().getIsSocial());
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
	
	@Transactional
	public Boolean loginService(User loginInfo, PrincipalDetails principalDetails) {
		
		if((principalDetails != null && principalDetails.getUser().getLoginCount() == 0) || principalDetails == null) {	// 1. 소셜 계정 세션은 유지되는데, 회원가입은 하지 않고 일반계정 로그인으로 진행하는 경우 2. 세션이 없고 그냥 쌩으로 로그인 하는 경우 
			try {
				return encoder.matches(loginInfo.getLoginPassword(), userRepository.findByLoginId(loginInfo.getLoginId()).getLoginPassword());	//매치시 true / 매치안되면 false
			}catch(NullPointerException e) {	// NullPointerException 나면 해당 아이디가 db에 없다는 뜻 
				return false;
			}
		}
		return false;
	}

	@Transactional
	public void update(User user) {
				
		User persistance = userRepository.findByLoginId(user.getLoginId());
		
		persistance.setUserName(user.getUserName());
		persistance.setUserSex(user.getUserSex());
		persistance.setUserDob(user.getUserDob());
		persistance.setUserPhone(user.getUserPhone());
		persistance.setUserEmail(user.getUserEmail());
		persistance.setOrgName(user.getOrgName());
		persistance.setOrgUserRole(user.getOrgUserRole());
		persistance.setNotificationRadius(user.getNotificationRadius());
		persistance.setMsgFlag(user.getMsgFlag());
		persistance.setEmailFlag(user.getEmailFlag());
		persistance.setOrgPhone(user.getOrgPhone());
		persistance.setShowFlag(user.getShowFlag());
		
		if( ! user.getAddress().trim().equals(persistance.getAddress().trim())) {
			persistance.setAddress(user.getAddress());
			persistance.setLatitude(user.getLatitude());
			persistance.setLongitude(user.getLongitude());
		}

	}
	
	@Transactional
	public void updatepw(String currentId, String password) {		
		User persistance = userRepository.findByLoginId(currentId);
		String encPassword =  encoder.encode(password);
		persistance.setLoginPassword(encPassword);
	}

	public boolean passwordCheckService(String password, String dbPassword) {
		
		return encoder.matches(password, dbPassword);
	}


	public User[] getGroupUserSerive() {
		return userRepository.findByUserTypeAndShowFlag(RoleType.GROUP, 1);
	}

	@Transactional
	public Boolean findIdService(String email) {
		User user = userRepository.findByUserEmail(email);
		if(user == null) return false;
		else {
			String content = "가입하신ID: " + user.getLoginId();
			sendEmail(user.getUserEmail(), content);
			return true;
		}
	}
	
	@Transactional
	public Boolean findPwService(String id, String email) {
		User user = userRepository.findByLoginIdAndUserEmail(id, email);
		if(user == null) return false;
		else {
			String randRawPw = UUID.randomUUID().toString().replaceAll("-", ""); // -를 제거해 주었다.
			randRawPw = randRawPw.substring(0, 10); //uuid를 앞에서부터 10자리 잘라줌.
		    System.out.println("RAND PW: " + randRawPw);
		    
			String encPassword =  encoder.encode(randRawPw);
			user.setLoginPassword(encPassword);	// 비밀번호 저장
			
			String content = "바뀐 PW: " + randRawPw;
			sendEmail(user.getUserEmail(), content);
			return true;
		}
	}

	public void sendEmail(String userEmail, String content) {
		//수신자메일 
		String rcvEmail = userEmail;
		
		//발신자 메일 
        String sendMail = "";	// 사용 이메일 주소
        String sendName = "";	// 상대방에게 표시되는 이름
		
        // 메일 내용 관련 
		// 메일 제목 
		String title = "[DoDream]";
		
		// 매일 내용(msg) 
		String msg = "";
		msg += "<div align='center' style='border:1px solid black; font-family:verdana'>";
		msg += "<h3 style='color: blue;'> " + content + "</h3>";
		msg += "<strong></div><br/>";
		
		/* 일단 막아놈

        MimeMessage message = javaMailSender.createMimeMessage();
        MimeMessageHelper mimeMessageHelper = new MimeMessageHelper(message, true, "UTF-8");

        mimeMessageHelper.setFrom(sendMail,sendName);
        mimeMessageHelper.setTo(rcvEmail);
        mimeMessageHelper.setSubject(title);
        mimeMessageHelper.setText(msg, true);

        // 메일 발송 
        javaMailSender.send(message);
        */
		
		System.out.println("수신자메일: " + rcvEmail);
		System.out.println("메일 제목: " + title);
		System.out.println("메일 내용: " +msg);		
	}

}
