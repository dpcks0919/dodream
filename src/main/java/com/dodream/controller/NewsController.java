package com.dodream.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.dodream.config.auth.PrincipalDetails;
import com.dodream.service.NewsService;


@Controller
public class NewsController {
	
	@Autowired
	private NewsService newsService;
	
	//	요청하기 페이지 
	@GetMapping("user/news/newsList")
	public String news(Model model, @PageableDefault(size=5, sort="id", direction= Sort.Direction.DESC) Pageable pageable, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		model.addAttribute("newsList", newsService.readNewsList(pageable));
		model.addAttribute("recentNews", newsService.recentNewsList());
		model.addAttribute("user", principalDetails.getUser());
		return "news/news_list";
	}
	
	@GetMapping("user/news/newsWrite")
	public String newsWrite() {
		return "news/news_write";
	}

}
