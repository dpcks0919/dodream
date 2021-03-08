package com.dodream.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.dodream.model.News;
import com.dodream.model.NewsType;
import com.dodream.model.User;

public interface NewsRepository extends JpaRepository<News, Integer>{
	List<News> findAllByOrderByRegDateDesc ();

	Page<News> findByNewsType(NewsType newsType, Pageable pageable);
}
