package com.dodream.service;

import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

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
import com.dodream.dto.ReplyItemDto;
import com.dodream.model.Reply;
import com.dodream.model.ReplyItem;
import com.dodream.model.Request;
import com.dodream.model.RequestItem;
import com.dodream.model.StatusType;
import com.dodream.model.User;
import com.dodream.model.UserInterest;
import com.dodream.repository.ReplyItemRepository;
import com.dodream.repository.ReplyRepository;
import com.dodream.repository.RequestItemRepository;
import com.dodream.repository.UserInterestRepository;

@Service
public class ReplyService {
	
	@Autowired
	private RequestService requestService;
	
	@Autowired
	private ReplyRepository replyRepository;
	
	@Autowired
	private RequestItemRepository requestItemRepository;
	
	@Autowired
	private ReplyItemRepository replyItemRepository;
	
	@Autowired
	private UserInterestRepository userInterestRepository;
	
	@Autowired
	@Qualifier("helpSender") // Help(요청응답 관련 계정)
    private JavaMailSender helpSender;
	
	@Value("${spring.mail.help.username}")
	private String senderEmail;
	
	@Value("${spring.mail.help.nickname}")
	private String senderName;

	@Transactional
	public Reply getReply(int id) {
		return replyRepository.findById(id).orElseThrow(() -> {
			return new IllegalArgumentException("응답글 가져오기 실패 : 아이디를 찾을 수 없습니다.");
		});
	}
	
	@Transactional
	public ReplyItem getReplyItem(int id) {
		return replyItemRepository.findById(id).orElseThrow(() -> {
			return new IllegalArgumentException("응답 아이템 가져오기 실패 : 아이디를 찾을 수 없습니다.");
		});
	}
	
	@Transactional
	public Reply[] readReplyList(Request request) {
		// TODO Auto-generated method stub
		return replyRepository.findByRequest(request);
	}
	
	@Transactional
	public Page<Reply> readReplyList_manager(Pageable pageable) {
		return replyRepository.findAll(pageable);
	}
	
	@Transactional
	public ReplyItem[] readReplyItemList(Reply reply) {
		return replyItemRepository.findByReply(reply);		
	}	
	
	
	
	@Transactional
	public Reply saveReply(Reply reply, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		
		reply.setRequest(requestService.getRequest(reply.getRequest().getId()));
		reply.setUser(principalDetails.getUser());
		reply.setStatus(StatusType.WAITING);

		replyRepository.save(reply);
		return reply;
	}
	
	
	
	@Transactional
	public void submitMessage(String id, String status, String comment) {
		Reply persistance = getReply(Integer.parseInt(id));
		StatusType _status = null;
		if(status.equals("WAITING")) {
			_status = StatusType.WAITING;
			
		} else if(status.equals("APPROVED")) {
			_status = StatusType.APPROVED;
		} 

		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		persistance.setComment(comment);
		persistance.setStatus((StatusType) _status);
		persistance.setUpdateDate(java.sql.Timestamp.valueOf(df.format(cal.getTime())));
		System.out.println("submitMessage");
	}
	
	// myreply에서 응답 내역 수정
	@Transactional
	public void updateReply(Reply reply) {
		Reply persistance = replyRepository.findById(reply.getId()).orElseThrow(() -> {
			return new IllegalArgumentException("응답 내역을 찾을 수 없습니다.");
		});
				
		persistance.setReplyUser(reply.getReplyUser());
		persistance.setReplyOrg(reply.getReplyOrg());
		persistance.setReplyContent(reply.getReplyContent());
		persistance.setReplyPhone(reply.getReplyPhone());
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		persistance.setUpdateDate(java.sql.Timestamp.valueOf(df.format(cal.getTime())));
	}
	
	// myreply에서 replyItem들 수정
	@Transactional
	public void updateReplyItem(ReplyItem replyItem) {	
		ReplyItem persistance = replyItemRepository.findById(replyItem.getId()).orElseThrow(() -> {
			return new IllegalArgumentException("아이템을 찾을 수 없습니다.");
		});		
		
		persistance.setReplyNum(replyItem.getReplyNum());
	}
	
	

