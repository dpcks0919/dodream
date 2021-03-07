package com.dodream.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.dodream.model.RequestItem;
import com.dodream.model.User;

public interface RequestItemRepository extends JpaRepository<RequestItem, Integer>{


}
