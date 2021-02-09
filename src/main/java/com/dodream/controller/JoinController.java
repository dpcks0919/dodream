package com.dodream.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class JoinController {
	
	@GetMapping("/loginForm")
	public String loginForm() {
		return "login/loginForm2";
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
		System.out.println(type);
		return "join/reg_"+type; 
	}
	
	@RequestMapping(value="/jusoPopup")
	public String jusoPopup() {
		return "join/jusoPopup";
	}

}
