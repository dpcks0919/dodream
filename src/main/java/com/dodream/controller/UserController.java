package com.dodream.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dodream.config.auth.PrincipalDetails;
import com.dodream.model.ReplyItem;
import com.dodream.model.RequestItem;
import com.dodream.service.ReplyService;
import com.dodream.service.RequestService;

@Controller
public class UserController {
	
	@Autowired
	private RequestService requestService;
	
	@Autowired
	private ReplyService replyService;
	
	@GetMapping("user/mypage")
	public String mypage(Model model, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		model.addAttribute("user", principalDetails.getUser());
		return "my/mypage";
	}
	
	@GetMapping("user/mydodream")
	public String mydodream(Model model, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		model.addAttribute("user", principalDetails.getUser());
		return "my/mydodream";
	}
	
	@GetMapping("user/myresponse")
	public String myresponse() {
		return "my/myresponse";
	}
	
	@GetMapping("user/myrequest")
	public String myrequest(Model model, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		model.addAttribute("user", principalDetails.getUser());
		model.addAttribute("myrequestList", requestService.readMyRequest(principalDetails.getUser()));
		System.out.println(model);
		return "my/myrequest";
	}

	//	myreuqest에서 request의 reply들의 List를 가져옴.
	//@GetMapping("user/replyTable")
	@RequestMapping(value="/user/replyTable", method = RequestMethod.GET)
	public String replyTable(Model model, HttpServletRequest httpServletRequest, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		String id = httpServletRequest.getParameter("id");
		System.out.println(id);
		model.addAttribute("replyList", replyService.readReplyList(requestService.getRequest(Integer.parseInt(id))));
		model.addAttribute("user", principalDetails.getUser());
		return "my/reply_table";
	}
	
	// myrequest에서 request의 reply에 해당하는 replyItem들을 가져옴.
	@ResponseBody
	@RequestMapping(value="/user/replyitemList", method = RequestMethod.GET)
	public String replyItemTable(Model model, HttpServletRequest httpServletRequest, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		String id = httpServletRequest.getParameter("id");
		System.out.println("id=" + id);
		String str_replyList = "";
		model.addAttribute("replyItemList", replyService.readReplyItemList(replyService.getReply(Integer.parseInt(id))));
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
		System.out.println(str_replyList);
		return str_replyList;
	}
	
	
	
	@GetMapping("user/pwCheck")
	public String pwCheck() {
		return "my/pwCheck";
	}
	@GetMapping("user/pwChange")
	public String pwChange() {
		return "my/pwChange";
	}
	
	@GetMapping("user/infoCheck/{type}")
	public String infoCheck(@PathVariable(value="type") String type, Model model, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		
		int isSocial = principalDetails.getUser().getIsSocial();
		model.addAttribute("userType", principalDetails.getUser().getUserType());
		
		if( isSocial == 0 ) {
			//hidden 타입으로 받아서 my.js에서 editInfo로 보낼 때 type이랑 같이 보내야됨.
			return "my/infoCheck";
		}else {
			return "redirect:/user/editInfo/"+type ;
		}
	}
	
	@GetMapping("user/editInfo/{type}")
	public String editInfo(@PathVariable(value="type") String type, Model model,  @AuthenticationPrincipal PrincipalDetails principalDetails) {
		model.addAttribute("user", principalDetails.getUser());
		System.out.println(type);
		
		return "my/edit_info_"+type;
	}

}