package com.dodream.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.dodream.config.auth.PrincipalDetails;
import com.dodream.dto.ResponseDto;
import com.dodream.model.Request;
import com.dodream.model.User;
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
	
	@GetMapping("user/manager")
	public String managerPage(Model model, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		return "manager/main";
	}
	
	//	User list
	@GetMapping("user/managerUserTable")
	public String managerUserList(Model model, @PageableDefault(size=5, sort="id", direction = Sort.Direction.DESC) Pageable pageable, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		model.addAttribute("users", userService.readUserList(pageable));
		return "manager/manager_userTable";
	}
	//	User detail
	@GetMapping("user/managerUserDetail")
	public String managerUserDetail(Model model, @PageableDefault(size=5, sort="id", direction = Sort.Direction.DESC) Pageable pageable, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		return "manager/manager_userDetail";
	}
	
	//	Request list
	@GetMapping("user/managerRequestTable")
	public String managerRequestList(Model model, @PageableDefault(size=5, sort="id", direction = Sort.Direction.DESC) Pageable pageable, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		model.addAttribute("requests", requestService.readRequestList(pageable));
		return "manager/manager_requestTable";
	}
	
	//	Request detail
	@GetMapping("user/managerRequestDetail")
	public String managerRequestDetail(Model model, @PageableDefault(size=5, sort="id", direction = Sort.Direction.DESC) Pageable pageable, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		return "manager/manager_requestDetail";
	}
	
	//	Reply list
	@GetMapping("user/managerReplyTable")
	public String managerReplyList(Model model, @PageableDefault(size=5, sort="id", direction = Sort.Direction.DESC) Pageable pageable, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		model.addAttribute("replys", replyService.readReplyList_manager(pageable));
		return "manager/manager_replyTable";
	}
	//	Reply detail
	@GetMapping("user/managerReplyDetail")
	public String managerReplyDetail(Model model, @PageableDefault(size=5, sort="id", direction = Sort.Direction.DESC) Pageable pageable, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		return "manager/manager_replyDetail";
	}
		
}
