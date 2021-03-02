package com.dodream.controller.api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.dodream.config.auth.PrincipalDetails;
import com.dodream.dto.ResponseDto;
import com.dodream.model.Reply;
import com.dodream.model.ReplyItem;
import com.dodream.service.ReplyService;

@RestController
public class ReplyApiController {
	
	@Autowired
	private ReplyService replyService;
	
	@PostMapping("/replySaveProc")
	public ResponseDto<Reply> replySave(@RequestBody Reply reply, @AuthenticationPrincipal PrincipalDetails principalDetails) {
				
		// 해당 request의 requestItem들의 필요 수량을 다시 확인해야 됨!
		Reply newReply = replyService.saveReply(reply, principalDetails);
		return new ResponseDto<Reply> (HttpStatus.OK.value(), newReply);
	}
	
	@PostMapping("/replyItemSaveProc")
	public ResponseDto<Integer> saveReplyItem(@RequestBody ReplyItem replyItem, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		System.out.println(replyItem);
		replyService.saveReplyItem(replyItem, principalDetails);
		return new ResponseDto<Integer> (HttpStatus.OK.value(), 1);
	}
}
