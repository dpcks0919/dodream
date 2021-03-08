package com.dodream.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.dodream.config.auth.PrincipalDetails;
import com.dodream.service.RequestService;

@Controller
public class TestController {
	
	@Autowired
	private RequestService requestService;
	

	@GetMapping("/test/mapTest")
	public String mapTest() {

		return "test/mapTest";
	}
	
	@PostMapping("ajaxTest")
	public String ajaxTest(Model model, @PageableDefault(size=5, sort="id", direction = Sort.Direction.DESC) Pageable pageable, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		
		model.addAttribute("requests", requestService.readRequestList(pageable));
		model.addAttribute("user", principalDetails.getUser());
		
		return "request/request_table";
	}
	
}