	/*
	@Transactional
	public ReplyItem saveReplyItem(ReplyItem replyItem ) {
		
		replyItem.setRequestItem( requestService.getRequestItem(replyItem.getRequestItem().getId()) );
		
		replyItemRepository.save(replyItem);
		
		return replyItem;
	}
	*/
	@Transactional
	public void saveReplyItem(ReplyItemDto replyItem, Reply newReply ) {
				
		RequestItem requestItem = requestItemRepository.findById(replyItem.getId()).orElseThrow(() -> {
			return new IllegalArgumentException("요청 아이템 가져오기 실패 : 아이디를 찾을 수 없습니다.");
		});
		
		ReplyItem newReplyItem = ReplyItem.builder()
				.replyNum(Integer.parseInt(replyItem.getReplyNum()))
				.reply(newReply)
				.requestItem(requestItem)
				.build();
				
		replyItemRepository.save(newReplyItem);	
	}
	
	@Transactional
	public int checkItemValidation(int itemId, int replyNum) {

		RequestItem requestItem = requestItemRepository.findById(itemId).orElseThrow(() -> {
			return new IllegalArgumentException("요청 아이템 가져오기 실패 : 아이디를 찾을 수 없습니다.");
		});
		
		if( requestItem.getReceivedNum() + replyNum > requestItem.getItemNum() ) {
			return 1;
		}		
		return 0;
	}

	@Transactional
	public void addReceivedNumber(int itemId, int replyNum) {
		
		RequestItem requestItem = requestItemRepository.findById(itemId).orElseThrow(() -> {
			return new IllegalArgumentException("요청 아이템 가져오기 실패 : 아이디를 찾을 수 없습니다.");
		});
		
		requestItem.setReceivedNum(requestItem.getReceivedNum() + replyNum );
	}
	
	//해당 reply 정보 email 전송하는 메소드 
	public void notifySocialWorkerByEmail(Reply reply, Request request) throws UnsupportedEncodingException, MessagingException {
		//수신자메일 
		String rcvEmail = request.getUser().getUserEmail();
		
		//발신자 메일 
//        String sendMail = senderEmail;	// 사용 이메일 주소
//        String sendName = senderName;	// 상대방에게 표시되는 이름
		
        // 메일 내용 관련 
		// 메일 제목 
		String title = "[두드림터치] " + " 새로운 Reply가 등록되었습니다!";
		
		// 매일 내용(msg) 
		String msg = "";
		msg += "<div align='center' style='border:2px solid #ed7e95; border-radius: 10px; font-family:verdana'>";
		msg += "<h3 style='color: black;'> Reply 내용: "+ reply.getReplyContent() +"</h3>";
		msg += "<strong></div><br/>";
		
		//메일 내용 부분
        MimeMessage message = helpSender.createMimeMessage();
        MimeMessageHelper mimeMessageHelper = new MimeMessageHelper(message, true, "UTF-8");

        mimeMessageHelper.setFrom(senderEmail,senderName);
        mimeMessageHelper.setTo(rcvEmail);
        mimeMessageHelper.setSubject(title);
        mimeMessageHelper.setText(msg, true);

        // 메일 발송 
        helpSender.send(message);
		
		System.out.println("수신자메일: " + rcvEmail);
		System.out.println("메일 제목: " + title);
		System.out.println("메일 내용: " +msg);		
	}

	public void saveUserInterest(User user, Request request) {
		System.out.println("ADDING USERINTEREST");		
		System.out.println("USERID: "+ user.getId());		
		System.out.println("REQUESTID: "+ request.getId());
		
		UserInterest newUserInterest = new UserInterest();
		newUserInterest.setUser(user);
		newUserInterest.setRequest(request);
		
		userInterestRepository.save(newUserInterest);
	}

	public void deleteUserInterest(int userId, int requestId) {
		System.out.println("DELETING USERINTEREST");		
		
		UserInterest deletingUserInterest = userInterestRepository.findByUserIdAndRequestId(userId, requestId);
		System.out.println("DELETE USERINTEREST ID: "+ deletingUserInterest.getId());		
		userInterestRepository.deleteById(deletingUserInterest.getId());
		
	}

	public Boolean checkUserInterest(int userId, int requestId) {
		return userInterestRepository.existsByUserIdAndRequestId(userId, requestId);
	}
	
	public Page<Reply> readMyReply(User user, Pageable pageable) {
		System.out.println("service");
		return replyRepository.findByUser(user, pageable);
	}

}
