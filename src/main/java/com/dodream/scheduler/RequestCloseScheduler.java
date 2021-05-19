package com.dodream.scheduler;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;

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
	@Scheduled(cron = "0 0 0 * * *")	 //매일 0시에 실행
	public void requestClose() {		
		Timestamp curTimestamp = new Timestamp(System.currentTimeMillis());
        Timestamp compareTimestamp = new Timestamp(curTimestamp.getYear(), curTimestamp.getMonth(), curTimestamp.getDate(), 0, 0, 0, 0);	// 날짜 기준으로 

		Request[] approvedRequestList = requestRepository.findAllByStatus(StatusType.APPROVED);
		System.out.println(compareTimestamp);
				
		for(Request request : approvedRequestList) {
			if(compareTimestamp.after(request.getDueDate())) request.setStatus(StatusType.CLOSED);
		}
	}
}
