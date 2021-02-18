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
	public String mypage(Model model, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		model.addAttribute("user", principalDetails.getUser());
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
	
	@GetMapping("user/pwCheck")
	public String pwCheck() {
		return "my/pwCheck";
	}
	@GetMapping("user/pwChange")
	public String pwChange() {
		return "my/pwChange";
	}
	
	@GetMapping("user/infoCheck/{type}")
	public String infoCheck(@PathVariable(value="type") String type, Model model, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		
		int isSocial = principalDetails.getUser().getIsSocial();
		model.addAttribute("userType", principalDetails.getUser().getUserType());
		
		if( isSocial == 0 ) {
			//hidden 타입으로 받아서 my.js에서 editInfo로 보낼 때 type이랑 같이 보내야됨.
			return "my/infoCheck";
		}else {
			return "redirect:/user/editInfo/"+type ;
		}
	}
	
	@GetMapping("user/editInfo/{type}")
	public String editInfo(@PathVariable(value="type") String type, Model model,  @AuthenticationPrincipal PrincipalDetails principalDetails) {
		model.addAttribute("user", principalDetails.getUser());
		System.out.println(type);
		
		return "my/edit_info_"+type;
	}
	
	// test
//	@GetMapping("user/infoCheck")
//	public String infoCheck(Model model,  @AuthenticationPrincipal PrincipalDetails principalDetails) {
//		model.addAttribute("user", principalDetails.getUser());
//		return "my/edit_info_indi";
//	}
	
}
