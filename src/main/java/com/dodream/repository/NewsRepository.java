package com.dodream.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.dodream.model.News;
import com.dodream.model.NewsType;

public interface NewsRepository extends JpaRepository<News, Integer>{
	List<News> findAllByOrderByRegDateDesc ();

	Page<News> findByNewsType(NewsType newsType, Pageable pageable);

	@Modifying
	@Query(value = "update news set count = count+1 where id = ?1", nativeQuery = true)
	void increaseCount(int id);
}
