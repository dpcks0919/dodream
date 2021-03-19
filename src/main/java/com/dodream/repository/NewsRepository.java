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

	Page<News> findAllByDeleteFlag(Pageable pageable, int i);

	Page<News> findByNewsTypeAndDeleteFlag(NewsType valueOf, int i, Pageable pageable);

	@Query(value = "select * from news where delete_flag = ?1 order by reg_date desc", nativeQuery = true)
	List<News> findAllByDeleteFlagAndOrderByRegDateDesc(int id);
}
