package com.dodream.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dodream.service.NewsService;

@Controller
public class MainController {
	
	@Autowired
	private NewsService newsService;
	
	@GetMapping( {"/", "" } )
	public String index(Model model) {
		model.addAttribute("recentNews", newsService.recentNewsList());
		return "index";
	}
	
	@GetMapping("/dodreamtouch")
	public  String dodreamtouch() {
		return "introduction/dodreamtouch";
	}
	
	@RequestMapping(value="/jusoPopup")
	public String jusoPopup() {
		return "join/jusoPopup";
	}
	
	@RequestMapping(value="/jusoPopupMobile")
	public String jusoPopupMobile() {
		return "join/jusoPopupMobile";
	}
}
