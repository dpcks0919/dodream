package com.dodream.controller;

import org.springframework.beans.factory.annotation.Autowired;
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
	
	
	
	@GetMapping("user/manager")
	public String managerPage(Model model, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		
		return "manager/main";
	}
	
	
}
