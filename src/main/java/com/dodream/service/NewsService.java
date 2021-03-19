package com.dodream.service;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
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
			return newsRepository.findAllByDeleteFlag(pageable, 0);			
		} else {
			return newsRepository.findByNewsTypeAndDeleteFlag(NewsType.valueOf(type), 0,pageable);
		}
	}
	
	
	public List<News> recentNewsList() {
		return newsRepository.findAllByDeleteFlagAndOrderByRegDateDesc(0);
	}

	public News readNewsOne(int id) {
		// TODO Auto-generated method stub
		return newsRepository.findById(id).orElseThrow(() -> {
			return new IllegalArgumentException("소식 가져오기 실패 : 아이디를 찾을 수 없습니다.");
		});
	}
	
	@Transactional
	public void update(News news) {
		System.out.println("id : " + news.getId());
		System.out.println(news);
		News persistance = newsRepository.findById(news.getId()).orElseThrow(() -> {
			return new IllegalArgumentException("소식 가져오기 실패 : 아이디를 찾을 수 없습니다.");
		});
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		persistance.setTitle(news.getTitle());
		persistance.setContent(news.getContent());
		persistance.setNewsType(news.getNewsType());
		persistance.setCount(news.getCount());
		persistance.setUpdateDate(java.sql.Timestamp.valueOf(df.format(cal.getTime())));
	}

	@Transactional
	public void increaseCount(int id) {
		newsRepository.increaseCount(id);
	}

	@Transactional
	public void delete(int id) {
		News persistance = newsRepository.findById(id).orElseThrow(() -> {
			return new IllegalArgumentException("소식 가져오기 실패 : 아이디를 찾을 수 없습니다.");
		});
		
		persistance.setDeleteFlag(1);
	}
}
