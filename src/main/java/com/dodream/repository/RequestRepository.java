package com.dodream.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.dodream.model.ClientType;
import com.dodream.model.Request;
import com.dodream.model.User;
// 사회복지사의 요청 Form
public interface RequestRepository extends JpaRepository<Request, Integer>{
	Request[] findAllByClientType(ClientType clientType);
	
	@Query(value = "SELECT * FROM request where date(reg_date) >= date(subdate(now(), INTERVAL ?1 DAY)) and ( status = 'APPROVED' or status = 'CLOSED' )", nativeQuery = true)
	Page<Request> findRequestByInterval(int interval, Pageable pageable);
	
	@Query(value = "SELECT * FROM request where date(reg_date) >= date(subdate(now(), INTERVAL ?1 DAY)) and ( status = 'APPROVED' or status = 'CLOSED' )", nativeQuery = true)
	Request[] findRequestByInterval(int interval);
	
	@Query(value = "SELECT * FROM request where id= ?1 and date(reg_date) >= date(subdate(now(), INTERVAL ?2 DAY)) and ( status = 'APPROVED' or status = 'CLOSED' )", nativeQuery = true)
	Page<Request> findById(int id, int interval, Pageable pageable);

	@Query(value = "SELECT * FROM request where title like %?1% and date(reg_date) >= date(subdate(now(), INTERVAL ?2 DAY)) and ( status = 'APPROVED' or status = 'CLOSED' )", nativeQuery = true)
	Page<Request> findByTitleContaining(String title, int interval, Pageable pageable);

	@Query(value = "SELECT * FROM request where request_address like %?1% and date(reg_date) >= date(subdate(now(), INTERVAL ?2 DAY)) and ( status = 'APPROVED' or status = 'CLOSED' )", nativeQuery = true)
	Page<Request> findByRequestAddressContaining(String searchText, int interval, Pageable pageable);

	@Query(value = "SELECT * FROM request where urgent_level = ?1 and id = ?2 and date(reg_date) >= date(subdate(now(), INTERVAL ?3 DAY)) and ( status = 'APPROVED' or status = 'CLOSED' )", nativeQuery = true)
	Page<Request> findByUrgentLevelAndId(int urgentLevel, int id, int interval, Pageable pageable);

	@Query(value = "SELECT * FROM request where urgent_level = ?1 and title like %?2% and date(reg_date) >= date(subdate(now(), INTERVAL ?3 DAY)) and ( status = 'APPROVED' or status = 'CLOSED' )", nativeQuery = true)
	Page<Request> findByUrgentLevelAndTitleContaining(int urgentLevel, String searchText, int interval, Pageable pageable);

	@Query(value = "SELECT * FROM request where urgent_level = ?1 and request_address like %?2% and date(reg_date) >= date(subdate(now(), INTERVAL ?3 DAY)) and ( status = 'APPROVED' or status = 'CLOSED' )", nativeQuery = true)
	Page<Request> findByUrgentLevelAndRequestAddressContaining(int urgentLevel, String searchText, int interval, Pageable pageable);

	@Query(value = "SELECT * FROM request where urgent_level = ?1 and date(reg_date) >= date(subdate(now(), INTERVAL ?2 DAY)) and ( status = 'APPROVED' or status = 'CLOSED' )", nativeQuery = true)
	Page<Request> findByUrgentLevel(int urgentLevel, int interval, Pageable pageable);

	@Query(value = "SELECT * FROM request where client_type like %?1% and id = ?2 and date(reg_date) >= date(subdate(now(), INTERVAL ?3 DAY)) and ( status = 'APPROVED' or status = 'CLOSED' )", nativeQuery = true)
	Page<Request> findByClientTypeAndId(ClientType client, int id, int interval, Pageable pageable);

	@Query(value = "SELECT * FROM request where client_type like %?1% and title like %?2% and date(reg_date) >= date(subdate(now(), INTERVAL ?3 DAY)) and ( status = 'APPROVED' or status = 'CLOSED' )", nativeQuery = true)
	Page<Request> findByClientTypeAndTitleContaining(ClientType client, String searchText, int interval, Pageable pageable);

	@Query(value = "SELECT * FROM request where client_type like %?1% and request_address like %?2% and date(reg_date) >= date(subdate(now(), INTERVAL ?3 DAY)) and ( status = 'APPROVED' or status = 'CLOSED' )", nativeQuery = true)
	Page<Request> findByClientTypeAndRequestAddressContaining(ClientType client, String searchText, int interval, Pageable pageable);

	@Query(value = "SELECT * FROM request where client_type like %?1% and date(reg_date) >= date(subdate(now(), INTERVAL ?2 DAY)) and ( status = 'APPROVED' or status = 'CLOSED' )", nativeQuery = true)
	Page<Request> findByClientType(ClientType client, int interval, Pageable pageable);

	@Query(value = "SELECT * FROM request where client_type like %?1% and urgent_level = ?2 and id = ?3 and date(reg_date) >= date(subdate(now(), INTERVAL ?4 DAY)) and ( status = 'APPROVED' or status = 'CLOSED' )", nativeQuery = true)
	Page<Request> findByClientTypeAndUrgentLevelAndId(ClientType client, int urgentLevel, int id,
			int interval, Pageable pageable);

	@Query(value = "SELECT * FROM request where client_type like %?1% and urgent_level = ?2 and title like %?3% and date(reg_date) >= date(subdate(now(), INTERVAL ?4 DAY)) and ( status = 'APPROVED' or status = 'CLOSED' )", nativeQuery = true)
	Page<Request> findByClientTypeAndUrgentLevelAndTitleContaining(ClientType client, int urgentLevel,
			String searchText, int interval, Pageable pageable);

	@Query(value = "SELECT * FROM request where client_type like %?1% and urgent_level = ?2 and request_address like %?3% and date(reg_date) >= date(subdate(now(), INTERVAL ?4 DAY)) and ( status = 'APPROVED' or status = 'CLOSED' )", nativeQuery = true)
	Page<Request> findByClientTypeAndUrgentLevelAndRequestAddressContaining(ClientType client, int urgentLevel,
			String searchText, int interval, Pageable pageable);

	@Query(value = "SELECT * FROM request where client_type like %?1% and urgent_level = ?2 and date(reg_date) >= date(subdate(now(), INTERVAL ?3 DAY)) and ( status = 'APPROVED' or status = 'CLOSED' )", nativeQuery = true)
	Page<Request> findByClientTypeAndUrgentLevel(ClientType client, int urgentLevel, int interval, Pageable pageable);

	Request[] findByUser(User user);
	
	@Query(value = "SELECT * FROM request where id in ( select request_id from user_interest where user_id = ?1)", nativeQuery = true)
	Page<Request> readInterestRequestByUserId(int userId, Pageable pageable);

	Page<Request> findByUser(User user, Pageable pageable);
	
}