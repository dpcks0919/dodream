package com.dodream.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class NewsController {
	//	요청하기 페이지 
	@GetMapping("news/newsList")
	public String news() {
		return "news/news_list";
	}

}
