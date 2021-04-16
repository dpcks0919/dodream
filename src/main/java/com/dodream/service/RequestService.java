package com.dodream.service;

import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dodream.config.auth.PrincipalDetails;
import com.dodream.model.ClientType;
import com.dodream.model.Reply;
import com.dodream.model.Request;
import com.dodream.model.RequestItem;
import com.dodream.model.StatusType;
import com.dodream.model.User;
import com.dodream.repository.ReplyRepository;
import com.dodream.repository.RequestItemRepository;
import com.dodream.repository.RequestRepository;
import com.dodream.repository.UserInterestRepository;
import com.dodream.repository.UserRepository;

import net.nurigo.java_sdk.api.Message;

@Service
public class RequestService {
	
	@Autowired
	private UserRepository userRepository;

	@Autowired
	private RequestRepository requestRepository;

	@Autowired
	private RequestItemRepository requestItemRepository;
	
	@Autowired
	private ReplyRepository replyRepository;
	
	@Autowired
	private UserInterestRepository userInterestRepository;
	
	@Autowired
	private SecurityService securityService;
	
	@Autowired
	@Qualifier("helpSender") // Help(요청응답 관련 계정)
    private JavaMailSender helpSender;
	
	@Value("${spring.mail.help.username}")
	private String senderEmail;
	
	@Value("${spring.mail.help.nickname}")
	private String senderName;

	@Value("${api.sms.api-key}")
	private String apiKey;
	
	@Value("${api.sms.api-secret}")
	private String apiSecret;
	
	@Value("${api.sms.send-phone}")
	private String sendPhone;
	
	@Transactional
	public Request saveRequest(Request request, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		
		int urgentLevel = request.getUrgentLevel();
		
		request.setTitle(securityService.cleanXSS(request.getTitle()));
		request.setDescription(securityService.cleanXSSSummerNote(request.getDescription()));
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
		requestRepository.save(request);
		return request;
	}

	@Transactional
	public void saveRequestItem(RequestItem requestItem) {
		
		requestItem.setItemName(securityService.cleanXSS(requestItem.getItemName()));
		
		requestItemRepository.save(requestItem);
	}
	
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
	
