package com.dodream.controller.api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.dodream.config.auth.PrincipalDetails;
import com.dodream.dto.ResponseDto;
import com.dodream.model.Request;
import com.dodream.model.RequestItem;
import com.dodream.service.RequestService;

@RestController
public class RequestApiController {
	@Autowired
	private RequestService requestService;

	@PostMapping("/requestSaveProc")
	public ResponseDto<Request> save(@RequestBody Request request, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		Request newRequest = requestService.saveRequest(request,  principalDetails);
		return new ResponseDto<Request> (HttpStatus.OK.value(), newRequest);
	}
	
	@PostMapping("/requestItemSaveProc")
	public ResponseDto<Integer> saveItem(@RequestBody RequestItem requestItem, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		requestService.saveRequestItem(requestItem, principalDetails);
		return new ResponseDto<Integer> (HttpStatus.OK.value(), 1);
	}
}
