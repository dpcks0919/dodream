package com.dodream.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.dodream.model.UserInterest;

public interface UserInterestRepository extends JpaRepository<UserInterest, Integer> {

	UserInterest findByUserIdAndRequestId(int id, int id2);

	boolean existsByUserIdAndRequestId(int userId, int requestId);

}
