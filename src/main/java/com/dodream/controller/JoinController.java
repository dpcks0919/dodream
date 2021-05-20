package com.dodream.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class JoinController {
	
	@GetMapping("/loginForm")
	public String loginForm() {
		return "login/loginForm";
	}
	
	@GetMapping("/findInfoForm")
	public String findInfoForm() {
		return "join/find_info";
	}
	
	@GetMapping("/joinForm")
	public String joinFormSelect() {
		return "join/reg_select";
	}
	
	@GetMapping("/joinFormMain")
	public String joinFormMain() {
		return "join/reg_main";
	}
	
	@GetMapping("/joinFormMain_s")
	public String joinFormMain_s() {
		return "join/reg_main_s";
	}
	
	@GetMapping("/joinForm/{type}")
	public String joinForm(@PathVariable(value="type") String type) {
		return "join/reg_"+type; 
	}
	
	@GetMapping("/joinForm_privacy/{page}")
	public String joinForm_privacy(Model model, @PathVariable(value="page") String page) {
		model.addAttribute("page", page);
		return "join/privacy";
	}
	
	@GetMapping("/joinForm_privacy_s")
	public String joinForm_privacy_s(Model model) {
		return "join/privacy_s";
	}
	
}
