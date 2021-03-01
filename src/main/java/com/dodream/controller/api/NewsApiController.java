package com.dodream.controller.api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.dodream.config.auth.PrincipalDetails;
import com.dodream.dto.ResponseDto;
import com.dodream.model.News;
import com.dodream.service.NewsService;

@RestController
public class NewsApiController {
	@Autowired
	private NewsService newsService;
	
	@PostMapping("/newsSaveProc")
	public ResponseDto<Integer> newsSave(@RequestBody News news, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		System.out.println(news);
		newsService.saveNews(news, principalDetails);
		return new ResponseDto<Integer> (HttpStatus.OK.value(), 1);
	}
}
