package com.dodream.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TestController {
	

	@GetMapping("/test/mapTest")
	public String mapTest() {

		return "test/mapTest";
	}
	
}
