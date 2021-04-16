package com.dodream.listener;

import java.util.List;

import javax.persistence.PreUpdate;

import org.springframework.transaction.annotation.Transactional;

import com.dodream.model.Request;
import com.dodream.model.RequestItem;
import com.dodream.model.StatusType;

public class RequestItemListener {
	@Transactional
	@PreUpdate
    public void preUpdate(RequestItem requestItem) {
		boolean isClosed = true;
		Request request = requestItem.getRequest();
		List<RequestItem> requestItemList = request.getRequestItem();
		
		if(requestItem.getItemNum() == requestItem.getReceivedNum()) {
			for(RequestItem item : requestItemList) {
				if(item.getItemNum() - item.getReceivedNum() > 0) {	// not closed yet
					isClosed = false;
					break;
				}
			} 
		}
		else isClosed = false;
		
		if(isClosed) request.setStatus(StatusType.CLOSED);
		else request.setStatus(StatusType.APPROVED);
    }
}
