package com.dodream.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.dodream.model.News;

public interface NewsRepository extends JpaRepository<News, Integer>{
	
}
