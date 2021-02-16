package com.dodream.controller;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.dodream.config.auth.PrincipalDetails;

@Controller
public class UserController {
//	요청 목록 페이지
	@GetMapping("user/requestList")
	public String userTest() {
		return "request/request_list";
	}
//	요청하기 페이지 
	@GetMapping("user/request")
	public String requestTest() {
		return "request/request";
	}

	@GetMapping("user/mypage")
	public String mypage() {
		return "my/mypage";
	}
	
	@GetMapping("user/mydodream")
	public String mydodream() {
		return "my/mydodream";
	}
	
	@GetMapping("user/myresponse")
	public String myresponse() {
		return "my/myresponse";
	}
	
	@GetMapping("user/infoCheck")
	public String infoCheck() {
		return "my/infoCheck";
	}
	
	@GetMapping("user/editInfo")
	public String editInfo(Model model,  @AuthenticationPrincipal PrincipalDetails principalDetails) {
		model.addAttribute("user", principalDetails.getUser());
		return "my/edit_info_indi";
	}
	
}
