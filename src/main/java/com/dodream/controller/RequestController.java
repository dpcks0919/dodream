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
public class RequestController {
	
	@Autowired
	private RequestService requestService;
	
	//	요청 목록 페이지
	@GetMapping("user/requestList")
	public String requestList(Model model, @PageableDefault(size=5, sort="id", direction = Sort.Direction.ASC) Pageable pageable, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		model.addAttribute("requests", requestService.readRequestList(pageable));
		model.addAttribute("user", principalDetails.getUser());
		System.out.println(principalDetails.getUser());
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
}
