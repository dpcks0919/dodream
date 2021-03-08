package com.dodream.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dodream.config.auth.PrincipalDetails;
import com.dodream.service.RequestService;

@Controller
public class RequestController {
	
	@Autowired
	private RequestService requestService;
	
	//	요청 페이지 지도
	@GetMapping("user/requestMap")
	public String requestMap(Model model, @PageableDefault(size=5, sort="id", direction = Sort.Direction.DESC) Pageable pageable, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		model.addAttribute("requests", requestService.readRequestList(pageable));
		model.addAttribute("user", principalDetails.getUser());
		return "request/request_map";
	}
	
	//	요청 페이지 목록
	@GetMapping("user/requestList")
	public String requestList(Model model, @PageableDefault(size=5, sort="id", direction = Sort.Direction.DESC) Pageable pageable, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		model.addAttribute("requests", requestService.readRequestList(pageable));
		model.addAttribute("user", principalDetails.getUser());
		return "request/request_list";
	}
	
	//	요청 목록 불러오기
	@GetMapping("user/requestTable")
	public String requestTable(Model model, @PageableDefault(size=5, sort="id", direction = Sort.Direction.DESC) Pageable pageable, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		model.addAttribute("requests", requestService.readRequestList(pageable));
		model.addAttribute("user", principalDetails.getUser());
		return "request/request_table";
	}
	
	//	요청하기 페이지 
	@GetMapping("user/request")
	public String requestForm() {
		return "request/request";
	}
	
	@RequestMapping(value="/jusoPopup_request")
	public String jusoPopup() {
		return "join/jusoPopup";
	}
}
