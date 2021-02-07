package com.dodream.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {
	
	@GetMapping( {"/", "" } )
	public String index() {

		return "index";
	}
			
	@GetMapping("user/request") 
	public String userTest() {
		return "request/request_list";
	}
	
	
}
