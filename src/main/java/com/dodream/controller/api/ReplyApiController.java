package com.dodream.controller.api;

import java.io.UnsupportedEncodingException;

import javax.mail.MessagingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.dodream.config.auth.PrincipalDetails;
import com.dodream.dto.ReplyDto;
import com.dodream.dto.ResponseDto;
import com.dodream.model.Reply;
import com.dodream.model.Request;
import com.dodream.service.ReplyService;
import com.dodream.service.RequestService;

@RestController
public class ReplyApiController {
	
	@Autowired
	private ReplyService replyService;
	
	@Autowired
	private RequestService requestService;
	
	@PostMapping("/notifySocialWorkerByEmailProc")
	public ResponseDto<Integer> notifySocialWorkerByEmailProc(@RequestBody Reply reply) throws UnsupportedEncodingException, MessagingException{
		// requestId로 해당 request 객체 찾기
		Request request = requestService.getRequest(reply.getRequest().getId());
		replyService.notifySocialWorkerByEmail(reply, request);
		return new ResponseDto<Integer> (HttpStatus.OK.value(), null); 
	}
	
	@PostMapping("/replySaveProc")
	public ResponseDto<Request> replySaveProc(@RequestBody ReplyDto replyDto, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		
		int check = 0;
		
		for(int i=0;  i < replyDto.getReplyItems().length; i ++) {
			System.out.println(replyDto.getReplyItems()[i].getId());
			check += replyService.checkItemValidation(replyDto.getReplyItems()[i].getId(), 
													 Integer.parseInt(replyDto.getReplyItems()[i].getReplyNum()));
		}
				
		if (check > 0 ) {
			return new ResponseDto<Request> (HttpStatus.OK.value(), requestService.getRequest(replyDto.getReply().getRequest().getId()));
		}
		
		Reply newReply = replyService.saveReply(replyDto.getReply(), principalDetails);
		
		for(int i=0;  i < replyDto.getReplyItems().length; i ++) {
			replyService.saveReplyItem(replyDto.getReplyItems()[i], newReply);
			replyService.addReceivedNumber(replyDto.getReplyItems()[i].getId(), 
											Integer.parseInt(replyDto.getReplyItems()[i].getReplyNum()));
		}
		
		return new ResponseDto<Request> (HttpStatus.OK.value(), null);
	}
	
	@PostMapping("/addUserInterestProc")
	public ResponseDto<Integer> addUserInterestProc(@RequestParam(value = "requestId") String requestId, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		Request request = requestService.getRequest(Integer.parseInt(requestId));
		replyService.saveUserInterest(principalDetails.getUser(), request);
		return new ResponseDto<Integer> (HttpStatus.OK.value(), 1);
	}
	
	@PostMapping("/deleteUserInterestProc")
	public ResponseDto<Integer> deleteUserInterestProc(@RequestParam(value = "requestId") String requestId, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		replyService.deleteUserInterest(principalDetails.getUser().getId(), Integer.parseInt(requestId));
		return new ResponseDto<Integer> (HttpStatus.OK.value(), 1);
	}
	
	@PostMapping("/checkUserInterestProc")
	public ResponseDto<Boolean> checkUserInterestProc(@RequestParam(value = "requestId") String requestId, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		return new ResponseDto<Boolean> (HttpStatus.OK.value(), replyService.checkUserInterest(principalDetails.getUser().getId(), Integer.parseInt(requestId)));
	}
}
