package com.dodream.controller.api;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;

import javax.mail.MessagingException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.dodream.config.auth.PrincipalDetails;
import com.dodream.dto.ReplyDto;
import com.dodream.dto.ResponseDto;
import com.dodream.model.Reply;
import com.dodream.model.ReplyItem;
import com.dodream.model.Request;
import com.dodream.model.RequestItem;
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
	
	// myrequest에서 request의 reply에 해당하는 reply의 정보들.
	@ResponseBody
	@RequestMapping(value="/user/replyInfo", method = RequestMethod.GET)
	public Reply replyInfo(Model model, HttpServletRequest httpServletRequest) {
		String id = httpServletRequest.getParameter("id");
		Reply _reply = replyService.getReply(Integer.parseInt(id));
		return _reply;
	}
	
	// myrequest에서 request의 reply에 해당하는 replyItem들을 가져옴.
	@ResponseBody
	@RequestMapping(value="/user/replyitemString", method = RequestMethod.GET)
	public String replyItemStr(HttpServletRequest httpServletRequest, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		String id = httpServletRequest.getParameter("id");
		String str_replyList = "";
		ReplyItem[] replyList = replyService.readReplyItemList(replyService.getReply(Integer.parseInt(id)));
		for(int i=0; i<replyList.length; i++) {
			RequestItem _request = requestService.getRequestItem(replyList[i].getRequestItem().getId());
			System.out.println(_request.getRequestType());
			if(_request.getRequestType().toString().equals("Stuff")) {
				str_replyList += "물품 : " + replyList[i].getReplyNum() + "개";
			} else if(_request.getRequestType().toString().equals("Finance")) {
				str_replyList += "재정 : " + replyList[i].getReplyNum() + "원";
			} else if(_request.getRequestType().toString().equals("Service")) {
				str_replyList += "봉사 : " + replyList[i].getReplyNum() + "개(명)";
			} else if(_request.getRequestType().toString().equals("Etc")) {
				str_replyList += "기타 : " + replyList[i].getReplyNum() + "개";
			}
			if(i+1 != replyList.length) {
				str_replyList += ", ";
			}
		}
		return str_replyList;
	}

	// myrequest에서 request의 reply에 해당하는 replyItem들을 가져옴.
	// myreply에서도 똑같이 replyItem들을 가져옴.
	@ResponseBody
	@RequestMapping(value="/user/replyItemObj", method = RequestMethod.GET)
	public String[] replyItemObject(HttpServletRequest httpServletRequest) {
		String id = httpServletRequest.getParameter("id");
		String str_replyType = "";
		// 여기서 id는 reply id이다.
		// 가져올 것은 replyList에서의 reply_num, requestItemList에서의 이름, 물품 타입, 
		ReplyItem[] replyItemList = replyService.readReplyItemList(replyService.getReply(Integer.parseInt(id)));
		String[] itemList = new String[replyItemList.length];
		for(int i=0; i<replyItemList.length; i++) {
			// 응답 아이템들 중에 하나의 id를 가져와서 requestItem에서 이름, 물품 타입들을 찾는다.
			RequestItem _request = requestService.getRequestItem(replyItemList[i].getRequestItem().getId());
			
//			System.out.println("타입 : " + _request.getRequestType() + ", 이름 : " + _request.getItemName() + ", 응답 아이템 개수 : " + replyItemList[i].getReplyNum());
			if(_request.getRequestType().toString().equals("Stuff")) {
				str_replyType = "물품";
			} else if(_request.getRequestType().toString().equals("Finance")) {
				str_replyType = "재정";
			} else if(_request.getRequestType().toString().equals("Service")) {
				str_replyType = "봉사";
			} else if(_request.getRequestType().toString().equals("Etc")) {
				str_replyType = "기타";
			}
			itemList[i] = str_replyType + "^!@#^" + _request.getItemName() + "^!@#^" +  replyItemList[i].getReplyNum();
			// 타입^^이름^^개수
//			System.out.println(itemList[i]);
		}
		
		return itemList;
	}	
	
	//requestType(request) / itemName(reply) / relyNum(reply) / receivedNum(reply) / itemNum(request)
	// myrequest에서 request의 reply에 해당하는 replyItem들을 가져옴.
	@ResponseBody
	@RequestMapping(value="/user/replyItemObj_reply", method = RequestMethod.GET)
	public String[] replyItemObject_myreply(HttpServletRequest httpServletRequest) {
		String id = httpServletRequest.getParameter("replyId");
		String str_replyType = "";
		// 여기서 id는 reply id이다.
		// 가져올 것은 replyList에서의 reply_num, requestItemList에서의 이름, 물품 타입, 
		ReplyItem[] replyItemList = replyService.readReplyItemList(replyService.getReply(Integer.parseInt(id)));
		String[] itemList = new String[replyItemList.length];
		for(int i=0; i<replyItemList.length; i++) {
			// 응답 아이템들 중에 하나의 id를 가져와서 requestItem에서 이름, 물품 타입들을 찾는다.
			RequestItem request = requestService.getRequestItem(replyItemList[i].getRequestItem().getId());
//			System.out.println("타입 : " + _request.getRequestType() + ", 이름 : " + _request.getItemName() + ", 응답 아이템 개수 : " + replyItemList[i].getReplyNum());
			if(request.getRequestType().toString().equals("Stuff")) {
				str_replyType = "물품";
			} else if(request.getRequestType().toString().equals("Finance")) {
				str_replyType = "재정";
			} else if(request.getRequestType().toString().equals("Service")) {
				str_replyType = "봉사";
			} else if(request.getRequestType().toString().equals("Etc")) {
				str_replyType = "기타";
			}
			itemList[i] = str_replyType + "^!@#^" + request.getItemName() + "^!@#^" +  replyItemList[i].getReplyNum() + "^!@#^" + request.getReceivedNum() + "^!@#^" + request.getItemNum() + "^!@#^" + replyItemList[i].getId() + "^!@#^";
			// 타입^^이름^^응답한 개수^^응답된개수^^목표개수
		}
		return itemList;
	}	
	
	// myreply에서 replyItem들 수정
	@ResponseBody
	@RequestMapping(value="/user/replyItemEdit", method = RequestMethod.GET)
	public void replyItemEdit(HttpServletRequest httpServletRequest) {	
		String rid = httpServletRequest.getParameter("replyItemId");
		String replyNum = httpServletRequest.getParameter("replyNum");
		String receivedNum = httpServletRequest.getParameter("receivedNum");
		
		ReplyItem replyItem = replyService.getReplyItem(Integer.parseInt(rid));
		replyItem.setReplyNum(Integer.parseInt(replyNum));
		
		RequestItem requestItem = requestService.getRequestItem(replyItem.getRequestItem().getId());
		requestItem.setReceivedNum(Integer.parseInt(receivedNum));
		
		replyService.updateReplyItem(replyItem);
		requestService.updateItem(requestItem);
	}	
	
	// myreply에서 기존 reply update
	@PostMapping("/replyUpdateProc")
	public ResponseDto<Integer> replyUpdateProc(@RequestBody Reply reply) {
		System.out.println("응답 업데이트");
		replyService.updateReply(reply);
		return new ResponseDto<Integer>(HttpStatus.OK.value(), 1);		
	}
	
	@ResponseBody
	@RequestMapping(value="/user/replyUpload", method = RequestMethod.GET)
	public void replyUpload(HttpServletRequest httpServletRequest) {	
		System.out.println("replyUpload");
		String id = httpServletRequest.getParameter("id");
		String status = httpServletRequest.getParameter("status");
		String comment = httpServletRequest.getParameter("message");
		System.out.println(id+", "+status+", "+comment);
		replyService.submitMessage(id, status, comment);
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
		if(principalDetails != null)
			return new ResponseDto<Boolean> (HttpStatus.OK.value(), replyService.checkUserInterest(principalDetails.getUser().getId(), Integer.parseInt(requestId)));
		
		return null;
	}
}
