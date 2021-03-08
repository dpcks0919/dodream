package com.dodream.service;

import java.io.UnsupportedEncodingException;

import javax.mail.MessagingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
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
import com.dodream.repository.ReplyItemRepository;
import com.dodream.repository.ReplyRepository;
import com.dodream.repository.RequestItemRepository;

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
    private JavaMailSender javaMailSender;

	@Transactional
	public Reply saveReply(Reply reply, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		
		reply.setRequest(requestService.getRequest(reply.getRequest().getId()));
		reply.setUser(principalDetails.getUser());
		reply.setStatus(StatusType.WAITING);

		replyRepository.save(reply);
		return reply;
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
				
		RequestItem requestItem = requestItemRepository.findById(replyItem.getItemId()).orElseThrow(() -> {
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
        String sendMail = "";	// 사용 이메일 주소
        String sendName = "";	// 상대방에게 표시되는 이름
		
        // 메일 내용 관련 
		// 메일 제목 
		String title = "[DoDream] " + " 새로운 Reply 등록됨!";
		
		// 매일 내용(msg) 
		String msg = "";
		msg += "<div align='center' style='border:1px solid black; font-family:verdana'>";
		msg += "<h3 style='color: blue;'>"+ reply.getReplyContent() +"</h3>";
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
