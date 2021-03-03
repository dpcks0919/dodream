package com.dodream.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {
	
	@GetMapping( {"/", "" } )
	public String index() {

		return "index";
	}
	
	@GetMapping("/dodreamtouch")
	public  String dodreamtouch() {
		return "introduction/dodreamtouch";
	}
	
}
