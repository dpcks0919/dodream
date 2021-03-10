package com.dodream.repository;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.dodream.model.RoleType;
import com.dodream.model.User;

public interface UserRepository extends JpaRepository<User, Integer>{

	public User findByLoginId(String loginId);

	@Transactional
	@Modifying
	@Query(value = " update user set login_count = login_count + 1 where id = ?1 ", nativeQuery = true)
	public void increaseLoginCount(int id);

	public User findByLoginIdAndLoginPassword(String loginId, String loginPassword);

	public User[] findByUserTypeAndShowFlag(RoleType userType, int showFlag);

	@Query(value = "SELECT * FROM user WHERE (user_type='GROUP' OR user_type = 'INDIVIDUAL') AND state_flag = 'APPROVED' AND (msg_flag = 1 OR email_flag = 1)", nativeQuery = true)
	public User[] findValidUser();

	public User findByUserEmail(String email);
	
	public User findByLoginIdAndUserEmail(String id, String email);
	
}
