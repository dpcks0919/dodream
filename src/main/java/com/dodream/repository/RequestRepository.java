package com.dodream.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.dodream.model.ClientType;
import com.dodream.model.Request;
// 사회복지사의 요청 Form
public interface RequestRepository extends JpaRepository<Request, Integer>{
	Request[] findAllByClientType(ClientType clientType);
}