	@Transactional(readOnly = true)
	public Page<Request> readRequestList(int flag, Pageable pageable) {
		return requestRepository.findAllByDeleteFlag(flag, pageable);
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
	public void requestDelete(Request request) {
		Request persistance = requestRepository.findById(request.getId()).orElseThrow(() -> {
			return new IllegalArgumentException("요청 가져오기 실패 : 아이디를 찾을 수 없습니다.");
		});
		persistance.setDeleteFlag(1);
		persistance.setStatus(StatusType.DELETED);	
		
		Reply[] replyList = replyRepository.findByRequest(request);
		for(int i=0; i<replyList.length; i++) {
			Reply rep_persistance = replyList[i];
			rep_persistance.setStatus(StatusType.DELETED);
		}	
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
	public Page<Request> readMyRequest(int flag, User user, Pageable pageable) {
		return requestRepository.findByDeleteFlagAndUser(flag, user, pageable);
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
		params.put("text", "[두드림터치] 새로운 요청이 등록되었습니다: " + requestTitle); //메시지 내용 
		params.put("app_version", "test app 1.2"); 
		
//		try { 
//			JSONObject obj = (JSONObject) coolsms.send(params); 
//			System.out.println("전송 결과: " + obj.toString()); //전송 결과 출력 
//		} catch (CoolsmsException e) {
//			System.out.println(e.getMessage()); 
//			System.out.println(e.getCode()); 
//			System.out.println("Request Send Text Error!");
//		}
		}
	
	//해당 request 정보 email 전송하는 메소드 
	public void sendRequestEmailService(String userEmail, String requestTitle) throws UnsupportedEncodingException, MessagingException {
		//수신자메일 
		String rcvEmail = userEmail;
		
        // 메일 내용 관련 
		// 메일 제목 
		String title = "[두드림터치] 새로운 요청이 등록되었습니다!";
		
		// 매일 내용(msg) 
		String msg = "";
		msg += "<div align='center' style='border:2px solid #ed7e95; border-radius: 10px; font-family:verdana'>";
		msg += "<h3 style='color: black;'>새로운 요청이 등록되었습니다 : " + requestTitle + "</h3>";
		msg += "<strong></div><br/>";
		
		// 이메일 발송 부분
        MimeMessage message =  helpSender.createMimeMessage();
        MimeMessageHelper mimeMessageHelper = new MimeMessageHelper(message, true, "UTF-8");

        mimeMessageHelper.setFrom(senderEmail, senderName);
        mimeMessageHelper.setTo(rcvEmail);
        mimeMessageHelper.setSubject(title);
        mimeMessageHelper.setText(msg, true);

        // 메일 발송 
        helpSender.send(message);
	
	}
	
	@Transactional
	public void updateItem(RequestItem requestItem) {	
		RequestItem persistance = requestItemRepository.findById(requestItem.getId()).orElseThrow(() -> {
			return new IllegalArgumentException("아이템을 찾을 수 없습니다.");
		});
		
		persistance.setItemName(securityService.cleanXSS(requestItem.getItemName()));
		persistance.setItemNum(requestItem.getItemNum());
		persistance.setReceivedNum(requestItem.getReceivedNum());
		persistance.setRequestType(requestItem.getRequestType());
	}
	
	@Transactional
	public void updateRequest(Request request) {
		Request persistance = requestRepository.findById(request.getId()).orElseThrow(() -> {
			return new IllegalArgumentException("아이템을 찾을 수 없습니다.");
		});
				
		persistance.setTitle(securityService.cleanXSS(request.getTitle()));
		persistance.setRequestAddress(request.getRequestAddress());
		persistance.setLatitude(request.getLatitude());
		persistance.setLongitude(request.getLongitude());
		persistance.setDescription(securityService.cleanXSSSummerNote(request.getDescription()));		
		persistance.setClientType(request.getClientType());
		persistance.setStatus(request.getStatus());
		
		persistance.setUrgentLevel(request.getUrgentLevel());
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		if(request.getUrgentLevel() == 1 ) {
			cal.add(Calendar.DATE, 5);
		}else if(request.getUrgentLevel() == 2 ) {
			cal.add(Calendar.DATE, 14);
		}else if(request.getUrgentLevel() == 3 ) {
			cal.add(Calendar.MONTH, 1);
		}
		request.setDueDate(java.sql.Timestamp.valueOf(df.format(cal.getTime()) ));
		persistance.setUpdateDate(java.sql.Timestamp.valueOf(df.format(cal.getTime())));
		
	}

	// 찜한 request 불러오기
	@Transactional(readOnly = true)
	public Page<Request>  readInterestedRequestList(int userId, Pageable pageable) {
		
		return requestRepository.readInterestRequestByUserId(userId, pageable);
	}
	
	// myresponse
	@Transactional(readOnly = true)
	public Page<Reply> readMyResponseTable(int userId, Pageable pageable) {
		return replyRepository.findAllByUserId(userId, pageable);
	}
	
	///////////// requestSearch 
	@Transactional(readOnly = true)
	public Page<Request> searchRequestById(String searchText, Pageable pageable) {
		int id = Integer.parseInt(searchText);
		return requestRepository.findById(id, pageable);
	}
	
	@Transactional(readOnly = true)
	public Page<Request> searchRequestByTitle(String searchText, Pageable pageable) {
		return requestRepository.findByTitleContaining(searchText, pageable);
	}
	
	@Transactional(readOnly = true)
	public Page<Request> searchRequestByAddress(String searchText, Pageable pageable) {
		return requestRepository.findByRequestAddressContaining(searchText, pageable);
	}
	
	@Transactional(readOnly = true)
	public Page<Request> searchRequestByUrgentLevelAndId(int urgentLevel, String searchText, Pageable pageable) {
		int id = Integer.parseInt(searchText);
		return requestRepository.findByUrgentLevelAndId(urgentLevel, id, pageable);
	}
	
	@Transactional(readOnly = true)
	public Page<Request> searchRequestByUrgentLevelAndTitle(int urgentLevel,String searchText, Pageable pageable) {
		return requestRepository.findByUrgentLevelAndTitleContaining(urgentLevel, searchText, pageable);
	}
	
	@Transactional(readOnly = true)
	public Page<Request> searchRequestByUrgentLevelAndAddress(int urgentLevel,String searchText, Pageable pageable) {
		return requestRepository.findByUrgentLevelAndRequestAddressContaining(urgentLevel, searchText, pageable);
	}
	
	@Transactional(readOnly = true)
	public Page<Request> searchRequestByUrgentLevel(int urgentLevel, Pageable pageable) {
		return requestRepository.findByUrgentLevel(urgentLevel , pageable);
	}
	
	@Transactional(readOnly = true)
	public Page<Request> searchRequestByClientTypeAndId(String clientType, String searchText, Pageable pageable) {
		ClientType client = ClientType.valueOf(clientType);
		int id = Integer.parseInt(searchText);
		return requestRepository.findByClientTypeAndId(client, id, pageable);
	}
	
	@Transactional(readOnly = true)
	public Page<Request> searchRequestByClientTypeAndTitle(String clientType, String searchText, Pageable pageable) {
		ClientType client = ClientType.valueOf(clientType);
		return requestRepository.findByClientTypeAndTitleContaining( client, searchText, pageable);
	}
	
	@Transactional(readOnly = true)
	public Page<Request> searchRequestByClientTypeAndAddress(String clientType, String searchText, Pageable pageable) {
		ClientType client = ClientType.valueOf(clientType);
		return requestRepository.findByClientTypeAndRequestAddressContaining(client, searchText, pageable);
	}
	
	@Transactional(readOnly = true)
	public Page<Request> searchRequestByClientType(String clientType, Pageable pageable) {
		ClientType client = ClientType.valueOf(clientType);
		return requestRepository.findByClientType(client , pageable);
	}
	//
	@Transactional(readOnly = true)
	public Page<Request> searchRequestByClientTypeAndUrgentLevelAndId(String clientType, int urgentLevel, String searchText, Pageable pageable) {
		ClientType client = ClientType.valueOf(clientType);
		int id = Integer.parseInt(searchText);
		return requestRepository.findByClientTypeAndUrgentLevelAndId(client, urgentLevel, id, pageable);
	}
	
	@Transactional(readOnly = true)
	public Page<Request> searchRequestByClientTypeAndUrgentLevelAndTitle(String clientType, int urgentLevel, String searchText, Pageable pageable) {
		ClientType client = ClientType.valueOf(clientType);
		return requestRepository.findByClientTypeAndUrgentLevelAndTitleContaining(client, urgentLevel, searchText, pageable);
	}
	
	@Transactional(readOnly = true)
	public Page<Request> searchRequestByClientTypeAndUrgentLevelAndAddress(String clientType, int urgentLevel, String searchText, Pageable pageable) {
		ClientType client = ClientType.valueOf(clientType);
		return requestRepository.findByClientTypeAndUrgentLevelAndRequestAddressContaining(client, urgentLevel, searchText, pageable);
	}
	
	@Transactional(readOnly = true)
	public Page<Request> searchRequestByClientTypeAndUrgentLevel(String clientType, int urgentLevel, Pageable pageable) {
		ClientType client = ClientType.valueOf(clientType);
		return requestRepository.findByClientTypeAndUrgentLevel(client, urgentLevel,pageable);
	}

}
