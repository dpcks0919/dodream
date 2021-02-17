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
import com.dodream.service.RequestService;

@Controller
public class UserController {
	
	@Autowired
	private RequestService requestService;
	
//	요청 목록 페이지
	@GetMapping("user/requestList")
	public String requestList(Model model, @PageableDefault(size=5, sort="id", direction = Sort.Direction.ASC) Pageable pageable) {
		model.addAttribute("requests", requestService.readRequestList(pageable));
		return "request/request_list";
	}
	
	// 이렇게 하면 페이지가 새로 로드가 되어서 고민	
	@GetMapping("user/requestList/{id}")
	public String findById(@PathVariable int id, Model model) {
		model.addAttribute("request", requestService.viewDetail(id));
		model.addAttribute("isDetail", 1);
		return "request/request_list";
	}
	
//	요청하기 페이지 
	@GetMapping("user/request")
	public String requestForm() {
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
