package com.dodream.service;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

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
import com.dodream.model.UserInterest;
import com.dodream.repository.RequestItemRepository;
import com.dodream.repository.RequestRepository;

@Service
public class RequestService {

	@Autowired
	private RequestRepository requestRepository;

	@Autowired
	private RequestItemRepository requestItemRepository;
	
//	@Autowired
//	private UserInterestRepository userInterestRepository;
	
	@Transactional
	public Request saveRequest(Request request, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		
		int urgentLevel = request.getUrgentLevel();
		
		request.setUser(principalDetails.getUser());
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		if(urgentLevel == 1 ) {
			cal.add(Calendar.DATE, 5);
		}else if(urgentLevel == 2 ) {
			cal.add(Calendar.DATE, 14);
		}else if(urgentLevel == 3 ) {
			cal.add(Calendar.MONTH, 1);
		}
		request.setDueDate(java.sql.Timestamp.valueOf(df.format(cal.getTime()) ));
		System.out.println("saveRequest");
		requestRepository.save(request);
		return request;
	}

	// @Transactional(readOnly = true)
	@Transactional
	public void saveRequestItem(RequestItem requestItem) {
		requestItemRepository.save(requestItem);
		System.out.println("saveRequestItem");
	}
	
//	@Transactional
//	public void saveHeart(UserInterest userInterest, @AuthenticationPrincipal PrincipalDetails principalDetails)
//		userInterest.setUser(principalDetails.getUser());
//		
//		userInterestRepository.save();
//	}
	
	
	//new
	@Transactional
	public int addRequestItem(RequestItem requestItem, int addNum) {
		int receivedNum = requestItem.getReceivedNum();
		int itemNum = requestItem.getItemNum();
		
		if(itemNum >= receivedNum + addNum) {
			requestItem.setReceivedNum(receivedNum + addNum);
			return 1;
		} else {
			return 0;
		}
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
		return requestList;
	}

	@Transactional
	public Request getRequest(int id) {
		return requestRepository.findById(id).orElseThrow(() -> {
			return new IllegalArgumentException("요청글 가져오기 실패 : 아이디를 찾을 수 없습니다.");
		});
	}
	
	@Transactional
	public RequestItem getRequestItem(int id) {
		return requestItemRepository.findById(id).orElseThrow(() -> {
			return new IllegalArgumentException("요청 아이템 가져오기 실패 : 아이디를 찾을 수 없습니다.");
		});
	}


}
