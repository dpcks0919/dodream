package com.dodream.controller;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.dodream.config.auth.PrincipalDetails;

@Controller
public class UserController {
	
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

}