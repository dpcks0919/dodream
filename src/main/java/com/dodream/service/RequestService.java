package com.dodream.service;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Service;

import com.dodream.config.auth.PrincipalDetails;
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
		requestRepository.save(request);
		return request;
	}
	
	@Transactional
	public void saveRequestItem(RequestItem requestItem, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		requestItemRepository.save(requestItem);
	}
}
