package com.dodream.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.dodream.config.auth.PrincipalDetails;
import com.dodream.model.Request;
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
	
	//	유저 목록 불러오기
	@GetMapping("user/managerUserTable")
	public String managerUserList(Model model, @PageableDefault(size=5, sort="id", direction = Sort.Direction.DESC) Pageable pageable, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		model.addAttribute("users", userService.readUserList(pageable));
		return "manager/manager_userTable";
	}
	//	유저 디테일 모달 채우기
	@GetMapping("user/managerUserDetail")
	public String managerUserDetail(Model model, @PageableDefault(size=5, sort="id", direction = Sort.Direction.DESC) Pageable pageable, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		// 여기서 서비스는 안만들었는데 여기부터는 해보셈
		// readUserDetail();
		//model.addAttribute("users", userService.readUserList(pageable));
		return "manager/manager_userDetail";
	}
	
	//	요청 목록 불러오기
	@GetMapping("user/managerRequestTable")
	public String managerRequestList(Model model, @PageableDefault(size=5, sort="id", direction = Sort.Direction.DESC) Pageable pageable, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		model.addAttribute("requests", requestService.readRequestList(pageable));
		return "manager/manager_requestTable";
	}
	
	//	유저 디테일 모달 채우기
	@GetMapping("user/managerRequestDetail")
	public String managerRequestDetail(Model model, @PageableDefault(size=5, sort="id", direction = Sort.Direction.DESC) Pageable pageable, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		// 여기서 서비스는 안만들었는데 여기부터는 해보셈
		// readUserDetail();
		//model.addAttribute("users", userService.readUserList(pageable));
		return "manager/manager_requestDetail";
	}
	
	//	응답 목록 불러오기
	@GetMapping("user/managerReplyTable")
	public String managerReplyList(Model model, @PageableDefault(size=5, sort="id", direction = Sort.Direction.DESC) Pageable pageable, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		model.addAttribute("replys", replyService.readReplyList_manager(pageable));
		return "manager/manager_replyTable";
	}
	//	유저 디테일 모달 채우기
	@GetMapping("user/managerReplyDetail")
	public String managerReplyDetail(Model model, @PageableDefault(size=5, sort="id", direction = Sort.Direction.DESC) Pageable pageable, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		// 여기서 서비스는 안만들었는데 여기부터는 해보셈
		// readUserDetail();
		// model.addAttribute("users", userService.readUserList(pageable));
		return "manager/manager_replyDetail";
	}
	
	
		
}
