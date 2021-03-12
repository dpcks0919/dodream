package com.dodream.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.dodream.model.Reply;
import com.dodream.model.Request;


public interface ReplyRepository extends JpaRepository<Reply, Integer>{

	Reply[] findByIdAndRequest(int id, Request request);

	Reply[] findByRequest(Request request);
	
	Page<Reply> findAllByUserId(int userId, Pageable pageable);

}
