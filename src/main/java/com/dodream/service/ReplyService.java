package com.dodream.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dodream.config.auth.PrincipalDetails;
import com.dodream.model.Reply;
import com.dodream.model.ReplyItem;
import com.dodream.model.StatusType;
import com.dodream.repository.ReplyRepository;

@Service
public class ReplyService {
	
	@Autowired
	private RequestService requestService;
	
	@Autowired
	private ReplyRepository replyRepository;

	@Transactional
	public Reply saveReply(Reply reply, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		
		//reply.setRequest
		//reply.setRequest(requestService.getRequest(reply.getRequest().getId()));
		reply.setUser(principalDetails.getUser());
		reply.setStatus(StatusType.WAITING);

		replyRepository.save(reply);
		return reply;
	}

	@Transactional
	public void saveReplyItem(ReplyItem replyItem, PrincipalDetails principalDetails) {
		
	}
	
	

}
