package com.dodream.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import com.dodream.config.auth.PrincipalDetails;
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
	
	@GetMapping("user/myreply")
	public String myreply(Model model, @AuthenticationPrincipal PrincipalDetails principalDetails, @PageableDefault(size=5, sort="id", direction= Sort.Direction.DESC) Pageable pageable) {
		model.addAttribute("user", principalDetails.getUser());
		model.addAttribute("myreplyList", replyService.readMyReply(principalDetails.getUser(), pageable));
		return "my/myreply";
	}
	
	@GetMapping("user/myrequest")
	public String myrequest(Model model, @AuthenticationPrincipal PrincipalDetails principalDetails, @PageableDefault(size=5, sort="id", direction= Sort.Direction.DESC) Pageable pageable) {
		model.addAttribute("user", principalDetails.getUser());
		model.addAttribute("myrequestList", requestService.readMyRequest(0, principalDetails.getUser(), pageable));
		return "my/myrequest";
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
		return "my/edit_info_"+type;
	}
	
}