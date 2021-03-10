package com.dodream.repository;

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

	Page<Request> findById(int id, Pageable pageable);

	Page<Request> findByTitleContaining(String id, Pageable pageable);

	Page<Request> findByRequestAddressContaining(String searchText, Pageable pageable);

	Page<Request> findByUrgentLevelAndId(int urgentLevel, int id, Pageable pageable);

	Page<Request> findByUrgentLevelAndTitleContaining(int urgentLevel, String searchText, Pageable pageable);

	Page<Request> findByUrgentLevelAndRequestAddressContaining(int urgentLevel, String searchText, Pageable pageable);

	Page<Request> findByUrgentLevel(int urgentLevel, Pageable pageable);

	Page<Request> findByClientTypeAndId(ClientType client, int id, Pageable pageable);

	Page<Request> findByClientTypeAndTitleContaining(ClientType client, String searchText, Pageable pageable);

	Page<Request> findByClientTypeAndRequestAddressContaining(ClientType client, String searchText, Pageable pageable);

	Page<Request> findByClientType(ClientType client, Pageable pageable);

	Page<Request> findByClientTypeAndUrgentLevelAndId(ClientType client, int urgentLevel, int id,
			Pageable pageable);

	Page<Request> findByClientTypeAndUrgentLevelAndTitleContaining(ClientType client, int urgentLevel,
			String searchText, Pageable pageable);

	Page<Request> findByClientTypeAndUrgentLevelAndRequestAddressContaining(ClientType client, int urgentLevel,
			String searchText, Pageable pageable);

	Page<Request> findByClientTypeAndUrgentLevel(ClientType client, int urgentLevel, Pageable pageable);

	Request[] findByUser(User user);

}
