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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.dodream.config.auth.PrincipalDetails;
import com.dodream.service.NewsService;


@Controller
public class NewsController {
	
	@Autowired
	private NewsService newsService;
	
//	@GetMapping("user/news/newsList")
	@RequestMapping(value = "news/newsList", method= {RequestMethod.GET, RequestMethod.POST})
	public String newsList(Model model, @RequestParam(defaultValue="ALL", value="type") String type, @PageableDefault(size=5, sort="id", direction= Sort.Direction.DESC) Pageable pageable, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		if(type.equals("ALL")) {
			model.addAttribute("newsList", newsService.readNewsList("ALL", pageable));
			model.addAttribute("ntype","ALL");
		} else {
			model.addAttribute("newsList", newsService.readNewsList(type, pageable));
			model.addAttribute("ntype",type);
		}
		model.addAttribute("recentNews", newsService.recentNewsList());
		return "news/news_list";
	}
	
	@GetMapping("news/newsDetail/{id}")
	public String newsDetail(Model model, @PathVariable(value="id") int id) {
		newsService.increaseCount(id);
		model.addAttribute("newsDetail", newsService.readNewsOne(id));
		return "news/news_detail";
	}
	
	@GetMapping("admin/news/newsEdit/{id}")
	public String newsEdit(Model model, @PathVariable(value="id") int id, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		model.addAttribute("user", principalDetails.getUser());
		model.addAttribute("newsDetail", newsService.readNewsOne(id));
		return "news/news_edit";
	}
	
	@GetMapping("admin/news/newsWrite")
	public String newsWrite(Model model, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		model.addAttribute("user", principalDetails.getUser());
		return "news/news_write";
	}

}
