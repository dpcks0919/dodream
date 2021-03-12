package com.dodream.repository;

import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.dodream.model.ClientType;
import com.dodream.model.Request;
import com.dodream.model.User;
// 사회복지사의 요청 Form
public interface RequestRepository extends JpaRepository<Request, Integer>{
	Request[] findAllByClientType(ClientType clientType);

	Request[] findAllByDeleteFlag(int i);

	Request[] findByUser(User user);

	Page<Request> findByUser(User user, Pageable pageable);

}
