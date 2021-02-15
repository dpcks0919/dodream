package com.dodream.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class UserController {

	@GetMapping("user/requestlist")
	public String userTest() {
		return "request/request_list";
	}
	
	//	성민 테스트로 넣어놓은 부분 
	@GetMapping("user/requestForm")
	public String requestTest() {
		return "request/request";
	}

}
