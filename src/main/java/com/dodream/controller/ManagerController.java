package com.dodream.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.dodream.config.auth.PrincipalDetails;
import com.dodream.service.ReplyService;
import com.dodream.service.RequestService;
import com.dodream.service.UserService;

@Controller
public class ManagerController {
	
	@Autowired
	private RequestService requestService;
	
	@Autowired
	private ReplyService replyService;
	
	@Autowired
	private UserService userService;
	
	@GetMapping("manager/manager")
	public String managerPage(Model model, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		return "manager/main";
	}
	
	//	User list
	@GetMapping("manager/managerUserTable")
	public String managerUserList(Model model, @PageableDefault(size=5, sort="id", direction = Sort.Direction.DESC) Pageable pageable, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		model.addAttribute("users", userService.readUserList(pageable));
		return "manager/manager_userTable";
	}
	//	User detail
	@GetMapping("manager/managerUserDetail")
	public String managerUserDetail(Model model, @PageableDefault(size=5, sort="id", direction = Sort.Direction.DESC) Pageable pageable, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		return "manager/manager_userDetail";
	}
	
	//	Request list
	@GetMapping("manager/managerRequestTable")
	public String managerRequestList(Model model, @PageableDefault(size=5, sort="id", direction = Sort.Direction.DESC) Pageable pageable, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		model.addAttribute("requests", requestService.readRequestList(pageable));
		return "manager/manager_requestTable";
	}
	
	//	Request detail
	@GetMapping("manager/managerRequestDetail")
	public String managerRequestDetail(Model model, @PageableDefault(size=5, sort="id", direction = Sort.Direction.DESC) Pageable pageable, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		return "manager/manager_requestDetail";
	}
	
	//	Reply list
	@GetMapping("manager/managerReplyTable")
	public String managerReplyList(Model model, @PageableDefault(size=5, sort="id", direction = Sort.Direction.DESC) Pageable pageable, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		model.addAttribute("replys", replyService.readReplyList_manager(pageable));
		return "manager/manager_replyTable";
	}
	//	Reply detail
	@GetMapping("manager/managerReplyDetail")
	public String managerReplyDetail(Model model, @PageableDefault(size=5, sort="id", direction = Sort.Direction.DESC) Pageable pageable, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		return "manager/manager_replyDetail";
	}
		
}
