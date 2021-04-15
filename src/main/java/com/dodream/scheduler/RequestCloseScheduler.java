package com.dodream.scheduler;

import java.sql.Timestamp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.dodream.model.Request;
import com.dodream.model.StatusType;
import com.dodream.repository.RequestRepository;

@Component
public class RequestCloseScheduler {	//automaticall CLOSE requests which are out of date
	@Autowired
	RequestRepository requestRepository;
	 
	@Transactional
	@Scheduled(fixedDelay = 1000 * 60 * 60)
	public void requestClose() {
		Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		
		Request[] approvedRequestList = requestRepository.findAllByStatus(StatusType.APPROVED);
				
		for(Request request : approvedRequestList) {
			if(timestamp.after(request.getDueDate())) request.setStatus(StatusType.CLOSED);
		}
	}
}
