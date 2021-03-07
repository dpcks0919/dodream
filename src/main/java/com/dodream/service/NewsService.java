package com.dodream.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dodream.config.auth.PrincipalDetails;
import com.dodream.model.News;
import com.dodream.model.NewsType;
import com.dodream.repository.NewsRepository;

@Service
public class NewsService {

	@Autowired
	private NewsRepository newsRepository;
	
	@Transactional
	public void saveNews(News news, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		news.setUser(principalDetails.getUser());
		newsRepository.save(news);
	}
	
	@Transactional(readOnly = true)
	public Page<News> readNewsList(String type, Pageable pageable) {
		if(type.equals("ALL")) {
			return newsRepository.findAll(pageable);			
		} else {
			return newsRepository.findByNewsType(NewsType.valueOf(type), pageable);
		}
	}
	
	
	public List<News> recentNewsList() {
		return newsRepository.findAllByOrderByRegDateDesc();
	}

	public News readNewsOne(int id) {
		System.out.println("id : " + id);
		// TODO Auto-generated method stub
		return newsRepository.findById(id).orElseThrow(() -> {
			return new IllegalArgumentException("소식 가져오기 실패 : 아이디를 찾을 수 없습니다.");
		});
	}
}
