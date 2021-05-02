package com.dodream.listener;

import java.util.Date;

import javax.persistence.PreUpdate;

import org.springframework.transaction.annotation.Transactional;

import com.dodream.model.Request;
import com.dodream.model.RequestItem;
import com.dodream.model.StatusType;

import edu.emory.mathcs.backport.java.util.concurrent.TimeUnit;

public class RequestListener {
	@Transactional
	@PreUpdate
    public void preUpdate(Request request) {
		// dueDate 변경시, 현재 날짜와 비교해서 urgentLevel을 1: 매우긴급(3일이내) / 2: 긴급(14일 이내) / 3: 보통(14일 이상) 으로 설정
		
		Date currDate = new Date();
		Date dueDate = request.getDueDate();
		
		long diffInMillies = dueDate.getTime() - currDate.getTime();
		long diffDays = TimeUnit.DAYS.convert(Math.abs(diffInMillies),  TimeUnit.MILLISECONDS);
		
		if(diffDays <= 3 || diffInMillies < 0) request.setUrgentLevel(1);	// 매우 긴급
		else if(diffDays > 3 && diffDays <= 14) request.setUrgentLevel(2);	// 긴급
		else if(diffDays > 14) request.setUrgentLevel(3);	//보통
    }
}