package com.dodream.service;

import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;

import javax.mail.MessagingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dodream.config.auth.PrincipalDetails;
import com.dodream.model.ClientType;
import com.dodream.model.Request;
import com.dodream.model.RequestItem;
import com.dodream.model.User;
import com.dodream.repository.RequestItemRepository;
import com.dodream.repository.RequestRepository;
import com.dodream.repository.UserRepository;

import net.nurigo.java_sdk.api.Message;

@Service
public class RequestService {
	
	//application.yml과 연결되어 해당 설정으로 사용할수 있게함?
	@Autowired
    private JavaMailSender javaMailSender;
	
	@Autowired
	private UserRepository userRepository;

	@Autowired
	private RequestRepository requestRepository;

	@Autowired
	private RequestItemRepository requestItemRepository;
	
	@Value("${api.sms.api-key}")
	private String apiKey;
	
	@Value("${api.sms.api-secret}")
	private String apiSecret;
	
	@Value("${api.sms.send-phone}")
	private String sendPhone;

//	@Autowired
//	private UserInterestRepository userInterestRepository;
	
	@Transactional
	public Request saveRequest(Request request, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		
		int urgentLevel = request.getUrgentLevel();
		
		request.setUser(principalDetails.getUser());
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		if(urgentLevel == 1 ) {
			cal.add(Calendar.DATE, 5);
		}else if(urgentLevel == 2 ) {
			cal.add(Calendar.DATE, 14);
		}else if(urgentLevel == 3 ) {
			cal.add(Calendar.MONTH, 1);
		}
		request.setDueDate(java.sql.Timestamp.valueOf(df.format(cal.getTime()) ));
		System.out.println("saveRequest");
		requestRepository.save(request);
		return request;
	}

	// @Transactional(readOnly = true)
	@Transactional
	public void saveRequestItem(RequestItem requestItem) {
		requestItemRepository.save(requestItem);
		System.out.println("saveRequestItem");
	}
	
//	@Transactional
//	public void saveHeart(UserInterest userInterest, @AuthenticationPrincipal PrincipalDetails principalDetails)
//		userInterest.setUser(principalDetails.getUser());
//		
//		userInterestRepository.save();
//	}
	
	
	//new
	@Transactional
	public int addRequestItem(RequestItem requestItem, int addNum) {
		int receivedNum = requestItem.getReceivedNum();
		int itemNum = requestItem.getItemNum();
		
		if(itemNum >= receivedNum + addNum) {
			requestItem.setReceivedNum(receivedNum + addNum);
			return 1;
		} else {
			return 0;
		}
	}

	@Transactional(readOnly = true)
	public Page<Request> readRequestList(Pageable pageable) {
		return requestRepository.findAll(pageable);
	}
	
	@Transactional
	public Request[] requestListProcService() {
		Request[] requestList = requestRepository.findAllByDeleteFlag(0);
		return requestList;
	}

	@Transactional
	public Request[] markProcService(String clientType) {
		Request[] requestList = requestRepository.findAllByClientType(ClientType.valueOf(clientType));
		return requestList;
	}

	@Transactional
	public Request getRequest(int id) {
		return requestRepository.findById(id).orElseThrow(() -> {
			return new IllegalArgumentException("요청글 가져오기 실패 : 아이디를 찾을 수 없습니다.");
		});
	}
	
	@Transactional
	public RequestItem getRequestItem(int id) {
		return requestItemRepository.findById(id).orElseThrow(() -> {
			return new IllegalArgumentException("요청 아이템 가져오기 실패 : 아이디를 찾을 수 없습니다.");
		});
	}

	@Transactional
	public User[] getValidUserListService() {
		// 1. userType=GROUP or INDIVIDUAL / 2. stateFlag = APPROVED / 3. MsgFlag = 1 OR EmailFlag = 1 <- 해당하는 userList
		User[] validUserList = userRepository.findValidUser(); 
		return validUserList;
	}
	
	// 해당 request 정보 문자 전송하는 메소드 
	public void sendTextService(String userPhone, String requestTitle) {	 

		Message coolsms = new Message(apiKey.toString(), apiSecret.toString()); 
		HashMap<String, String> params = new HashMap<String, String>(); 
		params.put("to", userPhone); 
		params.put("from", sendPhone); //사전에 사이트에서 번호를 인증하고 등록하여야 함 
		params.put("type", "SMS"); 
		params.put("text", "[DoDream] 새로운 요청이 등록되었습니다: " + requestTitle); //메시지 내용 
		params.put("app_version", "test app 1.2"); 
		
//		try { 
//			JSONObject obj = (JSONObject) coolsms.send(params); 
//			System.out.println("전송 결과: " + obj.toString()); //전송 결과 출력 
//		} catch (CoolsmsException e) {
//			System.out.println(e.getMessage()); 
//			System.out.println(e.getCode()); 
//			return null;	//발송불가 시 null 리턴 
//		}
//		
		System.out.println("발송번호: " + params.get("to"));
		System.out.println("문자 내용: " + params.get("text"));
		}
	
	//해당 request 정보 email 전송하는 메소드 
	public void sendEmailService(String userEmail, String requestTitle) throws UnsupportedEncodingException, MessagingException {
		//수신자메일 
		String rcvEmail = userEmail;
		
		//발신자 메일 
        String sendMail = "";	// 사용 이메일 주소
        String sendName = "";	// 상대방에게 표시되는 이름
		
        // 메일 내용 관련 
		// 메일 제목 
		String title = "[DoDream] " + requestTitle;
		
		// 매일 내용(msg) 
		String msg = "";
		msg += "<div align='center' style='border:1px solid black; font-family:verdana'>";
		msg += "<h3 style='color: blue;'>새로운 요청이 등록되었습니다</h3>";
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
