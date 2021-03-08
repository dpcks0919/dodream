package com.dodream.service;

import org.springframework.beans.factory.annotation.Autowired;
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

	@Transactional
	public Reply getReply(int id) {
		return replyRepository.findById(id).orElseThrow(() -> {
			return new IllegalArgumentException("요청글 가져오기 실패 : 아이디를 찾을 수 없습니다.");
		});
	}
	
	@Transactional
	public Reply[] readReplyList(Request request) {
		// TODO Auto-generated method stub
		return replyRepository.findByRequest(request);
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
	
	

}
