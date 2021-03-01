package com.dodream.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dodream.config.auth.PrincipalDetails;
import com.dodream.model.News;
import com.dodream.repository.NewsRepository;

@Service
public class NewsService {

	@Autowired
	private NewsRepository newsRepository;
	
	@Transactional
	public void saveNews(News news, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		news.setUser(principalDetails.getUser());
		newsRepository.save(news);
		System.out.println(news);
	}
	
	@Transactional(readOnly = true)
	public Page<News> readNewsList(Pageable pageable) {
		return newsRepository.findAll(pageable);
	}
}
