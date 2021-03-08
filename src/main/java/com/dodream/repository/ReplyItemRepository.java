package com.dodream.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.dodream.model.Reply;
import com.dodream.model.ReplyItem;

public interface ReplyItemRepository extends JpaRepository<ReplyItem, Integer>{

	ReplyItem[] findByReply(Reply reply);

}
