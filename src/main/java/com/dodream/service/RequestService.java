package com.dodream.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dodream.config.auth.PrincipalDetails;
import com.dodream.model.ClientType;
import com.dodream.model.Request;
import com.dodream.model.RequestItem;
import com.dodream.repository.RequestItemRepository;
import com.dodream.repository.RequestRepository;

@Service
public class RequestService {

	@Autowired
	private RequestRepository requestRepository;

	@Autowired
	private RequestItemRepository requestItemRepository;

	@Transactional
	public Request saveRequest(Request request, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		request.setUser(principalDetails.getUser());
		System.out.println("saveRequest");
		requestRepository.save(request);
		return request;
	}
	
	//@Transactional(readOnly = true)
	@Transactional
	public void saveRequestItem(RequestItem requestItem, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		requestItemRepository.save(requestItem);
		System.out.println("saveRequestItem");
	}
	
	@Transactional(readOnly = true)
	public Page<Request> readRequestList(Pageable pageable) {
		return requestRepository.findAll(pageable);
	}
	
	
	@Transactional
	public Request[] requestListProcService() {
		Request[] requestList = requestRepository.findAllByDeleteFlag(0);
		return requestList;
	}

	@Transactional
	public Request[] markProcService(String clientType) {
		
		Request[] requestList = requestRepository.findAllByClientType(ClientType.valueOf(clientType));
//		for (int i = 0; i < requestList.length; i++) {
//			System.out.println(requestList[i].getRequestAddress());
//		}
		return requestList;
	}
	
	@Transactional
	public Request viewDetail(int id) {
		return requestRepository.findById(id)
				.orElseThrow(()->{
					return new IllegalArgumentException("글 상세보기 실패 : 아이디를 찾을 수 없습니다.");
				});
	}
	
}
